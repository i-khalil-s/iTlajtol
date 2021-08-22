//
//  LanguageCode.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "LanguageCode.h"
#import "Blocks.h"
#import "Constants.h"
#import "Urls.h"
#import "Response.h"

@implementation LanguageCode

- (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.code forKey:@"code"];
    [dict setValue:self.language forKey:@"language"];
    
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.code = dict[@"code"];
    self.language = dict[@"language"];
    return self;
}

- (NSMutableArray<LanguageCode *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<LanguageCode *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[LanguageCode alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

+ (void) getAll:(completion) complete {
    
        NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
        conf.timeoutIntervalForRequest = [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue];
        conf.timeoutIntervalForResource = [Constants.TIME_OUT_INTERVAL_FOR_RESOURCE doubleValue];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
        
    [Urls runWithSession:session url:Urls.url_languages params:nil method:Urls.HTTP_GET_METHOD execute:^(Response *response) {
        if (response.object && response.state) {
            response.object = [[LanguageCode alloc] parseArrayFromData: (NSData *) response.object];
            complete(response);
        }
    }];
    
}

@end

