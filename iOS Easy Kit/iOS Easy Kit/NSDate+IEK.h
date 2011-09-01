//
//  NSDate+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IEK)

- (NSDate*)dateByAddDays:(int)days;
- (NSDate*)dateByAddWeeks:(int)weeks;
- (NSDate*)dateByAddMonths:(int)months;
- (NSDate*)dateByAddYears:(int)years;

@end
