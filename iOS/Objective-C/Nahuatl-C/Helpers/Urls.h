//
//  Urls.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface Urls : NSObject

+ (NSURL *) url_corpus;
+ (NSURL *) url_translations:(NSNumber *) item;
+ (NSURL *) url_translationsGet:(NSNumber *) user at:(NSNumber *) page;

+ (NSURL *) url_translate;

+ (NSURL *) url_languages;

+ (NSURL *) url_signin;
+ (NSURL *) url_login;

+ (NSURL *) url_arrows;
+ (NSURL *) url_arrows_action:(NSNumber *) item;

+ (NSString *) HTTP_GET_METHOD;
+ (NSString *) HTTP_POST_METHOD;
+ (NSString *) HTTP_PUT_METHOD;
+ (NSString *) HTTP_DELETE_METHOD;

+ (NSMutableURLRequest *) createRequestWith:(NSURL *) url withMethod:(NSString *) method params:( NSString * _Nullable) body;

+ (NSString *) ERROR_MESSAGE;


+ (void)runWithSession:(NSURLSession *) session url:(NSURL *) url params:(NSString * _Nullable) params method:(NSString *) method execute:(completion) complete;
@end

NS_ASSUME_NONNULL_END

