//
//  Token.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import "Token.h"
#import <sys/utsname.h>
#import <UIKit/UIKit.h>
#import "Constants.h"

@implementation Token

- (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.token forKey:@"token"];
    [dict setValue:self.device forKey:@"device"];
    [dict setValue:self.so forKey:@"so"];
    [dict setValue:self.app_ver forKey:@"app_ver"];
    [dict setValue:self.UUID forKey:@"uuid"];
    
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.token =  dict[@"token"];
    self.device = dict[@"device"];
    self.so = dict[@"so"];
    self.app_ver = dict[@"app_ver"];
    self.UUID = dict[@"uuid"];
    
    self.active = dict[@"active"];
    
    return self;
}

- (NSMutableArray<Token *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<Token *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[Token alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

static Token *defaultToken;
+ (Token *) defaultToken {
    @synchronized (self) {
        Token *token = Token.new;
        token._id = [NSNumber numberWithInt:0];
        token.token = @"0";
        token.UUID = UIDevice.currentDevice.identifierForVendor.UUIDString;
        
        struct utsname systemInfo;
        uname(&systemInfo);
        
        token.device = [NSString stringWithCString:systemInfo.machine
                                          encoding:NSUTF8StringEncoding];
        
        token.so = [NSString stringWithFormat:@"%@ %@", UIDevice.currentDevice.systemName, UIDevice.currentDevice.systemVersion];
        
        token.app_ver = Constants.APP_VERSION;
        token.active = [NSNumber numberWithInt:1];
        return token;
        
    }
}

@end
