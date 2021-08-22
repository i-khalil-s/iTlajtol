//
//  Correction.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import "Correction.h"

@implementation Correction

- (NSMutableDictionary *)createDict {
    
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.correction forKey:@"correction"];
    [dict setValue:self.id_translation forKey:@"id_translation"];
    [dict setValue:self.id_language forKey:@"id_language"];
    [dict setValue:[self.language createDict] forKey:@"language"];
    
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.correction = dict[@"correction"];
    self.id_translation = dict[@"id_translation"];
    self.id_language = dict[@"id_language"];
    self.language = [[LanguageCode alloc] initWithDict: dict[@"language"]];
    return self;
}

- (NSMutableArray<Correction *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<Correction *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[Correction alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

@end
