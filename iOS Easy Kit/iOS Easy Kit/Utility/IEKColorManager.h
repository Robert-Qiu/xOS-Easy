//
//  IEKColorManager.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/28/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface IEKColorManager : NSObject
{
    NSMutableDictionary *colorDic;
}

+ (IEKColorManager*)sharedManager;
- (void)setColor:(UIColor*)color forKey:(NSString*)key;
- (UIColor*)colorForKye:(NSString*)key;

@end
