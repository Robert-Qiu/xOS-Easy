//
//  IEKBase64.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/27/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKBase64.h"

#define xx 65

static unsigned char encodeTable[65] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static unsigned char decodeTable[256] =
{
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 62, xx, xx, xx, 63, 
    52, 53, 54, 55, 56, 57, 58, 59, 60, 61, xx, xx, xx, xx, xx, xx, 
    xx,  0,  1,  2,  3,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 
    15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, xx, xx, xx, xx, xx, 
    xx, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 
    41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
    xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, xx, 
};

@implementation IEKBase64

- (NSString*)encodeString:(NSString*)str
{
    return [self encodeBytes:(void*)[str UTF8String] length:[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
}

- (NSString*)encodeData:(NSData*)data
{
    return [self encodeBytes:(void*)[data bytes] length:[data length]];
}

- (NSString*)encodeBytes:(void*)bytes length:(NSUInteger)len
{
    int inputLength = len;
    int encodeBlocks = 0;
    int tailCharCount = inputLength % 3;
    int paddingCount = (3 - tailCharCount) % 3;
    if (tailCharCount == 0) {
        encodeBlocks = inputLength / 3;
    }
    else
    {
        encodeBlocks = inputLength / 3 + 1;
    }
    int outputLength = encodeBlocks * 4;
    
    const char* inputBuff = bytes;
    char* outputBuff = malloc(outputLength + paddingCount);
    memset(outputBuff, 0, outputLength + paddingCount);
    
    int outBuffIndex = 0;
    for (int i = 0; i < ( tailCharCount == 0 ? encodeBlocks : (encodeBlocks - 1)  ) * 3; i += 3) {
        
        outputBuff[outBuffIndex ++] = encodeTable[ (inputBuff[i] & 0xFC) >> 2 ];
        outputBuff[outBuffIndex ++] = encodeTable[ (inputBuff[i] & 0x03) << 4 | (inputBuff[i+1] & 0xF0) >> 4 ];
        outputBuff[outBuffIndex ++] = encodeTable[ (inputBuff[i+1] & 0x0F) << 2 | (inputBuff[i+2] & 0xC0) >> 6 ];
        outputBuff[outBuffIndex ++] = encodeTable[ inputBuff[i+2] & 0x3F ];
    }
    
    char tailInput[3];
    if (tailCharCount > 0) {
        
        if (tailCharCount == 1) {
            
            tailInput[0] = inputBuff[(encodeBlocks - 1) * 3];
            tailInput[1] = 0;
            outputBuff[outBuffIndex ++] = encodeTable[ (tailInput[0] & 0xFC) >> 2 ];
            outputBuff[outBuffIndex ++] = encodeTable[ (tailInput[0] & 0x03) << 4 | (tailInput[1] & 0xF0) >> 4 ];
        }
        else if(tailCharCount == 2){
            
            tailInput[0] = inputBuff[(encodeBlocks - 1) * 3];
            tailInput[1] =  inputBuff[(encodeBlocks - 1) * 3 + 1];
            tailInput[2] = 0;
            outputBuff[outBuffIndex ++] = encodeTable[ (tailInput[0] & 0xFC) >> 2 ];
            outputBuff[outBuffIndex ++] = encodeTable[ (tailInput[0] & 0x03) << 4 | (tailInput[1] & 0xF0) >> 4 ];
            outputBuff[outBuffIndex ++] = encodeTable[ (tailInput[1] & 0x0F) << 2 | (tailInput[2] & 0xC0) >> 6 ];
        }
        
        for (int i = 0; i < paddingCount; i++) {
            outputBuff[outBuffIndex ++] = '=';
        }
    }
    
    NSString *encodedStr = [[NSString alloc] initWithBytes:outputBuff length:outBuffIndex encoding:NSASCIIStringEncoding];
    free(outputBuff);
    return [encodedStr autorelease];
}

- (void)decodeString:(NSString*)str output:(void**)output length:(NSUInteger*)len
{
    
    return [self decodeBytes:(void*)[str UTF8String] length:[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding] output:output length:len];
}

- (NSString*)decodeString:(NSString*)str
{
    
    return [self decodeBytes:(void*)[str UTF8String] length:[str lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
}


- (void)decodeBytes:(void*)bytes length:(NSUInteger)iLen output:(void**)output length:(NSUInteger*)oLen
{
    int paddingCount = 0;
    unsigned char *inputBuff = bytes;
    if( inputBuff[iLen - 1]  == '='){
        paddingCount  = 1;
    }
    if ( inputBuff[iLen - 2] == '=') {
        paddingCount = 2;
    }
    
    int tailCount = (iLen - paddingCount) % 4;
    
    if (tailCount == 1) {
        *output = NULL;
        *oLen = 0;
        return;
    }
    
    int blockCount = 0;
    if (tailCount == 0) {
        blockCount = (iLen - paddingCount) / 4;
    }
    else
    {
        blockCount = (iLen - paddingCount)  / 4 + 1;
    }
    int outBuffLen = blockCount * 3 + tailCount;
    
    char* outputBuff = malloc(outBuffLen);
    int outputBuffIndex = 0;
    
    for (int i = 0; i < (tailCount == 0 ? blockCount : blockCount - 1 ) * 4; i+=4) {
        
        char char1 = decodeTable[inputBuff[i]];
        char char2 = decodeTable[inputBuff[i+1]];
        char char3 = decodeTable[inputBuff[i+2]];
        char char4 = decodeTable[inputBuff[i+3]];
        
        if (char1 == xx || char2 == xx || char3 == xx || char4 == xx) {
            *output = NULL;
            *oLen = 0;
            return;
        }
        outputBuff[outputBuffIndex ++] = (char1 << 2) | (char2 >> 4);;
        outputBuff[outputBuffIndex ++] = (char2 << 4) | (char3 >> 2);
        outputBuff[outputBuffIndex ++] = (char3 << 6) | char4;
    }
    
    if (tailCount > 0) {
        
        if (tailCount == 3) {
        
            char char1 = decodeTable[inputBuff[(blockCount - 1) * 4]];
            char char2 = decodeTable[inputBuff[(blockCount - 1) * 4+1]];
            char char3 = decodeTable[inputBuff[(blockCount - 1) * 4+2]];
            
            if (char1 == xx || char2 == xx || char3 == xx) {
                *output = NULL;
                *oLen = 0;
                return;
            }
            outputBuff[outputBuffIndex ++] = (char1 << 2) | (char2 >> 4);;
            outputBuff[outputBuffIndex ++] = (char2 << 4) | (char3 >> 2);
        }
        else if(tailCount == 2) {
        
            char char1 = decodeTable[inputBuff[(blockCount - 1) * 4]];
            char char2 = decodeTable[inputBuff[(blockCount - 1) * 4+1]];
            if (char1 == xx || char2 == xx) {
                *output = NULL;
                *oLen = 0;
                return;
            }
            outputBuff[outputBuffIndex ++] = (char1 << 2) | (char2 >> 4);
        }
    }
    *output = outputBuff;
    *oLen = outputBuffIndex;
}

- (NSString*)decodeBytes:(void*)bytes length:(NSUInteger)len
{
    unsigned char* decodeOutput;
    NSUInteger outputLen;
    [self decodeBytes:bytes length:len output:(void*)&decodeOutput length:&outputLen];
    NSString *outputStr;
    if (decodeOutput) {
        outputStr = [[NSString alloc] initWithBytes:decodeOutput length:outputLen encoding:NSUTF8StringEncoding];
        free(decodeOutput);
    }
    else{
        return nil;
    }
    return [outputStr autorelease];
}


@end
