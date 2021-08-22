//
//  CoreUser.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import "CoreUser.h"
#import <UIKit/UIKit.h>

@implementation CoreUser

- (NSMutableDictionary *)createDict {
    NSMutableDictionary *dict = NSMutableDictionary.new;
    //Encode properties, other class variables, etc
    [dict setValue:self._id forKey:@"id"];
    [dict setValue:self.password forKey:@"password"];
    [dict setValue:self.username forKey:@"username"];
    [dict setValue:self.firstName forKey:@"first_name"];
    [dict setValue:self.lastName forKey:@"last_name"];
    [dict setValue:self.email forKey:@"email"];
    
    [dict setValue:self.isSuperuser forKey:@"is_superuser"];
    [dict setValue:self.isStaff forKey:@"is_staff"];
    [dict setValue:self.isActive forKey:@"is_active"];
    return dict;
}

- initWithDict:(NSDictionary *) dict {
    self._id = dict[@"id"];
    self.password =  dict[@"password"];
    self.username = dict[@"username"];
    self.firstName = dict[@"first_name"];
    self.lastName = dict[@"last_name"];
    self.email = dict[@"email"];
    
    self.isSuperuser = dict[@"is_superuser"];
    self.isStaff = dict[@"is_staff"];
    self.isActive = dict[@"is_active"];
    
    return self;
}

- (NSMutableArray<CoreUser *> *) parseArrayFromData:(NSData *) data {
    
    NSMutableArray<CoreUser *> *finalArray = NSMutableArray.new;
    
    NSError *error;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    
    if (error) {
        return nil;
    }
    
    for (NSDictionary *dict in array) {
        [finalArray addObject:[[CoreUser alloc] initWithDict:dict]];
    }
    
    return finalArray;
}

static CoreUser *guest;
+ (CoreUser *) guest {
    @synchronized (self) {
        CoreUser *usr = CoreUser.new;
        NSString *UUID = UIDevice.currentDevice.identifierForVendor.UUIDString;
        usr.email = UUID;
        usr.username = UUID;
        usr.password = UUID;
        
        usr.firstName = @".";
        usr.lastName = @".";
        
        usr.isSuperuser =[NSNumber numberWithInt:0];
        usr.isStaff =[NSNumber numberWithInt:0];
        usr.isActive =[NSNumber numberWithInt:0];
        
        return usr;
    }
}

@end
