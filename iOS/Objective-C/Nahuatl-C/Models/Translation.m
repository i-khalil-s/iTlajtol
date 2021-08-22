//
//  Translation.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "Translation.h"
#import "Blocks.h"
#import "Constants.h"
#import "Urls.h"
#import "Response.h"

@implementation Translation

- (NSMutableDictionary *)createDict {
    
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.arrow._id forKey:@"arrow"];
    [dict setValue:self.original_text forKey:@"original_text"];
    [dict setValue:self.translation forKey:@"translation"];
    [dict setValue:self.app_version forKey:@"app_version"];
    
    [dict setValue:self.user_id forKey:@"user_id"];
    
//    NSMutableArray *corrections = NSMutableArray.new;
//
//    for (Correction *correction in self.corrections) {
//        [corrections addObject: [correction createDict]];
//    }
//
//    [dict setValue:corrections forKey:@"corrections"];
    
//    [dict setValue:self.corrections forKey:@"corrections"];
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.arrow = [[Arrow alloc] initWithDict: dict[@"arrow"]];
    self.original_text = dict[@"original_text"];
    self.translation = dict[@"translation"];
    self.app_version = dict[@"app_version"];
    NSMutableArray *corrs = NSMutableArray.new;
    for (NSDictionary *dcorractions in dict[@"corrections"]) {
        [corrs addObject:[[Correction alloc] initWithDict: dcorractions]];
    }
    self.corrections = corrs;
    return self;
}

- (NSMutableArray<Translation *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<Translation *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[Translation alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

+ (void) getAll:(completion) complete at:(NSNumber *) page {
    
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
    conf.timeoutIntervalForRequest = [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue];
    conf.timeoutIntervalForResource = [Constants.TIME_OUT_INTERVAL_FOR_RESOURCE doubleValue];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
    
    [Urls runWithSession:session url:[Urls url_translationsGet:user._id at:page] params:nil method:Urls.HTTP_GET_METHOD execute:^(Response *response) {
        if (response.object && response.state) {
            response.object = [[Translation alloc] parseArrayFromData: (NSData *) response.object];
            complete(response);
        }
    }];
    
}

- (void) send:(completion) complete {
    
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
    
    [Urls runWithSession:session url:Urls.url_translate params: params method:Urls.HTTP_POST_METHOD execute:^(Response *response) {
        if (response.object && response.state) {
            NSError *error;
            NSDictionary *dictt = [NSJSONSerialization JSONObjectWithData:(NSData *) response.object options:NSJSONReadingAllowFragments error:&error];
            response.object = [[Translation alloc] initWithDict:dictt];
            complete(response);
        }
    }];
    
}

- (void) delete:(completion) complete {
    
    NSURLSessionConfiguration *conf = NSURLSessionConfiguration.defaultSessionConfiguration;
    conf.timeoutIntervalForRequest = [Constants.TIME_OUT_INTERVAL_FOR_REQUEST doubleValue];
    conf.timeoutIntervalForResource = [Constants.TIME_OUT_INTERVAL_FOR_RESOURCE doubleValue];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:conf];
    
    [Urls runWithSession:session url:[Urls url_translations:self._id] params:nil method:Urls.HTTP_DELETE_METHOD execute:^(Response *response) {
        if (response.state) {
            complete(response);
        }
    }];
    
}

@end
