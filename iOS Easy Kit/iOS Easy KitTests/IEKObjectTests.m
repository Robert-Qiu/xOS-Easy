//
//  IEKObjectTests.m
//  iOS Easy Kit
//
//  Created by Wei Jia Qiu on 8/31/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKObjectTests.h"
#import "NSDictionary+IEK.h"

@implementation TestObject

@synthesize intValue;
@synthesize shortValue;
@synthesize longValue;
@synthesize longlongValue;
@synthesize ucValue;
@synthesize uiValue;
@synthesize usValue;
@synthesize ulValue;
@synthesize ullValue;
@synthesize floatValue;
@synthesize doubleValue;
@synthesize boolValue;
@synthesize strValue;
@synthesize dateValue1;
@synthesize dateValue2;
@synthesize dateValue3;
@synthesize point;

@end

@implementation IEKObjectTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testDicToObj
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:[NSNumber numberWithInt:10]  forKey:@"intValue"];
    [dic setObject:[NSNumber numberWithShort:20] forKey:@"shortValue"];
    [dic setObject:[NSNumber numberWithLong:30] forKey:@"longValue"];
    [dic setObject:[NSNumber numberWithLongLong:40] forKey:@"longlongValue"];
    [dic setObject:[NSNumber numberWithUnsignedChar:'A'] forKey:@"ucValue"];
    [dic setObject:[NSNumber numberWithUnsignedInt:50] forKey:@"uiValue"];
    [dic setObject:[NSNumber numberWithUnsignedShort:60] forKey:@"usValue"];
    [dic setObject:[NSNumber numberWithUnsignedLong:70] forKey:@"ulValue"];
    [dic setObject:[NSNumber numberWithFloat:100.1f] forKey:@"floatValue"];
    [dic setObject:[NSNumber numberWithDouble:200.2] forKey:@"doubleValue"];
    [dic setObject:[NSNumber numberWithBool:true] forKey:@"boolValue"];
    [dic setObject:@"字符串" forKey:@"strValue"];
    
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:10000];
    [dic setObject:date forKey:@"dateValue1"];
    [dic setObject:[NSNumber numberWithInt:10000] forKey:@"dateValue2"];
    [dic setObject:@"2011-08-31" forKey:@"dateValue3"];

     [IEKObject registerDateFormat:@"yyyy-MM-dd"];
    TestObject *testObj = (TestObject*)[dic createObjectFromClassName:"TestObject"];
    
    STAssertEquals(testObj.intValue, 10, @"intValue set error");
    STAssertEquals(testObj.shortValue, (short)20, @"shortValue set error");
    STAssertEquals(testObj.longValue, 30L, @"longValue set error");
    STAssertEquals(testObj.longlongValue, (long long)40, @"longlongValue set error");
    STAssertEquals(testObj.ucValue, (unsigned char)'A', @"unsigned char set error");
    STAssertEquals(testObj.uiValue, (unsigned int)50, @"unsigned int Value set error");
    STAssertEquals(testObj.usValue, (unsigned short)60, @"unsigned short Value set error");
    STAssertEquals(testObj.ulValue, (unsigned long)70, @"unsigned long Value set error");
    STAssertEquals(testObj.floatValue, 100.1f, @"float Value set error");
    STAssertEquals(testObj.doubleValue, 200.2, @"double Value set error");
    STAssertEquals(testObj.boolValue, (bool)true, @"bool Value set error");
    STAssertEqualObjects(testObj.strValue, @"字符串", @"string Value set error");
    STAssertEqualObjects(testObj.dateValue1,  [NSDate dateWithTimeIntervalSince1970:10000], @"date1 Value set error");
    STAssertEqualObjects(testObj.dateValue2,  [NSDate dateWithTimeIntervalSince1970:10000], @"date1 Value set error");
    
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    [fmt setDateFormat:@"yyyy-MM-dd"];
        
    STAssertEqualObjects(testObj.dateValue3,  [fmt dateFromString:@"2011-08-31"], @"date1 Value set error");
    
    NSDictionary *dictionary = [testObj dictionary];
    
    STAssertEqualObjects([dictionary valueForKey:@"intValue"], [NSNumber numberWithInt:10], @"intValue set error");
    STAssertEqualObjects([dictionary valueForKey:@"shortValue"], [NSNumber numberWithShort:20], @"shortValue set error");
    STAssertEqualObjects([dictionary valueForKey:@"longValue"], [NSNumber numberWithLong:30L], @"longValue set error");
    STAssertEqualObjects([dictionary valueForKey:@"longlongValue"], [NSNumber numberWithLongLong:40], @"longlongValue set error");
    STAssertEqualObjects([dictionary valueForKey:@"ucValue"], [NSNumber numberWithUnsignedChar:'A'], @"unsigned char set error");
    STAssertEqualObjects([dictionary valueForKey:@"uiValue"], [NSNumber numberWithUnsignedInt:50], @"unsigned int Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"usValue"], [NSNumber numberWithUnsignedShort:60], @"unsigned short Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"ulValue"], [NSNumber numberWithUnsignedLong:70], @"unsigned long Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"floatValue"], [NSNumber numberWithFloat:100.1f], @"float Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"doubleValue"], [NSNumber numberWithDouble:200.2], @"double Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"boolValue"], [NSNumber numberWithBool:true], @"bool Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"strValue"], @"字符串", @"string Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"dateValue1"],  [NSDate dateWithTimeIntervalSince1970:10000], @"date1 Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"dateValue2"],  [NSDate dateWithTimeIntervalSince1970:10000], @"date1 Value set error");
    STAssertEqualObjects([dictionary valueForKey:@"dateValue3"],  [fmt dateFromString:@"2011-08-31"], @"date1 Value set error");
}

@end
