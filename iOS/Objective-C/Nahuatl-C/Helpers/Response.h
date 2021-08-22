//
//  Response.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Response : NSObject

@property (assign) BOOL state;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic)  NSObject * _Nullable object;

+ (void) initialize;
- (id) initNO;
- (id) initWithState:(BOOL)state  message: (NSString *) message object: (NSObject * _Nullable) object;
@end

NS_ASSUME_NONNULL_END
