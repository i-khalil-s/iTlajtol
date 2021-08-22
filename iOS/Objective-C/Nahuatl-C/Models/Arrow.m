//
//  Arrow.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import "Arrow.h"
#import "Blocks.h"
#import "Constants.h"
#import "Urls.h"
#import "Response.h"

@implementation Arrow

- (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:[self.from_field createDict] forKey:@"from_field"];
    [dict setValue:[self.to createDict] forKey:@"to"];
    [dict setValue:[self.corpus createDict] forKey:@"corpus"];
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.from_field = [[LanguageCode alloc] initWithDict: dict[@"from_field"]];
    self.to = [[LanguageCode alloc] initWithDict: dict[@"to"]];
    self.corpus = [[Corpus alloc] initWithDict: dict[@"corpus"]];
    return self;
}

- (NSMutableArray<Arrow *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<Arrow *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[Arrow alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

+ (void) getAll:(completion) complete {
    
        NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
        conf.timeoutIntervalForRequest = [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue];
        conf.timeoutIntervalForResource = [Constants.TIME_OUT_INTERVAL_FOR_RESOURCE doubleValue];
        
        NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
        
    [Urls runWithSession:session url:Urls.url_arrows params:nil method:Urls.HTTP_GET_METHOD execute:^(Response *response) {
        if (response.object && response.state) {
            response.object = [[Arrow alloc] parseArrayFromData: (NSData *) response.object];
            complete(response);
        }
    }];
    
}

@end
