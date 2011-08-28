//
//  UIColor+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (IEK)

+ (void)setColor:(UIColor*)color forKey:(NSString*)key;
+ (UIColor*)colorForKey:(NSString*)key;

@end
