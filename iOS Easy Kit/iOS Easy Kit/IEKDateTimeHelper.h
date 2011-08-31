//
//  IEKDateTimeHelper.h
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/31/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IEKDateTimeHelper : NSObject
{
    NSCalendar *curCalendar;
}

+ (IEKDateTimeHelper*)defaultHelper;
- (id)initWithCalendarIdentifier:(NSString*)key;

- (NSDate*)dateByAddHours:(int)hours minutes:(int)minutes seconds:(int)seconds fromDate:(NSDate*)date;
- (NSDate*)dateByAddDays:(int)days fromDate:(NSDate*)date;
- (NSDate*)dateByAddWeeks:(int)weeks fromDate:(NSDate*)date;
- (NSDate*)dateByAddMonths:(int)months fromDate:(NSDate*)date;
- (NSDate*)dateByAddYears:(int)years fromDate:(NSDate*)date;;


@end
