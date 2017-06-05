//
//  VagueViewController.m
//  DemoSet
//
//  Created by CaoFeng on 2017/6/2.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "VagueViewController.h"
#import <Accelerate/Accelerate.h>
#import "GPUImage.h"

@interface VagueViewController ()

@end

@implementation VagueViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"1.jpg"]];
    
    imageV.frame = CGRectMake(70, 100, 300, 400);
    
    [self.view addSubview:imageV];
    
    
    
    //1.ios7可使用以下方式添加毛玻璃效果
//    UIToolbar *toolBar1 = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 150, 200)];
//    toolBar1.barStyle = UIBarStyleDefault;
//    
//    [imageV addSubview:toolBar1];
//    
    
    
    
    //2.ios 8之后比较推荐使用以下方式添加毛玻璃效果
    
//    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
//    
//    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    
//    effectView.frame = CGRectMake(0, 0, imageV.frame.size.width * 0.5, imageV.frame.size.height);
//    
//    [imageV addSubview:effectView];
    
    
    //3. 使用vImage 实现滤镜效果
//    imageV.image = [self blurryImage:imageV.image withBlurLevel:0.5];
    
    
    //4.使用CIFilter实现滤镜效果
    
    imageV.image = [self filterImage:imageV.image];
    
    //5.使用GPUImage实现滤镜效果,这是一个第三方库，效果异常丰富，详情 https://github.com/BradLarson/GPUImage
    
    
}


/**
 *  使用vImage API进行图像的模糊处理
 *
 *  @param image 原图像
 *  @param blur  模糊度（0.0~1.0）
 *
 *  @return 模糊处理之后的图像
 */
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }//判断曝光度
    int boxSize = (int)(blur * 100);//放大100，就是小数点之后两位有效
    boxSize = boxSize - (boxSize % 2) + 1;//如果是偶数，+1，变奇数
    
    CGImageRef img = image.CGImage;//获取图片指针
    
    vImage_Buffer inBuffer, outBuffer;//获取缓冲区
    vImage_Error error;//一个错误类，在后调用画图函数的时候要用
    
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);//放回一个图片供应者信息
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);//拷贝数据，并转化
    
    inBuffer.width = CGImageGetWidth(img);//放回位图的宽度
    inBuffer.height = CGImageGetHeight(img);//放回位图的高度
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);//放回位图的
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);//填写图片信息
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));//创建一个空间
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer,
                                       &outBuffer,
                                       NULL,
                                       0,
                                       0,
                                       boxSize,//这个数一定要是奇数的，因此我们一开始的时候需要转化
                                       boxSize,//这个数一定要是奇数的，因此我们一开始的时候需要转化
                                       NULL,
                                       kvImageEdgeExtend);
    
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    //将刚刚得出的数据，画出来。
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

/**
 *  使用CIFilter API进行图像的模糊处理,炫酷
 *
 *  @param image 原图像
 *
 *  @return 模糊处理之后的图像
 */

- (UIImage *)filterImage:(UIImage *)image {
    
    //https://developer.apple.com/library/content/documentation/GraphicsImaging/Reference/CoreImageFilterReference/#//apple_ref/doc/uid/TP30000136-SW29
    
    CIImage *oldImg = [[CIImage alloc] initWithImage:image];
    
    // 设置name，可有多种滤镜效果,简直屌爆
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGammaAdjust" keysAndValues:@"inputImage",oldImg, nil];

    [filter setValue:@(0.3) forKey:@"inputPower"];
    
    //输出图片
    CIImage *outputImage = [filter outputImage];
    //绘制
    CIContext *context = [CIContext contextWithOptions: nil];
    CGImageRef cgimg = [context createCGImage:outputImage fromRect:[outputImage extent]];
    UIImage *newImg = [UIImage imageWithCGImage:cgimg];
    
   return newImg;
    
    
}

/**
 *  使用GPUImage API进行图像的模糊处理,炫酷
 *
 *  @param image 原图像
 *
 *  @return 模糊处理之后的图像
 */

- (UIImage *)gpuImage:(UIImage *)image {
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImageSepiaFilter *stillImageFilter = [[GPUImageSepiaFilter alloc] init];
    
    [stillImageSource addTarget:stillImageFilter];
    [stillImageFilter useNextFrameForImageCapture];
    [stillImageSource processImage];
    
    UIImage *currentFilteredVideoFrame = [stillImageFilter imageFromCurrentFramebuffer];
    
    return currentFilteredVideoFrame;
    
}


@end
