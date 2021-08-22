//
//  AlertObject.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AlertObject : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *actionText;

+ (UIAlertController *):(NSString *) title message:(NSString *) message actionText:(NSString *) actionText;

@end

NS_ASSUME_NONNULL_END
