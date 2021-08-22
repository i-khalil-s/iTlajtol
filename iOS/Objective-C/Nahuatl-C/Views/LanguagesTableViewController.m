//
//  LanguagesTableViewController.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import "LanguagesTableViewController.h"
#import "ArrowTableViewCell.h"

@interface LanguagesTableViewController ()

@end

@implementation LanguagesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.navigationItem.title = @"Idiomas";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArrowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"arrowCell" forIndexPath:indexPath];
    
    Arrow *arrow = self.arrows[indexPath.row];
    
    cell.arrowButtonView.layer.cornerRadius = 10;
    cell.arrowButtonView.clipsToBounds = YES;
    
    if (indexPath.row % 2 == 0) {
        cell.arrowButtonView.backgroundColor = [UIColor colorNamed:@"button"];
    } else {
        cell.arrowButtonView.backgroundColor = [UIColor colorNamed:@"interactive"];
    }
    
    if (indexPath.row == self.selectedIndex.intValue) {
        if (UIScreen.mainScreen.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            cell.arrowButtonView.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
        } else {
            cell.arrowButtonView.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
        }
    } else {
        cell.arrowButtonView.overrideUserInterfaceStyle = UIScreen.mainScreen.traitCollection.userInterfaceStyle;
    }
    
    
    
    cell.fromLanguageCodeLabel.text = [arrow.from_field.code uppercaseString];
    cell.fromLanguageNameLabel.text = arrow.from_field.language;
    
    cell.toLanguageCodeLabel.text = [arrow.to.code uppercaseString];
    cell.toLanguageNameLabel.text = arrow.to.language;
    
    cell.corpusTechniqueLabel.text = [NSString stringWithFormat:@"%@ - %@", arrow.corpus.technique, arrow.corpus.tokenizer];
    cell.corpusVersionLabel.text = [NSString stringWithFormat:@"%@(%@)", arrow.corpus.name, arrow.corpus.version];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectLanguageAt: [NSNumber numberWithInt:indexPath.row]];
    [self dismissViewControllerAnimated:YES completion:^{
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }];
    
}

@end
