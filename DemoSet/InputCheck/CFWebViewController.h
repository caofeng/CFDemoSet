//
//  CFWebViewController.h
//  DemoSet
//
//  Created by CaoFeng on 17/3/14.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFWebViewController : UIViewController

+(instancetype)initRouteToViewControllerByURLString:(NSString *)url;

+(instancetype)initRouteToViewControllerByURLString:(NSString *)url withTitle:(NSString *)title;
+(instancetype)initRouteToViewControllerByHTMLString:(NSString *)html;

+(instancetype)initRouteToViewControllerByHTMLString:(NSString *)html withTitle:(NSString *)title;

@end
