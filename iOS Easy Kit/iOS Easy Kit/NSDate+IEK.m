//
//  NSDate+IEK.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/25/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "NSDate+IEK.h"
#import "IEKDateTimeHelper.h"

@implementation NSDate (IEK)

- (NSDate*)dateByAddDays:(int)days
{
    return [[IEKDateTimeHelper defaultHelper] dateByAddDays:days toDate:self];
}

- (NSDate*)dateByAddWeeks:(int)weeks
{
    return [[IEKDateTimeHelper defaultHelper] dateByAddWeeks:weeks toDate:self];
}

- (NSDate*)dateByAddMonths:(int)months
{
    return [[IEKDateTimeHelper defaultHelper] dateByAddMonths:months toDate:self];
}

- (NSDate*)dateByAddYears:(int)years
{
    return [[IEKDateTimeHelper defaultHelper] dateByAddYears:years toDate:self];
}

@end
