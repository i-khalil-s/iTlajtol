//
//  User.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import <Foundation/Foundation.h>
#import "CoreUser.h"
#import "Token.h"
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

@property (strong, nonatomic) NSNumber *_id;

@property (strong, nonatomic) NSNumber *levelId;

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSNumber *guest;
@property (strong, nonatomic) CoreUser *coreUser;
@property (strong, nonatomic) NSMutableArray<Token *> *tokens;

@property (strong, nonatomic) NSString *tokenD;
@property (strong, nonatomic) Token *tokenC;

- (NSMutableDictionary *)createDict;
+ (User *) createGuest;
- (User * _Nullable) save;
+ (User * _Nullable) retreive;
+ (void) remove;

- (void) login:(completion2) complete;
- (void) signIn:(completion) complete;

@end

NS_ASSUME_NONNULL_END
