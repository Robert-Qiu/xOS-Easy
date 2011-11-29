//
//  IEKFontManager.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IEKFontManager : NSObject
{
    NSMutableDictionary *fontDic;
}

+ (IEKFontManager*)sharedManager;
- (void)setFont:(UIFont*)font forKey:(NSString*)key;
- (UIFont*)fontForKey:(NSString*)key;

@end
