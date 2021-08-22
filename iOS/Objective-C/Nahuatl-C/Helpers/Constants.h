//
//  Constants.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <Foundation/Foundation.h>
#import "User.h"

extern User * _Nullable user;

NS_ASSUME_NONNULL_BEGIN

@interface Constants : NSObject

+ (NSString *) SERVER;
+ (NSNumber *) TRY_TIMEOUT;
+ (NSNumber *) RETRY_ATTEMPS;

+ (NSNumber *) _PAGE_SIZE;
+ (NSNumber *) TIME_OUT_INTERVAL_FOR_REQUEST;
+ (NSNumber *) TIME_OUT_INTERVAL_FOR_RESOURCE;

+ (NSString *) APP_VERSION;

@end

NS_ASSUME_NONNULL_END
