//
//  Response.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "Response.h"
#import "Urls.h"

@implementation Response

+ (void) initialize {
    
}

- (id) initNO {
    self = [super init];
    self.state = NO;
    self.object = nil;
    self.message = Urls.ERROR_MESSAGE;
    return self;
}

- initWithState:(BOOL)state  message: (NSString *) message object: (NSObject * _Nullable) object {
    self.state = state;
    self.object = object;
    self.message = message;
    return self;
}

@end
