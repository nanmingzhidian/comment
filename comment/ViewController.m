//
//  ViewController.m
//  comment
//
//  Created by ykse on 14-5-20.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"
#import "SVPullToRefresh.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize dataList;
//@synthesize imageList;
@synthesize tmpDataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //加载plist文件的数据和图片
    NSString *path = [[NSBundle mainBundle] pathForResource:@"userinfo" ofType:@"plist"];
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    
    tmpDataArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[data count]; i++) {
        NSString *key = [[NSString alloc] initWithFormat:@"%d", i+1];
        NSDictionary *tmpDic = [data objectForKey:key];
        [tmpDataArray addObject:tmpDic];
    }
    self.dataList = [NSMutableArray arrayWithArray:tmpDataArray];
    
    //隐藏tableview
    self.tableView.hidden = YES;
    
    //拖cell
    __weak ViewController *weakSelf = self;
    
    // setup pull-to-refresh
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf insertRowAtTop];
    }];
    
    // setup infinite scrolling
    [self.tableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf insertRowAtBottom];
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidUnload
{
    self.dataList = nil;
}

#pragma mark - Actions
/*
- (void)setupDataSource {
    self.dataSource = [NSMutableArray array];
    for(int i=0; i<15; i++)
        [self.dataSource addObject:[NSDate dateWithTimeIntervalSinceNow:-(i*90)]];
}
*/
- (void)insertRowAtTop {
    __weak ViewController *weakSelf = self;
    
    int64_t delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.dataList insertObject:[tmpDataArray objectAtIndex:arc4random_uniform(13)] atIndex:0];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    });
}


- (void)insertRowAtBottom {
    __weak ViewController *weakSelf = self;
    
    int64_t delayInSeconds = 0.1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [weakSelf.tableView beginUpdates];
        [weakSelf.dataList addObject:[tmpDataArray objectAtIndex:arc4random_uniform(13)]];
        [weakSelf.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakSelf.dataList.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
        [weakSelf.tableView endUpdates];
        
        [weakSelf.tableView.infiniteScrollingView stopAnimating];
    });
}

#pragma mark -
#pragma mark Table Data Source Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CustomCellIdentifier = @"CustomCellIdentifier";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"CustomCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CustomCellIdentifier];
        nibsRegistered = YES;
    }
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CustomCellIdentifier];
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [self.dataList objectAtIndex:row];
    
    cell.name = [rowData objectForKey:@"name"];
    cell.dec = [rowData objectForKey:@"dec"];
    cell.loc = [rowData objectForKey:@"loc"];
    cell.image = [UIImage imageNamed:[[NSString alloc] initWithFormat:@"%@.jpg",[rowData objectForKey:@"image"]]];
    
    return cell;
}

#pragma mark Table Delegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (IBAction)show:(id)sender {
    //显示tableview
    self.tableView.hidden = !self.tableView.hidden;
    
    [UIView animateWithDuration:0.3f animations:^{
        //移动button
        CGRect temp = [self.button frame];
        if(!self.tableView.hidden)
        {
            temp.origin.y = 170;
        }else{
            temp.origin.y = 420;
        }
        [self.button setFrame:temp];
        //移动lable
        temp = [self.film frame];
        if(!self.tableView.hidden)
        {
            temp.origin.y = 190;
        }else{
            temp.origin.y = 440;
        }
        [self.film setFrame:temp];
        //移动tableview
        temp = self.tableView.frame;
        if(!self.tableView.hidden)
        {
            temp.origin.y = 210;
        }else{
            temp.origin.y = 480;
        }
        self.tableView.frame = temp;
    } completion:^(BOOL finished) {
        
    }];
}

@end
