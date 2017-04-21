//
//  Macros.h
//  DemoSet
//
//  Created by CaoFeng on 2017/4/21.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "CFTool.h"

#ifndef Macros_h
#define Macros_h


#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000 // 当前Xcode支持iOS8及以上
#define SCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
#define SCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
#define SCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)
#else
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#endif

// MainScreen Height&Width
#define kScreen_Width   [UIScreen mainScreen].bounds.size.width
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

// MainScreen bounds
#define Main_Screen_Bounds [[UIScreen mainScreen] bounds]

//导航栏高度
#define kStatusBarHeight 64

//底部栏高度
#define kTabBarHeight 49.0f


// 是否空对象
#define IS_NULL_CLASS(OBJECT) [OBJECT isKindOfClass:[NSNull class]]


//App版本号
#define appMPVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
//系统版本
#define kSystemVersion ([[UIDevice currentDevice] systemVersion])
//应用名
#define kAPPName [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

////////////iOS系统版本判断宏定义////////////
#define IOS_VERSION_5_OR_ABOVE (([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 5)? (YES):(NO))
#define IOS_VERSION_6_OR_ABOVE (([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 6)? (YES):(NO))
#define IOS_VERSION_7_OR_ABOVE (([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 7)? (YES):(NO))
#define IOS_VERSION_8_OR_ABOVE (([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 8)? (YES):(NO))
#define IOS_VERSION_9_OR_ABOVE (([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 9)? (YES):(NO))
#define IOS_VERSION_10_OR_ABOVE (([[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue] >= 10)? (YES):(NO))

#define IS_IPHONE_5_5 ( fabs( ( double )kScreenHeight - ( double )736 ) < DBL_EPSILON )
#define IS_IPHONE_4_7 ( fabs( ( double )kScreenHeight - ( double )667 ) < DBL_EPSILON )
#define IS_IPHONE_4_0 ( fabs( ( double )kScreenHeight - ( double )568 ) < DBL_EPSILON )
#define IS_IPHONE_3_5 ( fabs( ( double )kScreenHeight - ( double )480 ) < DBL_EPSILON )

/** 以Iphone5为基准，按比例约束x坐标 */
#define ScaleConstraintForX(x) x*kScreenWidth/320
/** 以Iphone5为基准，按比例约束宽度 */
#define ScaleConstraintForWidth(w) w*kScreenWidth/320
/** 以Iphone5为基准，按比例约束y坐标 */
#define ScaleConstraintForY(y) y*kScreenHeight/568
/** 以Iphone5为基准，按比例约束高度 */
#define ScaleConstraintForHeight(h) h*kScreenHeight/568


/** 以Iphone6为基准，按比例约束高度 */
#define ScaleConstraintForHeightBaseOniPhone6(h) h*kScreenHeight/667
/** 以Iphone6为基准，按比例约束x坐标 */
#define ScaleConstraintForXBaseOnDevice4_7(x) x*kScreenWidth/375.0f
/** 以Iphone6为基准，按比例约束宽度 */
#define ScaleConstraintForWidthBaseOnDevice4_7(w) w*kScreenWidth/375.0f
/** 以Iphone6为基准，按比例约束y坐标 */
#define ScaleConstraintForYBaseOnDevice4_7(y) y*kScreenHeight/667.0f
/** 以Iphone6为基准，按比例约束高度 */
#define ScaleConstraintForHeightBaseOnDevice4_7(h) h*kScreenHeight/667.0f


//AppDelegate对象
#define AppDelegateInstance [[UIApplication sharedApplication] delegate]

//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]

//在Global Queue上运行
#define DISPATCH_ON_GLOBAL_QUEUE_HIGH(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_DEFAULT(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_LOW(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), globalQueueBlocl);
#define DISPATCH_ON_GLOBAL_QUEUE_BACKGROUND(globalQueueBlocl) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), globalQueueBlocl);


//GCD - 一次性执行
#define kDISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define kDISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define kDISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


//弱引用/强引用
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;
#define kStrongSelf(type)  __strong typeof(type) type = weak##type;

#define WEAKSELF kWeakSelf(self)

//开发Log
#ifdef DEBUG
#define NSLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define NSLog(...)
#endif


//设置 view 圆角和边框
#define kViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define kWindow [UIApplication sharedApplication].keyWindow

//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否为iPhone
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
//判断是否为iPad
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//判断是否为ipod
#define IS_IPOD ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif
#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


//颜色

#define kRGB(color) kRGBH(color,1.0)

#define kRGBH(color,alpha) [CFTool colorWithHexString:color alpha:alpha];



#endif /* Macros_h */
