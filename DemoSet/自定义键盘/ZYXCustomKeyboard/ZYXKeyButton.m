//
//  ZYXKeyButton.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "ZYXKeyButton.h"
#import "ZYXSizeScale.h"
#import "Masonry.h"

@interface ZYXKeyButton ()

@property (nonatomic, strong) UIImageView *keyPopImageView;

@end

@implementation ZYXKeyButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (instancetype)init {
    
    __block ZYXKeyButton *weakSelf = self;
    
    self = [super init];
    if (self) {
        [self addSubview:self.titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(weakSelf);
        }];
    }
    
    return self;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:22];
    }
    
    return _titleLabel;
}

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    [self showPopupToButton];
    
    if (self.selectBackgroundColor) {
        self.backgroundColor = self.selectBackgroundColor;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent: (UIEvent *)event {
    
    [super touchesEnded:touches withEvent:event];
    
    [self hidenPopupToButton];
    
    if ([self.delegate respondsToSelector:@selector(characterPressed:)]) {
        [self.delegate characterPressed:self.titleLabel.text];
    }
    if (self.normalBackgroundColor) {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

    [super touchesCancelled:touches withEvent:event];
    [self  hidenPopupToButton];
}

- (void)hidenPopupToButton {
    
    _keyPopImageView.hidden = YES;
}

- (void)showPopupToButton {
    
    if ([self.delegate popUpToButtonPosition:self] == ZYXNumberViewImageNone) {
        return;
    }
    
    if (!_keyPopImageView) {
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 52, 60)];
        
        _keyPopImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"keyboard_middle"]];
        
        if ([self.delegate popUpToButtonPosition:self] == ZYXNumberViewImageLeft) {
            _keyPopImageView.frame = CGRectMake(scaleX(-4), scaleY(-48), scaleX(_keyPopImageView.frame.size.width), scaleY(_keyPopImageView.frame.size.height));
            _keyPopImageView.image = [UIImage imageNamed:@"keyboard_left"];
            
        } else if([self.delegate popUpToButtonPosition:self] == ZYXNumberViewImageRight) {
            
            _keyPopImageView.frame = CGRectMake(scaleX(-20), scaleY(-48), scaleX(_keyPopImageView.frame.size.width), scaleY(_keyPopImageView.frame.size.height));
            _keyPopImageView.image = [UIImage imageNamed:@"keyboard_right"];
            
        } else {
            _keyPopImageView.frame = CGRectMake(scaleX(-11), scaleY(-48), scaleX(_keyPopImageView.frame.size.width), scaleY(_keyPopImageView.frame.size.height));
        }
        
        [text setFont:[UIFont systemFontOfSize:22]];
        [text setTextAlignment:NSTextAlignmentCenter];
        [text setAdjustsFontSizeToFitWidth:YES];
        [text setText:self.titleLabel.text];
        [text setTextColor:[UIColor blackColor]];
        
        _keyPopImageView.layer.shadowColor = [UIColor colorWithWhite:0.1 alpha:1.0].CGColor;
        _keyPopImageView.layer.shadowOffset = CGSizeMake(0, 2.0);
        _keyPopImageView.layer.shadowOpacity = 0.30;
        _keyPopImageView.layer.shadowRadius = 3.0;
        _keyPopImageView.clipsToBounds = NO;
        [_keyPopImageView addSubview:text];
        [self addSubview:_keyPopImageView];
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(_keyPopImageView);
            make.top.equalTo(_keyPopImageView).offset(scaleY(9));
        }];

    }
    _keyPopImageView.hidden = NO;
}




@end
