//
//  Arrow.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import <Foundation/Foundation.h>
#import "LanguageCode.h"
#import "Corpus.h"

NS_ASSUME_NONNULL_BEGIN

@interface Arrow : NSObject

@property (strong, nonatomic) NSNumber *_id;
@property (strong, nonatomic) LanguageCode *from_field;
@property (strong, nonatomic) LanguageCode *to;
@property (strong, nonatomic) Corpus *corpus;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<Arrow *> *) parseArrayFromData:(NSData *) data;

+ (void) getAll:(completion) complete;

@end

NS_ASSUME_NONNULL_END
