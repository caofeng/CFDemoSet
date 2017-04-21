//
//  NSDictionary+JSONCategories.m
//
//  Created by Jandy on 4/17/14.
//

#import "NSDictionary+JSONCategories.h"


@implementation NSDictionary (JSONCategories)

- (NSString *)JSONString {
    
    NSString *JSONString = nil;
    NSError* error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self
                                                   options:kNilOptions
                                                     error:&error];
    if (data != nil && error == nil) {
        JSONString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    return JSONString;
}

@end
