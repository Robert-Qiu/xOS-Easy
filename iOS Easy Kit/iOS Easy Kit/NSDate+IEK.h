//
//  NSDate+IEK.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IEK)

- (NSDate*)addDays:(int)days;
- (NSDate*)addWeeks:(int)weeks;
- (NSDate*)addMonths:(int)months;
- (NSDate*)addYears:(int)years;

@end
