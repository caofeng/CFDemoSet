//
//  CoordTableViewCell.m
//  DemoSet
//
//  Created by CaoFeng on 17/3/15.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CoordTableViewCell.h"

@interface CoordTableViewCell ()



@end

@implementation CoordTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        for (UIView *subView in self.contentView.subviews) {
            [subView removeFromSuperview];
        }
        
        self.cf_label = [[UILabel alloc]initWithFrame:CGRectMake(30, 10, 200, 30)];
        self.cf_label.textAlignment = NSTextAlignmentCenter;
        self.cf_label.text = @"这是个标签";
        [self.contentView addSubview:self.cf_label];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
