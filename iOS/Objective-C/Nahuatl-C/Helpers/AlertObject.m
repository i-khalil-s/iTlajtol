//
//  AlertObject.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <UIKit/UIKit.h>
#import "AlertObject.h"

@implementation AlertObject

+ (UIAlertController *):(NSString *) title message:(NSString *) message actionText:(NSString *) actionText {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:actionText style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    
    [alert addAction:action];
    return alert;
}

@end
