//
//  UIDevice+IEK.m
//  iOS Easy Kit
//
//  Created by Wei Jia Qiu on 11/28/11.
//  Copyright (c) 2011 Robert Qiu. All rights reserved.
//

#import "UIDevice+IEK.h"
#import "NSString+IEK.h"
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation UIDevice (IEK)

- (NSString *) macAddrStr
{
    
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

- (NSString *)uniqueDeviceIdentifier
{
    NSString *macaddress = [[UIDevice currentDevice] macAddrStr];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *stringToHash = [NSString stringWithFormat:@"%@%@", macaddress, bundleIdentifier];
    NSString *uniqueIdentifier = [stringToHash MD5String];
    
    return uniqueIdentifier;
}


- (NSString *) uniqueGlobalDeviceIdentifier
{
    
    NSString *macaddress = [[UIDevice currentDevice] macAddrStr];
    NSString *uniqueIdentifier = [macaddress MD5String];
        
    return uniqueIdentifier;
}


@end
