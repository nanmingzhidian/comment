//
//  CustomCell.h
//  comment
//
//  Created by ykse on 14-5-20.
//  Copyright (c) 2014年 ykse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *decLabel;
@property (weak, nonatomic) IBOutlet UILabel *locLabel;

@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *dec;
@property (copy, nonatomic) NSString *loc;

@end
