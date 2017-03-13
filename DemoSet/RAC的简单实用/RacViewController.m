//
//  RacViewController.m
//  DemoSet
//
//  Created by Apple on 16/11/17.
//  Copyright © 2016年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "RacViewController.h"
#import "ReactiveCocoa.h"
#import "Table_RacViewController.h"

@interface RacViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField1;
@property (weak, nonatomic) IBOutlet UITextField *textField2;
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, copy) NSString             *name;

@end

@implementation RacViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.name = @"曹峰";
    
    //ReactiveCocoa gitHub 网站：https://github.com/ReactiveCocoa/ReactiveObjC
    
    //ReactiveCocoa主要类RACSiganl,RAC的用法远不止下面几种情况
    
    
    [RACObserve(self, name) subscribeNext:^(NSString *newName) {
        NSLog(@"====%@",newName);
    }];
    
    //监听文本框输入
    [self.textField1.rac_textSignal subscribeNext:^(NSString *text) {
        NSLog(@"--%@",text);
    }];
    
    //监听文本的绑定事件
    [[self.textField2 rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(UITextField *textField) {
        NSLog(@"---%@",textField.text);
    }];
    
    
    //下面这个情况倒也很常用
    RAC(self.button,enabled) = [RACSignal combineLatest:@[self.textField1.rac_textSignal,self.textField2.rac_textSignal] reduce:^ (NSString *text1,NSString *text2) {
        return @(text1.length>0 && text2.length>0);
    }];
    
    
    //监听按钮被点击
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        
        NSLog(@"登录按钮被点击了");
        
        self.name = @"曹亚飞";
        
    }];
    
    //监听通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(NSNotification *notice) {
        NSLog(@"键盘弹起了");
    }];
    
    
    //代替KVO，监听属性改变
    [[self rac_valuesAndChangesForKeyPath:@"name" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld observer:nil] subscribeNext:^(NSArray *array) {
        NSDictionary *change = array[1];
        NSLog(@"----%@---%@",change[@"old"],change[@"new"]);
        
    }];
    
    //代替 代理，RAC实现代理 代码量和原生代理 差不多，现在也很少使用代理了，此处略。。。
    
    //常用的宏
    //RACObserve(<#TARGET#>, <#KEYPATH#>)
    
    //RAC最常用的还是监听 tableView,ScrollView,CollectionView的偏移量，见下一篇
    
    
}
- (IBAction)nextPageClick:(id)sender {
    
    [self.view endEditing:YES];
    
    Table_RacViewController *vc =[[Table_RacViewController alloc]initWithNibName:@"Table_RacViewController" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
