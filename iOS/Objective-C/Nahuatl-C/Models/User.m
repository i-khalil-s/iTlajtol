//
//  User.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import "User.h"
#import "Token.h"
#import "CoreUser.h"
#import "Keys.h"
#import "Constants.h"
#import "Urls.h"

@implementation User

- (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = NSMutableDictionary.new;
    
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.levelId forKey:@"level_id"];
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.levelId forKey:@"level_id"];
    [dict setValue:self.phone forKey:@"phone"];
    [dict setValue:self.guest forKey:@"guest"];
    
    NSMutableArray *tkns = NSMutableArray.new;
    
    for (Token *tkn in self.tokens) {
        [tkns addObject: [tkn createDict]];
    }
    
    [dict setValue:tkns forKey:@"tokens"];
    
    [dict setValue:[self.coreUser createDict] forKey:@"id_auth_user"];
    
    [dict setValue:self.tokenD forKey:@"tokenD"];
    [dict setValue:[self.tokenC createDict] forKey:@"tokenC"];
    
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    
    self.levelId = dict[@"level_id"];
    self.phone = dict[@"phone"];
    self.guest = dict[@"guest"];
    
    NSMutableArray *tokens = NSMutableArray.new;
    for(NSDictionary *tDict in dict[@"tokens"]) {
        [tokens addObject: [[Token alloc] initWithDict: tDict]];
    }
    self.tokens = tokens;
    
    self.coreUser = [[CoreUser alloc] initWithDict: dict[@"id_auth_user"]];
    
    self.tokenD = dict[@"tokenD"];
    self.tokenC = [[Token alloc] initWithDict:dict[@"tokenC"]];
    return self;
}

- (NSMutableArray<User *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<User *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[User alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

static User *createGuest;
+ (User *) createGuest {
    @synchronized (self) {
        User *usr = User.new;
        usr._id = [NSNumber numberWithInt:0];
        usr.levelId = [NSNumber numberWithInt:1];
        usr.phone = @"";
        usr.guest = [NSNumber numberWithInt:0];
        usr.coreUser = [CoreUser guest];
        usr.tokenC = [Token defaultToken];
        
        return usr;
    }
}

- (User * _Nullable) save {
    NSError *err;
    NSData *data = [NSJSONSerialization dataWithJSONObject: [self createDict] options:NSJSONWritingFragmentsAllowed error:&err];
    if (err) {
        return nil;
    }
    [NSUserDefaults.standardUserDefaults setObject:data forKey:Keys.USER];
    [NSUserDefaults.standardUserDefaults synchronize];
    return [User retreive];
}

+ (User * _Nullable) retreive {
    NSData *data = [NSUserDefaults.standardUserDefaults objectForKey:Keys.USER];
    if (data) {
        NSError *error;
        NSDictionary *dictt = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            return nil;
        } else {
            return [[User alloc] initWithDict:dictt];
        }
    }
    return nil;
}

+ (void) remove {
    [NSUserDefaults.standardUserDefaults removeObjectForKey:Keys.USER];
    [NSUserDefaults.standardUserDefaults synchronize];
}

- (void) login:(completion2) complete {
    
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
    conf.timeoutIntervalForRequest = [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue];
    conf.timeoutIntervalForResource = [Constants.TIME_OUT_INTERVAL_FOR_RESOURCE doubleValue];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
        
    NSString *params;
    NSError *err;
    NSData *data = [NSJSONSerialization dataWithJSONObject: [self createDict] options:NSJSONWritingFragmentsAllowed error:&err];
    
    if (data) {
        params = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    [Urls runWithSession:session url:Urls.url_login params: params method:Urls.HTTP_POST_METHOD execute:^(Response *response) {
        if (response.object && response.state) {
            NSError *error;
            NSDictionary *dictt = [NSJSONSerialization JSONObjectWithData:(NSData *) response.object options:NSJSONReadingAllowFragments error:&error];
            response.object = [[User alloc] initWithDict:dictt];
            complete(response);
        }
    }];
    
}

- (void) signIn:(completion) complete {
    
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
    conf.timeoutIntervalForRequest = [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue] * 3;
    conf.timeoutIntervalForResource = [Constants.TIME_OUT_INTERVAL_FOR_RESOURCE doubleValue] * 3;
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
        
    NSString *params;
    NSError *err;
    NSData *data = [NSJSONSerialization dataWithJSONObject: [self createDict] options:NSJSONWritingFragmentsAllowed error:&err];
    
    if (data) {
//        NSData *jsonData = JSonEnco
        params = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    [Urls runWithSession:session url:Urls.url_signin params: params method:Urls.HTTP_POST_METHOD execute:^(Response *response) {
        if (response.object && response.state) {
            NSError *error;
            NSDictionary *dictt = [NSJSONSerialization JSONObjectWithData:(NSData *) response.object options:NSJSONReadingAllowFragments error:&error];
            response.object = [[User alloc] initWithDict:dictt];
            complete(response);
        }
    }];
    
}

@end
