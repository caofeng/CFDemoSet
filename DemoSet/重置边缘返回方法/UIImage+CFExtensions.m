//
//  UIImage+CFExtensions.m
//  DemoSet
//
//  Created by CaoFeng on 2017/5/5.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "UIImage+CFExtensions.h"

@implementation UIImage (CFExtensions)


- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:radians * 180/M_PI];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees

{
    
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width,self.size.height)];
    
    CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
    
    rotatedViewBox.transform = t;
    
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    
    UIGraphicsBeginImageContext(rotatedSize);
    
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    
    CGContextRotateCTM(bitmap, degrees * M_PI / 180);
    
    // Now, draw the rotated/scaled image into the context
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2,self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

@end
