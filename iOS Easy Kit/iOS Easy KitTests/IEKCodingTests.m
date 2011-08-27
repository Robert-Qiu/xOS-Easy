//
//  IEKCodingTests.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/27/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKCodingTests.h"
#import "IEKBase64.h"
#import "NSString+IEK.h"

@implementation IEKCodingTests

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

- (void)testBase64Encode
{
    IEKBase64 *base64 = [[IEKBase64 alloc] init];
    NSString *expectedStr = @"TWFuIGlzIGRpc3Rpbmd1aXNoZWQsIG5vdCBvbmx5IGJ5IGhpcyByZWFzb24sIGJ1dCBieSB0aGlzIHNpbmd1bGFyIHBhc3Npb24gZnJvbSBvdGhlciBhbmltYWxzLCB3aGljaCBpcyBhIGx1c3Qgb2YgdGhlIG1pbmQsIHRoYXQgYnkgYSBwZXJzZXZlcmFuY2Ugb2YgZGVsaWdodCBpbiB0aGUgY29udGludWVkIGFuZCBpbmRlZmF0aWdhYmxlIGdlbmVyYXRpb24gb2Yga25vd2xlZGdlLCBleGNlZWRzIHRoZSBzaG9ydCB2ZWhlbWVuY2Ugb2YgYW55IGNhcm5hbCBwbGVhc3VyZS4=";
    
    NSString *resultStr = [base64 encodeString:@"Man is distinguished, not only by his reason, but by this singular passion from other animals, which is a lust of the mind, that by a perseverance of delight in the continued and indefatigable generation of knowledge, exceeds the short vehemence of any carnal pleasure."];
    
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test1 failed!");
    
    expectedStr = @"YW55IGNhcm5hbCBwbGVhc3VyZS4=";
    resultStr = [base64 encodeString:@"any carnal pleasure."];
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test2 failed!");
    
    expectedStr = @"YW55IGNhcm5hbCBwbGVhc3VyZQ==";
    resultStr = [base64 encodeString:@"any carnal pleasure"];
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test3 failed!");
    
    expectedStr = @"YW55IGNhcm5hbCBwbGVhc3Vy";
    resultStr = [base64 encodeString:@"any carnal pleasur"];
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test4 failed!");
}

- (void)testBase64Decode
{
    IEKBase64 *base64 = [[IEKBase64 alloc] init];
    NSString *expectedStr = @"any carnal pleas";
    NSString *resultStr = [base64 decodeString:@"YW55IGNhcm5hbCBwbGVhcw=="];
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test1 failed!");

    expectedStr = @"any carnal pleasu";
    resultStr = [base64 decodeString:@"YW55IGNhcm5hbCBwbGVhc3U="];
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test2 failed!");
    
    expectedStr = @"any carnal pleasur";
    resultStr = [base64 decodeString:@"YW55IGNhcm5hbCBwbGVhc3Vy"];
    STAssertEqualObjects(expectedStr, resultStr, @"base64 test3 failed!");
    
}

- (void)testURLEncode
{
    NSString *expectedStr = @"%E4%B8%AD%E6%96%87chi%20nese%2B";
    NSString *words = @"中文chi nese+";
    NSString *resultStr = [words urlEncodedString];
    STAssertEqualObjects(expectedStr, resultStr, @"urlencode test1 failed!");
    
    
}

@end
