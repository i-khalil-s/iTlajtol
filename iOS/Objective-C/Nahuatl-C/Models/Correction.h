//
//  Correction.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import <Foundation/Foundation.h>
#import "LanguageCode.h"

NS_ASSUME_NONNULL_BEGIN

@interface Correction : NSObject

@property (strong, nonatomic) NSNumber *_id;
@property (strong, nonatomic) NSString *correction;
@property (strong, nonatomic) NSNumber *id_translation;
@property (strong, nonatomic) NSNumber *id_language;
@property (strong, nonatomic) LanguageCode *language;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<Correction *> *) parseArrayFromData:(NSData *) data;

@end

NS_ASSUME_NONNULL_END
