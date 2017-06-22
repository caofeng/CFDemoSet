//
//  WSIndexBanner.m
//  WSCycleScrollView
//
//  Created by iMac on 16/8/10.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import "WSIndexBanner.h"

@implementation WSIndexBanner

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.mainImageView];
    }
    
    return self;
}

- (UIImageView *)mainImageView {
    
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(3, 0, self.bounds.size.width-6, self.bounds.size.height)];
        _mainImageView.userInteractionEnabled = YES;
    }
    return _mainImageView;
}

- (UIView *)bgView {
    
    if (!_bgView) {
       
        _bgView = [[UIView alloc]initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}


@end
