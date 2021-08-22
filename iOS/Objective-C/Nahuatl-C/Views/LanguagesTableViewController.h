//
//  LanguagesTableViewController.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import <UIKit/UIKit.h>
#import "Arrow.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LanguagesTableViewControllerDelegate <NSObject>
- (void)didSelectLanguageAt:(NSNumber *) index;
@end

@interface LanguagesTableViewController : UITableViewController

@property (strong, nonatomic) NSMutableArray<Arrow *> *arrows;
@property (strong, nonatomic) NSNumber *selectedIndex;
@property (nonatomic, weak) id <LanguagesTableViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
