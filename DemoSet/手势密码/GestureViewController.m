
#import "GestureTextConst.h"
#import "GestureViewController.h"
#import "PCCircleView.h"
#import "PCCircleViewConst.h"
#import "PCLockLabel.h"
#import "PCCircleInfoView.h"
#import "PCCircle.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface GestureViewController ()<CircleViewDelegate>

/**
 *  重设按钮
 */
@property (nonatomic, strong) UIButton *resetBtn;

/**
 *  提示Label
 */
@property (nonatomic, strong) PCLockLabel *msgLabel;

/**
 *  解锁界面
 */
@property (nonatomic, strong) PCCircleView *lockView;

/**
 *  infoView
 */
@property (nonatomic, strong) PCCircleInfoView *infoView;

/**
 *  尝试次数
 */
@property (nonatomic, assign) NSInteger     verifyNum;

/**
 *  账号登录事件
 */
@property (nonatomic, copy) HeadlerEvent event;

/**
 *  手势成功？
 */
@property (nonatomic, copy) GestureSuccess success;


@end

@implementation GestureViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.type == GestureViewControllerTypeLogin) {
        
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }
    // 进来先清空存的第一个密码
    [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
}

- (instancetype)initWithGestureType:(GestureViewControllerType)type gestureSuccess:(GestureSuccess)success accountLoginHeadlerEvent:(HeadlerEvent)headlerEvent {
    
    self.type = type;
    self.success = success;
    self.event = headlerEvent;
    
    return [self init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_interactivePopDisabled = YES;
    [self.view setBackgroundColor:CircleViewBackgroundColor];
    // 1.界面相同部分生成器
    [self setupSameUI];
    // 2.界面不同部分生成器
    [self setupDifferentUI];
}

#pragma mark - 创建UIBarButtonItem
- (UIBarButtonItem *)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.frame = (CGRect){CGPointZero, {100, 20}};
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:17];
    button.tag = tag;
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [button setHidden:YES];
    self.resetBtn = button;
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

#pragma mark - 界面不同部分生成器
- (void)setupDifferentUI
{
    switch (self.type) {
        case GestureViewControllerTypeSetting:
            [self setupSubViewsSettingVc];
            break;
        case GestureViewControllerTypeLogin:
            [self setupSubViewsLoginVc];
            break;
        default:
            break;
    }
}

#pragma mark - 界面相同部分生成器
- (void)setupSameUI
{
    // 创建导航栏右边按钮
    self.navigationItem.rightBarButtonItem = [self itemWithTitle:@"重设" target:self action:@selector(didClickBtn:) tag:buttonTagReset];
    
    
    // 解锁界面
    PCCircleView *lockView = [[PCCircleView alloc] init];
    lockView.delegate = self;
    self.lockView = lockView;
    [self.view addSubview:lockView];
    
    //“绘制解锁图案”提示标签
    PCLockLabel *msgLabel = [[PCLockLabel alloc] init];
    msgLabel.frame = CGRectMake(0, 0, kScreenW, 14);
    msgLabel.center = CGPointMake(kScreenW/2, CGRectGetMinY(lockView.frame) - 20);
    self.msgLabel = msgLabel;
    [self.view addSubview:msgLabel];
}

#pragma mark - 设置手势密码界面
- (void)setupSubViewsSettingVc
{
    [self.lockView setType:CircleViewTypeSetting];
    
    self.title = kSetGesturePasswordNavbarTitle;
    
    [self.msgLabel showNormalMsg:gestureTextBeforeSet];
    
    PCCircleInfoView *infoView = [[PCCircleInfoView alloc] init];
    infoView.frame = CGRectMake(0, 0, CircleRadius * 2 * 0.6, CircleRadius * 2 * 0.6);
    infoView.center = CGPointMake(kScreenW/2, CGRectGetMinY(self.msgLabel.frame) - CGRectGetHeight(infoView.frame)/2 - 10);
    self.infoView = infoView;
    [self.view addSubview:infoView];
}

#pragma mark - 登陆手势密码界面
- (void)setupSubViewsLoginVc
{
    [self.lockView setType:CircleViewTypeLogin];
    
    // 头像
    UIImageView  *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(0, 0, 65, 65);
    imageView.center = CGPointMake(kScreenW/2, kScreenH/6);
    [imageView setImage:[UIImage imageNamed:@"head"]];
    [self.view addSubview:imageView];
    
    // 登录其他账户
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self creatButton:rightBtn frame:CGRectMake(kScreenW/4, self.lockView.frame.origin.y+self.lockView.frame.size.height+20, kScreenW/2, 20) title:kSetGestureAccountloginButtonTitle alignment:UIControlContentHorizontalAlignmentCenter tag:buttonTagForget];
}

