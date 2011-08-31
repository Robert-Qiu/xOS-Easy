//
//  IEKObject.m
//  iOS Easy Kit
//
//  Created by Robert Qiu on 8/30/11.
//  Copyright 2011 Robert Qiu. All rights reserved.
//

#import "IEKObject.h"
#import <objc/runtime.h>

static NSMutableArray *dateFormats = nil;

@implementation IEKObject

#pragma mark - Key-Value support
- (BOOL)accessInstanceVariablesDirectly{
    
    return FALSE;
}

//do nothing when
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    NSLog(@"key %@ is undefined", key);
}

- (void)setValue:(id)value forKey:(NSString*)key{
    
    if( [key isEqualToString:@"id"] ){
        [super setValue:value forKey:@"_id"];
    }
    else {
        [super setValue:value forKey:key];
    }
}

- (void)setNilValueForKey:(NSString*)key{
    
    NSLog(@"set nil value for key %@", key);
}

- (id)valueForUndefinedKey:(NSString*)key{
    
    return nil;
}

#pragma mark - dynamic object creation

+ (void)registerDateFormat:(NSString*)formatStr
{
    if (!dateFormats) {
        dateFormats = [[NSMutableArray alloc] init];
    }
    [dateFormats addObject:formatStr];
}

+ (IEKObject*)objectForClassName:(const char*)className
{
    //look up if the class is registed
    Class c = objc_lookUpClass(className);
    if(!c){
        @throw [[NSException alloc] initWithName:@"Object Creation Exception"
                                          reason:[NSString stringWithFormat:@"Can not find the class %s definition.", className]
                                        userInfo:nil];
    }
    
    //check class ancestor
    Class sc = class_getSuperclass(c);
    while (sc && sc != [IEKObject class] ) {
        sc = class_getSuperclass(sc);
    }
    if( !sc ){
        @throw [[NSException alloc] initWithName:@"Object Creation Exception" reason:@"The class is not derived from IEKObject." userInfo:nil];
    }
    
    //create an instance for the class
    IEKObject *obj = (IEKObject*)class_createInstance(c, 0);
    if(!obj){
        NSLog(@"Create instance for class %s failed", className);
        return nil;
    }
    [obj init];
    return [obj autorelease];
}

+ (IEKObject*)objectForClassName:(const char*)className fromDictionary:(NSDictionary*)dic;
{
    IEKObject *obj = [IEKObject objectForClassName:className];
    if (!obj) {
        return nil;
    }
    Class c = [obj class];
    
    //for debug
    /* 
     unsigned int methodCount = 0;
     Method* methods = class_copyMethodList(c, &methodCount);
     for( int i = 0; i < methodCount; i ++ ){
     SEL m = method_getName(methods[i]);
     const char* methodName = sel_getName(m);
     NSLog(@"%s", methodName);
     }
     */
    
    //for each property of the class, set it's value
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(c, &propertyCount);
    
    for( int i = 0; i < propertyCount; i ++ ){
        
        const char* propertyAttr = property_getAttributes( properties[i] );
        if (!propertyAttr) {
            NSLog(@"get property attributes failed");
            continue;
        }
        NSLog(@"%s", propertyAttr);
        
        const char* keyName = property_getName( properties[i] );
        if( !keyName ){
            
            NSLog(@"attemp to get a key name failed");
            continue;
        }
        NSString *key = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        if( !key ){
            
            NSLog(@"convert key %s to NSString failed", keyName);
            continue;
        }
        
        switch (propertyAttr[1]) {
                //for primitive types, set them value directly
            case 'c':       //A char
            case 'i':       //An int
            case 's':       //A short
            case 'l':       //A long l is treated as a 32-bit quantity on 64-bit programs.
            case 'q':       //A long long
            case 'C':       //An unsigned char
            case 'I':       //An unsigned int
            case 'S':       //An unsigned short
            case 'L':       //An unsigned long
            case 'Q':       //An unsigned long long
            case 'f':       //A float
            case 'd':       //A double
            case 'B':       //A C++ bool or a C99 _Bool
            {
            [obj setValue:[dic objectForKey:key] forKey:key];
            }
                break;
                
                //for cooca types
            case '@': //An object (whether statically typed or typed id)
            {
                const char* pBegin = propertyAttr + 3;
                const char* pEnd = strchr(propertyAttr + 3, '\"');
                int typeNameLen = pEnd - pBegin;
                char typeName[128];
                strncpy(typeName, pBegin, typeNameLen);
                typeName[typeNameLen] = 0;
            
                NSObject *o = [dic objectForKey:key];
            
                if( strcmp(typeName, "NSString") == 0 ){
                    [obj setValue:o forKey:key];
                }
                else if( strcmp(typeName, "NSDate") == 0 ){
                    [obj setDate:o forKey:key];
                }
                else{
                
                    if( [o isKindOfClass:[NSDictionary class]] ){
                
                        NSDictionary *dic = (NSDictionary*)o;
                        NSObject *subObj = [IEKObject objectForClassName:typeName fromDictionary:dic];
                        if( subObj ){
                            [obj setValue:subObj forKey:key];
                        }
                    }
                }
            }
                break;
            default:
        
        /* some unsupported types
         
         //for other types do nothing
         case 'v': //A void
         case '*': //A character string (char *)
         case '#': //A class object (Class)
         case ':': //A method selector (SEL)
         [array type] //An array
         {name=type...} //A structure
         (name=type...) //A union
         bnum //A bit field of num bits
         ^type //A pointer to type
         ? //An unknown type (among other things, this code is used for function pointers)
         */
                break;
        }
}

return obj;
}

- (void)setDate:(id)value forKey:(NSString*)key
{
    if( [value isKindOfClass:[NSDate class]] ){
        [self setValue:value forKey:key];
    }
    else if( [value isKindOfClass:[NSNumber class]] ){
        //covert timestamp (NSNumber) to NSDate
        NSNumber *num = (NSNumber*)value;
        [self setValue:[NSDate dateWithTimeIntervalSince1970:[num doubleValue]] forKey:key];
    }
    else if( [value isKindOfClass:[NSString class]] ){
        
        NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
        NSDate *date = nil;
        for (int i = 0; i < [dateFormats count]; i++) {
            
            NSString* dateFormat = [dateFormats objectAtIndex:i];
            [dateFmt setDateFormat:dateFormat];
            date = [dateFmt dateFromString:(NSString*)value];
            if (date) {
                break;
            }
        }
        if (date) {
            [self setValue:date forKey:key];
        }
        else
        {
            NSLog(@"Unsupported date format%@", value);
        }
        [dateFmt release];
    }
}

- (NSDictionary*)dictionary
{
    Class c = [self class];
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(c, &propertyCount);
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    
    for( int i = 0; i < propertyCount; i ++ ){
        
        const char* propertyAttr = property_getAttributes( properties[i] );
        if (!propertyAttr) {
            NSLog(@"get property attributes failed");
            continue;
        }
        NSLog(@"%s", propertyAttr);
        
        const char* keyName = property_getName( properties[i] );
        if( !keyName ){
            
            NSLog(@"attemp to get a key name failed");
            continue;
        }
        NSString *key = [NSString stringWithCString:keyName encoding:NSUTF8StringEncoding];
        if( !key ){
            
            NSLog(@"convert key %s to NSString failed", keyName);
            continue;
        }
        
        id value;
        value = [self valueForKey:key];
        [dictionary setValue:value forKey:key];
    }
    return [dictionary autorelease];
}

@end
