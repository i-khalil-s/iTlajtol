//
//  ViewController.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <UIKit/UIKit.h>
#import "Translation.h"
#import "LanguagesTableViewController.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, LanguagesTableViewControllerDelegate, UISearchTextFieldDelegate>

@property (strong, nonatomic) NSMutableArray<Translation *> *translations;
@property (strong, nonatomic) NSMutableArray<Arrow *> *arrows;
@property (strong, nonatomic) NSNumber *page;
@property (strong, nonatomic) NSNumber *lastPageSize;
@property (strong, nonatomic) NSNumber *selectedArrow;

- (void)openLanguagesView;
@end

