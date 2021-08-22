//
//  CoreUser.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreUser : NSObject

@property (strong, nonatomic) NSNumber *_id;

@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *email;

@property (strong, nonatomic) NSNumber *isSuperuser;
@property (strong, nonatomic) NSNumber *isStaff;
@property (strong, nonatomic) NSNumber *isActive;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<CoreUser *> *) parseArrayFromData:(NSData *) data;

+ (CoreUser *) guest;

@end

NS_ASSUME_NONNULL_END
