//
//  Util.m
//  Melon
//
//  Created by Jang Dong-hyun on 2016. 6. 17..
//  Copyright © 2016년 Jang Dong-hyun. All rights reserved.
//

#import "Util.h"
#import <sys/utsname.h>

@implementation Util

+ (UIView *)makeCircleView:(UIView *)originView
{
    originView.layer.cornerRadius = originView.bounds.size.width/2;
    originView.layer.masksToBounds = YES;
    
    return originView;
}

+ (UIImage *)getImageByColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString*)deviceModelName
{
    static NSString *_modelName = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname u;
        uname(&u);
        _modelName = [[NSString alloc] initWithCString:u.machine encoding:NSUTF8StringEncoding];
    });
    return _modelName;
}

+ (NSString*)unescapeUnicodeString:(NSString*)string
{
    NSError* error = nil;
    NSString* replace = [string stringByReplacingOccurrencesOfString:@"\"" withString:@""];
    NSString* esc1 = [replace stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    NSString* quoted = [[@"\"" stringByAppendingString:esc1] stringByAppendingString:@"\""];
    
    
    NSData* data = [quoted dataUsingEncoding:NSUTF8StringEncoding];
    NSString* unesc = [NSPropertyListSerialization propertyListWithData:data
                                                       options:NSPropertyListImmutable format:NULL
                                                       error:&error];
    
    
    return unesc;
}

@end
