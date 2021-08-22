//
//  LanguageCode.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <Foundation/Foundation.h>
#import "Blocks.h"

NS_ASSUME_NONNULL_BEGIN

@interface LanguageCode : NSObject

@property (strong, nonatomic) NSNumber *_id;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *language;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<LanguageCode *> *) parseArrayFromData:(NSData *) data;

+ (void) getAll:(completion) complete;

@end

NS_ASSUME_NONNULL_END