#pragma mark - 创建UIButton
- (void)creatButton:(UIButton *)btn frame:(CGRect)frame title:(NSString *)title alignment:(UIControlContentHorizontalAlignment)alignment tag:(NSInteger)tag
{
    btn.frame = frame;
    btn.tag = tag;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kSetGestureButtonTitleColor forState:UIControlStateNormal];
    [btn setContentHorizontalAlignment:alignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [btn addTarget:self action:@selector(didClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

#pragma mark - button点击事件
- (void)didClickBtn:(UIButton *)sender
{
    
    switch (sender.tag) {
        case buttonTagReset:
        {
            NSLog(@"点击了重设按钮");
            
            // 1.隐藏按钮
            [self.resetBtn setHidden:YES];
            
            // 2.infoView取消选中
            [self infoViewDeselectedSubviews];
            
            // 3.msgLabel提示文字复位
            [self.msgLabel showNormalMsg:gestureTextBeforeSet];
            
            // 4.清除之前存储的密码
            [PCCircleViewConst saveGesture:nil Key:gestureOneSaveKey];
            
        }
            break;
        case buttonTagManager:
        {
            //NSLog(@"点击了忘记手势密码");
            
        }
            break;
        case buttonTagForget:
            
            [self dissGestureViewController:NO];
            
            if (self.event) {
                self.event();
            }
            
            break;
        default:
            break;
    }
}

#pragma mark - circleView - delegate
#pragma mark - circleView - delegate - setting

//链接少于4个点

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type connectCirclesLessThanNeedWithGesture:(NSString *)gesture
{
    NSString *gestureOne = [PCCircleViewConst getGestureWithKey:gestureOneSaveKey];

    // 看是否存在第一个密码
    if ([gestureOne length]) {
        [self.resetBtn setHidden:NO];
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
    } else {
        //NSLog(@"密码长度不合法%@", gesture);
        [self.msgLabel showWarnMsgAndShake:gestureTextConnectLess];
    }
}

//第一个手势合法

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetFirstGesture:(NSString *)gesture
{
    //NSLog(@"获得第一个手势密码%@", gesture);
    [self.msgLabel showWarnMsg:gestureTextDrawAgain];
    
    // infoView展示对应选中的圆
    [self infoViewSelectedSubviewsSameAsCircleView:view];
}

//第二个手势完成

- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteSetSecondGesture:(NSString *)gesture result:(BOOL)equal
{
    //NSLog(@"获得第二个手势密码%@",gesture);
    
    if (equal) {
        
        //NSLog(@"两次手势匹配！可以进行本地化保存了");
        
        [self.msgLabel showWarnMsg:gestureTextSetSuccess];
        [PCCircleViewConst saveGesture:gesture Key:gestureFinalSaveKey];
        
        [self dissGestureViewController:YES];
        
        if (self.type == GestureViewControllerTypeSetting) {
            //设置手势密码成功
            if (self.success) {
                self.success(YES);
            }
        }
        
    } else {
        
        //NSLog(@"两次手势不匹配！");
        [self.msgLabel showWarnMsgAndShake:gestureTextDrawAgainError];
        [self.resetBtn setHidden:NO];
    }
}

#pragma mark - circleView - delegate - login or verify gesture
- (void)circleView:(PCCircleView *)view type:(CircleViewType)type didCompleteLoginGesture:(NSString *)gesture result:(BOOL)equal
{
    // 此时的type有两种情况 Login or verify
    if (type == CircleViewTypeLogin) {
        
        if (equal) {
            
            [self dissGestureViewController:YES];
            if (self.success) {
                self.success(YES);
            }
            
        } else {
            
            self.verifyNum ++;
            
            if (self.verifyNum >= gestureTextGestureVerifyMaxErrorNum) {
                //迫使退出登录
                //[self.msgLabel showWarnMsgAndShake:@"错误次数过多"];
                [self dissGestureViewController:YES];
                if (self.success) {
                    self.success(NO);
                }
                
            } else {
                
                [self.msgLabel showWarnMsgAndShake:gestureTextGestureVerifyRestNum(self.verifyNum)];
            }
            //
            //NSLog(@"密码错误！");
            
        }
    } else if (type == CircleViewTypeVerify) {
        
        if (equal) {
            
            //NSLog(@"验证成功，跳转到设置手势界面");
            
        } else {
            
            //NSLog(@"原手势密码输入错误！");
            
        }
    }
}

#pragma mark - infoView展示方法
#pragma mark - 让infoView对应按钮选中
- (void)infoViewSelectedSubviewsSameAsCircleView:(PCCircleView *)circleView
{
    for (PCCircle *circle in circleView.subviews) {
        
        if (circle.state == CircleStateSelected || circle.state == CircleStateLastOneSelected) {
            
            for (PCCircle *infoCircle in self.infoView.subviews) {
                if (infoCircle.tag == circle.tag) {
                    [infoCircle setState:CircleStateSelected];
                }
            }
        }
    }
}

- (void)dissGestureViewController:(BOOL)animated {
    
    if (self.presentingViewController) {
        
        [self dismissViewControllerAnimated:animated completion:nil];
        
    } else {
        
        [self.navigationController popViewControllerAnimated:animated];
        
    }
}

#pragma mark - 让infoView对应按钮取消选中
- (void)infoViewDeselectedSubviews
{
    [self.infoView.subviews enumerateObjectsUsingBlock:^(PCCircle *obj, NSUInteger idx, BOOL *stop) {
        [obj setState:CircleStateNormal];
    }];
}

@end
