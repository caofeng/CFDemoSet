//
//  People.m
//  NSCodingDemo
//
//  Created by MountainCao on 2017/7/24.
//  Copyright © 2017年 深圳中业兴融互联网金融服务有限公司. All rights reserved.
//

#import "People.h"
#import <objc/runtime.h>

@interface People ()<NSCoding>

@end

@implementation People

/*  常规方式
 
 - (void)encodeWithCoder:(NSCoder *)aCoder {
 [aCoder encodeObject:self.name forKey:@"name"];
 [aCoder encodeInteger:self.age forKey:@"age"];
 [aCoder encodeFloat:self.height forKey:@"height"];
 [aCoder encodeObject:self.address forKey:@"address"];
 
 }
 - (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
 
 if (self = [super init]) {
 self.name = [aDecoder decodeObjectForKey:@"name"];
 self.age = [aDecoder decodeIntegerForKey:@"age"];
 self.height = [aDecoder decodeFloatForKey:@"height"];
 self.address = [aDecoder decodeObjectForKey:@"address"];
 }
 
 return self;
 }
 
 */



/*
 使用runtime进行解档与归档。
 */
- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    unsigned int count = 0; Ivar *ivarLists = class_copyIvarList([People class], &count);
    
    for (int i = 0; i < count; i++) {
        
        const char* name = ivar_getName(ivarLists[i]);
        
        NSString* strName = [NSString stringWithUTF8String:name];
        
        [aCoder encodeObject:[self valueForKey:strName] forKey:strName];
        
    }
    
    free(ivarLists);
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super init]) {
        
        unsigned int count = 0;
        
        Ivar *ivarLists = class_copyIvarList([People class], &count);
        
        for (int i = 0; i < count; i++)
        {
            
            const char* name = ivar_getName(ivarLists[i]);
            
            NSString* strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
            
            id value = [aDecoder decodeObjectForKey:strName];
            
            [self setValue:value forKey:strName];
        }
        
        free(ivarLists);
    }
    return self;
}

@end
