//
//  Keys.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "Keys.h"

@implementation Keys

static NSString *SERVER;
+ (NSString *) SERVER {
    @synchronized (self) {
        return @"SERVER";
    }
}

static NSString *FIRST_LAUNCH;
+ (NSString *) FIRST_LAUNCH {
    @synchronized (self) {
        return @"FIRST_LAUNCH";
    }
}

static NSString *USER;
+ (NSString *) USER {
    @synchronized (self) {
        return @"USER";
    }
}

@end
