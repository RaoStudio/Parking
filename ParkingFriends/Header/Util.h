//
//  Util.h
//  Melon
//
//  Created by Jang Dong-hyun on 2016. 6. 17..
//  Copyright © 2016년 Jang Dong-hyun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Util : NSObject

+ (UIView *)makeCircleView:(UIView *)originView;

+ (UIImage *)getImageByColor:(UIColor *)color;

+ (NSString*)deviceModelName;

+ (NSString*)unescapeUnicodeString:(NSString*)string;

@end
