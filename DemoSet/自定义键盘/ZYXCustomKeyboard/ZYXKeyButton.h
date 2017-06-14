//
//  ZYXKeyButton.h
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZYXBaseKeyboardView.h"

@class ZYXKeyButton;

@protocol ZYXKeyboardKeyButtonDelegate <NSObject>

@optional
- (void)showPopupToButton:(UIView *)b;
- (void)hidePopupToButton:(UIView *)b;
- (void)characterPressed:(NSString *)charValue;
- (ZYXNumberViewImage)popUpToButtonPosition:(ZYXKeyButton *)button;

@end


/**
 *  键盘按钮
 */
@interface ZYXKeyButton : UIView

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) id<ZYXKeyboardKeyButtonDelegate> delegate;
@property (nonatomic, strong) UIColor *selectBackgroundColor;
@property (nonatomic, strong) UIColor *normalBackgroundColor;

- (void)showPopupToButton;

- (void)hidenPopupToButton;

@end
