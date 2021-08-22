//
//  Translation.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <Foundation/Foundation.h>
#import "Arrow.h"
#import "Correction.h"

NS_ASSUME_NONNULL_BEGIN

@interface Translation : NSObject

@property (strong, nonatomic) NSNumber *_id;

@property (strong, nonatomic) Arrow *arrow;
@property (strong, nonatomic) NSString *original_text;
@property (strong, nonatomic) NSString *translation;
@property (strong, nonatomic) NSString *app_version;
@property (strong, nonatomic) NSMutableArray<Correction *> *corrections;

@property (strong, nonatomic) NSNumber *user_id;

- (NSMutableDictionary *)createDict;
- initWithDict:(NSDictionary *) dict;
- (NSMutableArray<Arrow *> *) parseArrayFromData:(NSData *) data;

+ (void) getAll:(completion) complete at:(NSNumber *) page;
- (void) send:(completion) complete;
- (void) delete:(completion) complete;
@end

NS_ASSUME_NONNULL_END
