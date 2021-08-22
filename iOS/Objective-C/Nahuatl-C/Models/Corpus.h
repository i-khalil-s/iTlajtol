//
//  Corpus.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Corpus : NSObject

@property (strong, nonatomic) NSNumber *_id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *technique;
@property (strong, nonatomic) NSString *version;
@property (strong, nonatomic) NSString *tokenizer;
@property (assign) BOOL reverse;
@property (strong, nonatomic) NSString *bleu;
@property (strong, nonatomic) NSString *file_name;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<Corpus *> *) parseArrayFromData:(NSData *) data;

@end

NS_ASSUME_NONNULL_END
