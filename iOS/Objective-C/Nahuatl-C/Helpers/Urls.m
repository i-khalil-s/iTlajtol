//
//  Urls.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "Urls.h"
#import "Constants.h"
#import "Blocks.h"
#import "User.h"
#import <UIKit/UIKit.h>

@implementation Urls

static NSURL *url_corpus;
+ (NSURL *) url_corpus {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@", Constants.SERVER , @"corpus/0/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_translations;
+ (NSURL *) url_translations:(NSNumber *) item {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@%d%@", Constants.SERVER , @"translation/", [item intValue], @"/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_translationsGet;
+ (NSURL *) url_translationsGet:(NSNumber *) user at:(NSNumber *) page {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@%d%@%d", Constants.SERVER , @"translation/", [user intValue], @"/", [page intValue]];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_translate;
+ (NSURL *) url_translate {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@", Constants.SERVER , @"translate/0/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_languages;
+ (NSURL *) url_languages {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@", Constants.SERVER , @"language/0/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_signin;
+ (NSURL *) url_signin {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@", Constants.SERVER , @"signin/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_login;
+ (NSURL *) url_login {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@", Constants.SERVER , @"login/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_arrows;
+ (NSURL *) url_arrows {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@", Constants.SERVER , @"arrow/0/"];
        return [[NSURL alloc] initWithString: server];
    }
}

static NSURL *url_arrows_action;
+ (NSURL *) url_arrows_action:(NSNumber *) item {
    @synchronized (self) {
        NSString *server = [NSString stringWithFormat:@"%@%@%d%@", Constants.SERVER , @"arrowBy/", [item intValue], @"/"];
        return [[NSURL alloc] initWithString: server];
    }
}

///: METHODS

static NSString *HTTP_GET_METHOD;
+ (NSString *) HTTP_GET_METHOD {
    @synchronized (self) {
        return @"GET";
    }
}

static NSString *HTTP_POST_METHOD;
+ (NSString *) HTTP_POST_METHOD {
    @synchronized (self) {
        return @"POST";
    }
}

static NSString *HTTP_PUT_METHOD;
+ (NSString *) HTTP_PUT_METHOD {
    @synchronized (self) {
        return @"PUT";
    }
}

static NSString *HTTP_DELETE_METHOD;
+ (NSString *) HTTP_DELETE_METHOD {
    @synchronized (self) {
        return @"DELETE";
    }
}

static NSMutableURLRequest *createRequestWith;
+ (NSMutableURLRequest *) createRequestWith:(NSURL *) url withMethod:(NSString *) method params:( NSString * _Nullable) body {
    @synchronized (self) {
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        request.HTTPMethod = method;
        
        if (body) {
            NSString *params = [[[body stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@";" withString:@""];
            request.HTTPBody = [params dataUsingEncoding:NSUTF8StringEncoding];
            [request addValue:@"application/json; charset=UTF-8;" forHTTPHeaderField:@"Content-Type"];
            [request addValue:@"application/json, text/plain" forHTTPHeaderField:@"Accept"];
            
        }
        
        // TODO: Make real user
        User *usr = [User retreive];
        
        if (usr) {
            NSString * _Nullable sToken;
            
            for (Token *tkn in usr.tokens) {
                if ([tkn.UUID isEqualToString:UIDevice.currentDevice.identifierForVendor.UUIDString]) {
                    sToken = tkn.token;
                    break;
                }
            }
            
            NSString *token = [NSString stringWithFormat:@"%@%@", @"Token ", sToken];
//            NSString *token = [NSString stringWithFormat:@"%@%@", @"Token ", @"96f4eec7e22714fafad9ad7b0b3fcce736ace2bc"];
            [request addValue:token forHTTPHeaderField:@"Authorization"];
        }
        
        [request addValue:@"no-cache/no-store" forHTTPHeaderField:@"Cache-Control"];
        
        return request;
    }
}

static NSString *ERROR_MESSAGE;
+ (NSString *) ERROR_MESSAGE {
    @synchronized (self) {
        return @"Hubo un error en el servidor, se está trasbajando en ello";
    }
}

+ (void)runWithSession:(NSURLSession *) session url:(NSURL *) url params:(NSString * _Nullable) params method:(NSString *) method execute:(completion) complete {
    
    NSMutableURLRequest *request = [Urls createRequestWith:url withMethod:method params:params];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
        
        if (httpResponse) {
            
            //Unauthorized
            if (httpResponse.statusCode == 401) {
                //TODO: Logout
                User *userToUse = [User retreive];
                
                if (userToUse) {
                    userToUse.coreUser.password = userToUse.tokenD;
                } else {
                    userToUse = [User createGuest];
                }
                
                [User remove];
                
                [userToUse login:^(Response *response) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (response.object && response.state) {
                            User *uss = (User *) response.object;
                            if (uss) {
                                User *u = [uss save];
                                if (u) {
                                    user = u;
                                }
                            }
                        } else {
                            [[User createGuest] save];
                        }
                        complete([[Response alloc] initNO]);
                    });
                }];
               
            }
            
            if (data && httpResponse.statusCode >= 200 && httpResponse.statusCode <= 299) {
                complete(
                         [[Response alloc]
                          initWithState:YES
                          message:@""
                          object: data
                          ]
                );
            }
            
        } else {
            complete([[Response alloc] initNO]);
        }
        
        if (error) {
            complete([[Response alloc] initNO]);
        }
        
    }] resume];
    
}

@end
