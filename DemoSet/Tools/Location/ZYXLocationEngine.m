//
//  ZYXLocationEngine.m
//
//  Copyright © 2016 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "Macros.h"
#import "ZYXLocationEngine.h"
#import "BlocksKit.h"

NS_ASSUME_NONNULL_BEGIN

static const CGFloat kLocationWindageMeter = 1000.0f;       //误差1000m
static const CGFloat kLocationWindageTime = 60.0;           //2次定位时间间隔60毫秒
static const CGFloat kLocationTimerOutSeconds = 40.0f;      //定位的超时时间


@interface ZYXLocationEngine() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) CLLocationCoordinate2D curCoordinate;
@property (nonatomic, weak, nullable) NSTimer *timeOutTimer;
@property (nonatomic, assign) BOOL isLocating;
@property (nonatomic, assign) BOOL alreadyLocated;

@end


@implementation ZYXLocationEngine

#pragma mark - Life Cycle

- (void)dealloc {
    
    [_locationManager stopUpdatingLocation];
    
    if (_timeOutTimer) {
        [_timeOutTimer invalidate];
        _timeOutTimer = nil;
    }
}

#pragma mark -- Initializer Methods

+ (instancetype)sharedLocationEngine {
    
    static id sharedLocationEngine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedLocationEngine = [[self alloc] init];
    });
    return sharedLocationEngine;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        _curCoordinate = kCLLocationCoordinate2DInvalid;
    }
    
    return self;
}

#pragma mark - Public Methods
- (void)startLocationEngine {
    
    if (![CLLocationManager locationServicesEnabled]) {
        return;
    }
    
    //确保只定位一次
    if (CLLocationCoordinate2DIsValid(self.curCoordinate) || self.isLocating) {
        return;
    }
    
    self.alreadyLocated = NO;
    self.isLocating = YES;
    [self.locationManager startUpdatingLocation];
    
    //启用超时机制
    [self startTimeOutTimer];
}

- (void)stopLocationEngine {
    
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Pravite Mothds
- (void)locationEnding {
    
    self.alreadyLocated = YES;
    self.isLocating = NO;
    [self.locationManager stopUpdatingLocation];
    
    [self stopTimeOutTimer];
}

- (void)startTimeOutTimer {
    
    [self stopTimeOutTimer];
    WEAKSELF
    self.timeOutTimer = [NSTimer bk_scheduledTimerWithTimeInterval:kLocationTimerOutSeconds block:^(NSTimer *timer) {
        [weakself locationEnding];
    } repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:self.timeOutTimer forMode:NSRunLoopCommonModes];
}

- (void)stopTimeOutTimer {
    
    if (_timeOutTimer) {
        [_timeOutTimer invalidate];
        _timeOutTimer = nil;
    }
}

#pragma mark - CLLocatinManager Delegate
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *newLocation = [locations lastObject];
    //NSLog(@"New Location: Lat:%f, Lon:%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    if (newLocation.horizontalAccuracy > kLocationWindageMeter) {
        //NSLog(@"Ignoring more than %f meters inaccurate :%f", kLocationWindageMeter, newLocation.horizontalAccuracy);
        return;
    }
    
    NSTimeInterval howRecent = [newLocation.timestamp timeIntervalSinceNow];
    if (ABS(howRecent) > kLocationWindageTime) {
        //NSLog(@"Ignoring location more than %f seconds old(cached) :%f", kLocationWindageTime, ABS(howRecent));
        return;
    }
    
    if (!self.alreadyLocated) {
        self.curCoordinate = newLocation.coordinate;
        NSLog(@"Current Location：Lat:%f, Lon:%f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
        
        [self locationEnding];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError*)error {
    
    [self locationEnding];
}

#pragma mark - Lazy Properties

- (CLLocationManager *)locationManager {
    
    if(!_locationManager) {
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if (IOS_VERSION_8_OR_ABOVE) {
            [_locationManager requestWhenInUseAuthorization];
            [_locationManager requestAlwaysAuthorization];
        }
    }
    return _locationManager;
}

@end

NS_ASSUME_NONNULL_END
