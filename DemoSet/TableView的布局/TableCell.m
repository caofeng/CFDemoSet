//
//  TableCell.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "TableCell.h"
#import "Masonry.h"
@interface TableCell ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel     *label;

@end

@implementation TableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupViews];
        [self setupConstraints];
        
    }
    return self;
}

- (void)setupViews {
    self.textField = [[UITextField alloc]init];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.placeholder = @"这个类的信息量挺大的";
    [self.contentView addSubview:self.textField];
    
    self.label = [[UILabel alloc]init];
    self.label.numberOfLines = 0;
    [self.contentView addSubview:self.label];
    
}

- (void)setupConstraints {
    
    //如果希望 cell可以自动计算高度，其中的子控件要"充分约束"
    
    CGFloat Width = [UIScreen mainScreen].bounds.size.width;
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.height.equalTo(@30);
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textField.mas_bottom).offset(20);
        make.left.equalTo(@10);
        make.right.equalTo(@-10);
        make.bottom.equalTo(@-10).priorityLow();
    }];
    self.label.preferredMaxLayoutWidth = Width-20;
    
    
}

@end
