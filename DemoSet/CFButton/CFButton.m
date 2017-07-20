//
//  CFButton.m
//  DemoSet
//
//  Created by CaoFeng on 2017/4/20.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFButton.h"
#import "CFProgressCircleView.h"
#import "Masonry.h"

@interface CFButton ()

@property (nonatomic, strong) UIButton  *button;
@property (nonatomic, strong) CFProgressCircleView  *progressView;
@property (nonatomic, copy) eventButton eventButton;
@property (nonatomic, copy) NSString    *title;


@end

@implementation CFButton

+ (instancetype)initWithTitle:(NSString *)title buttonHeadle:(eventButton)event {
    
    return [[self alloc] initWithTitle:title buttonHeadle:event];
    
}

- (instancetype)initWithTitle:(NSString *)title buttonHeadle:(eventButton)event {
    
    self = [super init];
    if (self) {
        
        self.eventButton = event;
        self.title = title;
        [self setupViews];
        [self setupConstraints];
    }
    
    return self;
}

- (void)setupViews{
    
    self.button =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setTitle:self.title forState:UIControlStateNormal];
    self.button.backgroundColor = [UIColor redColor];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.button];
    
    self.progressView = [[CFProgressCircleView alloc]init];
    [self addSubview:self.progressView];
    self.progressView.hidden = YES;
    
}

- (void)setupConstraints {
    
    CGSize size_ = [self.title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX).offset(size_.width/2+10);
        make.centerY.equalTo(@0);
        make.size.mas_equalTo(CGSizeMake(22, 22));
    }];
}

- (void)buttonClick {
    
    __block CFButton *weakSelf = self;

    if (self.eventButton) {
        weakSelf.eventButton();
    }
}

- (void)startAnimation {
    self.progressView.hidden = NO;
    [self.progressView startAnimation];
    
}
- (void)endAnimation {
    [self.progressView endAnimation];
    self.progressView.hidden = YES;
}

@end
