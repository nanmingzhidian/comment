//
//  CustomCell.m
//  comment
//
//  Created by ykse on 14-5-20.
//  Copyright (c) 2014年 ykse. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize image;
@synthesize name;
@synthesize dec;
@synthesize loc;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setImage:(UIImage *)img {
    if (![img isEqual:image]) {
        image = [img copy];
        self.userImageView.image = image;
    }
}

-(void)setName:(NSString *)n {
    if (![n isEqualToString:name]) {
        name = [n copy];
        self.nameLabel.text = name;
    }
}

-(void)setDec:(NSString *)d {
    if (![d isEqualToString:dec]) {
        dec = [d copy];
        self.decLabel.text = dec;
    }
}

-(void)setLoc:(NSString *)l {
    if (![l isEqualToString:loc]) {
        loc = [l copy];
        self.locLabel.text = loc;
    }
}

@end
