//
//  ViewController.h
//  comment
//
//  Created by ykse on 14-5-20.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *dataList;
//@property (strong, nonatomic) NSArray *imageList;
@property (strong, nonatomic) NSMutableArray *tmpDataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)show:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *film;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
