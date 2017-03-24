//
//  AppDelegate.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomWindow.h"
#import "UMMobClick/MobClick.h"
#import "BaiduMobStat.h"
#import <AdSupport/AdSupport.h>
#import "JPEngine.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@property (nonatomic, strong) CustomWindow *customWindow;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    NSLog(@"---UUID:%@",[UIDevice currentDevice].identifierForVendor.UUIDString);
    
   NSString *uuidStr =  [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"----%@",uuidStr);
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
   UIStoryboard *storeBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:[storeBoard instantiateInitialViewController]];
    self.window.rootViewController =nav;
    
    //自定义Window
    self.customWindow = [[CustomWindow alloc]initWithFrame:[UIScreen mainScreen].bounds completionBlock:^{
        [_customWindow resignKeyWindow];
        _customWindow = nil;
        [self.window makeKeyAndVisible];
    }];
    
    
    
    [self downFileFromServer];
    
    [self setUMStatistics];
    [self setBaiduStatistics];
    
    [self setTimerForeverWork];
    
    return YES;
}

- (void)setTimerForeverWork {
    
    NSError *setCategoryErr = nil;
    NSError *activationErr  = nil;
    [[AVAudioSession sharedInstance]
     setCategory: AVAudioSessionCategoryPlayback
     error: &setCategoryErr];
    [[AVAudioSession sharedInstance]
     setActive: YES
     error: &activationErr];
    
    
}

- (void)setUMStatistics {
    
    //Key
    UMConfigInstance.appKey = @"5837a2c0677baa6d5a002bba";
    UMConfigInstance.channelId = @"APP Store";
    
   
    UMConfigInstance.ePolicy = BATCH;
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setCrashReportEnabled:YES];
    [MobClick setAppVersion:version];
    
    
    [MobClick startWithConfigure:UMConfigInstance];
    
    //
}

- (void)setBaiduStatistics {
    
    [[BaiduMobStat defaultStat] startWithAppId:@"8a090985f8"];
    [BaiduMobStat defaultStat].shortAppVersion =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [BaiduMobStat defaultStat].monitorStrategy = BaiduMobStatMonitorStrategyAll;
    [BaiduMobStat defaultStat].sessionResumeInterval = 10;
    
}

- (void)downFileFromServer{
    [JPEngine startEngine];
    
    
    //测试用本地JS文件
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"main" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
    
    /*******************************************/
    
    /*
     //线上远程JS文件地址
     NSURL *URL = [NSURL URLWithString:@"ZYXR JS文件地址"];
     NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
     
     AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
     
     NSURLRequest *request = [NSURLRequest requestWithURL:URL];
     
     _downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
     //
     
     } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
     
     NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
     NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
     
     [JPEngine evaluateScriptWithPath:path];
     
     return [NSURL fileURLWithPath:path];
     
     
     } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
     //
     
     }];
     
     */
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.window endEditing:YES];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
