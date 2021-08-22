//
//  Token.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Token : NSObject

@property (strong, nonatomic) NSNumber *_id;

@property (strong, nonatomic) NSString *token;

@property (strong, nonatomic) NSString *device;
@property (strong, nonatomic) NSString *so;
@property (strong, nonatomic) NSString *app_ver;
@property (strong, nonatomic) NSString *UUID;

@property (strong, nonatomic) NSNumber *active;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<Token *> *) parseArrayFromData:(NSData *) data;

+ (Token *) defaultToken;

@end

NS_ASSUME_NONNULL_END
