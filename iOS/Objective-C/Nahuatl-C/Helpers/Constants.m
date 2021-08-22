//
//  Constants.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "Constants.h"
#import "Keys.h"

@implementation Constants

static NSString *SERVER;
+ (NSString *) SERVER {
    @synchronized (self) {
        return [NSUserDefaults.standardUserDefaults stringForKey:Keys.SERVER];
    }
}

static NSNumber *TRY_TIMEOUT;
+ (NSNumber *) TRY_TIMEOUT {
    @synchronized (self) {
        return [NSNumber numberWithInt:5];
    }
}

static NSNumber *RETRY_ATTEMPS;
+ (NSNumber *) RETRY_ATTEMPS {
    @synchronized (self) {
        return [NSNumber numberWithInt:3];
    }
}

static NSNumber *_PAGE_SIZE;
+ (NSNumber *) _PAGE_SIZE {
    @synchronized (self) {
        return [NSNumber numberWithInt:10];
    }
}

static NSNumber *TIME_OUT_INTERVAL_FOR_REQUEST;
+ (NSNumber *) TIME_OUT_INTERVAL_FOR_REQUEST {
    @synchronized (self) {
        return [NSNumber numberWithInt:100];
    }
}

static NSNumber *TIME_OUT_INTERVAL_FOR_RESOURCE;
+ (NSNumber *) TIME_OUT_INTERVAL_FOR_RESOURCE {
    @synchronized (self) {
        return [NSNumber numberWithDouble: ([Constants.TRY_TIMEOUT doubleValue] * [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue])];
    }
}

static NSString *APP_VERSION;
+ (NSString * ) APP_VERSION {
    @synchronized (self) {
        return [NSBundle.mainBundle.infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
}

User *user;

@end
