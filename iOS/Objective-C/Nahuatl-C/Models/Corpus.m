//
//  Corpus.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import "Corpus.h"

@implementation Corpus

- (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.name forKey:@"name"];
    [dict setValue:self.technique forKey:@"technique"];
    [dict setValue:self.version forKey:@"version"];
    [dict setValue:self.tokenizer forKey:@"tokenizer"];
//    [dict setValue:self.reverse forKey:@"reverse"];
    [dict setValue:self.bleu forKey:@"bleu"];
    [dict setValue:self.file_name forKey:@"file_name"];
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.name = dict[@"name"];
    self.technique = dict[@"technique"];
    self.version = dict[@"version"];
    self.tokenizer = dict[@"tokenizer"];
    self.reverse = dict[@"reverse"];
    self.bleu = dict[@"bleu"];
    self.file_name = dict[@"file_name"];
    return self;
}

- (NSMutableArray<Corpus *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<Corpus *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[Corpus alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

@end
