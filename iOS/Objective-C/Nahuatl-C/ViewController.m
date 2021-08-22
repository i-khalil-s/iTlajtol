//
//  ViewController.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "ViewController.h"
#import "TranslationTableViewCell.h"
#import "MoreButtonTableViewCell.h"
#import "Translation.h"
#import "AlertObject.h"
#import "LanguagesTableViewController.h"
#import "User.h"
#import "Constants.h"

@interface ViewController ()

@property (assign) BOOL isLoading;
@property (assign) BOOL isLoggedIn;

@property (weak, nonatomic) IBOutlet UIView *blockingView;
@property (weak, nonatomic) IBOutlet UILabel *blockingLabel;
@property (weak, nonatomic) IBOutlet UIView *blockingSendView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *blockingSendActivity;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIImageView *noTranslationsImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *sendMessageArea;
@property (weak, nonatomic) IBOutlet UITextField *sendMessageTextField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *textAreaHeightConstraint;
@property (weak, nonatomic) IBOutlet UIView *arrowButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *sendingActivityIndicator;

@property (weak, nonatomic) IBOutlet UILabel *fromArrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromArrowLanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *toArrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *toArrowLanguageLabel;
@property (weak, nonatomic) IBOutlet UILabel *techniqueArrowLabel;
@property (weak, nonatomic) IBOutlet UILabel *versionArrowLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.blockingView setHidden:NO];
    [self.noTranslationsImageView setHidden:YES];
    self.tableView.tableFooterView = UIView.new;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.title = @"Traducciones";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    // Do any additional setup after loading the view.
    
    self.translations = NSMutableArray.new;
    
    self.sendMessageArea.backgroundColor = [UIColor colorNamed:@"nonInteractive"];
    self.sendMessageTextField.delegate = self;
    self.sendMessageTextField.backgroundColor = [UIColor colorNamed:@"inputBackground"];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    self.sendMessageTextField.leftView = paddingView;
    self.sendMessageTextField.leftViewMode = UITextFieldViewModeAlways;
    self.sendMessageTextField.layer.cornerRadius = self.sendMessageTextField.frame.size.height / 2;
    [self.sendingActivityIndicator stopAnimating];
    
    self.arrowButton.backgroundColor = [UIColor colorNamed:@"button"];
    self.arrowButton.layer.cornerRadius = 10;
    
    self.sendButton.layer.cornerRadius = self.sendButton.frame.size.height / 2;
    self.sendButton.backgroundColor = [UIColor colorNamed:@"button"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openLanguagesView)];
    [self.arrowButton addGestureRecognizer:recognizer];
    self.isLoading = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    if (self.isLoading) {
        User *us = [User retreive];
        if (us) {
            user = us;
            self.isLoading = NO;
            self.isLoggedIn = YES;
            [self.blockingView setHidden:YES];
            [self.blockingLabel setHidden:YES];
            [self loadAll];
            [self loadArrows];
        } else {
            user = [User createGuest];
            [user signIn:^(Response *response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    User *usr = (User *) response.object;
                    if (usr && response.state) {
                        User *u = [usr save];
                        if (u) {
                            user = u;
                            self.isLoggedIn = YES;
                            [self.blockingView setHidden:YES];
                            [self.blockingLabel setHidden:YES];
                            [self loadAll];
                            [self loadArrows];
                        }
                    } else {
                        self.blockingLabel.text = @"Ocurrió un error";
                    }
                    self.isLoading = NO;
                });
            }];
        }
    } else {
        self.blockingLabel.text = @"Ocurrió un error";
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_translations count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TranslationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"translation" forIndexPath: indexPath];
    
    Translation *translation = _translations[indexPath. row];
    
    /// Button
    
    if ([translation._id intValue] <= 0) {
        MoreButtonTableViewCell *cellB = [tableView dequeueReusableCellWithIdentifier:@"more" forIndexPath: indexPath];
        
        return cellB;
    }
    
    /// Original
    
    cell.originalLanguageNameLabel.text = translation.arrow.from_field.language;
    cell.originalLanguageCodeLabel.text = [translation.arrow.from_field.code uppercaseString];
    
    cell.originalTextLabel.text = translation.original_text;
    
    NSString *technique = translation.arrow.corpus.technique;
    NSString *tokenizer = translation.arrow.corpus.tokenizer;
    NSString *version = translation.arrow.corpus.version;
    
    NSString *finalTechnique = [NSString stringWithFormat:@"%@ - %@ (%@)", technique, tokenizer, version];
    
    cell.originalTechniqueLabel.text = finalTechnique;
    
    /// Translation
    
    cell.traslationLanguageNameLabel.text = translation.arrow.to.language;
    cell.translationLanguageCodeLabel.text = [translation.arrow.to.code uppercaseString];
    
    cell.translationTextLabel.text = translation.translation;
    
    if (translation.corrections && translation.corrections.count > 0) {
        cell.translationIndicatorLabel.text = @"Edited";
        cell.translationIndicatorHeight.constant = 18;
    } else {
        cell.translationIndicatorLabel.text = @"";
        cell.translationIndicatorHeight.constant = 0;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self loadMore];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[MoreButtonTableViewCell class]]) {
        return false;
    }
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.translations[indexPath.row] delete:^(Response *response) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [self.translations removeObjectAtIndex: indexPath.row];
                if (self.translations.count == 0) {
                    [self.noTranslationsImageView setHidden:NO];
                }
                NSMutableArray *indexes = NSMutableArray.new;
                [indexes addObject:indexPath];
                [tableView deleteRowsAtIndexPaths:indexes withRowAnimation:UITableViewRowAnimationFade];
                [tableView reloadData];
            });
        }];
    }
}

/// main events
- (void) loadAll {
    self.translations = NSMutableArray.new;
    [self.tableView reloadData];
    self.page = [NSNumber numberWithInt: 1];
    [Translation getAll:^(Response *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response.object && [response.object isKindOfClass: [NSMutableArray class]] && response.state) {
                
                self.translations = [[[((NSMutableArray *) response.object) reverseObjectEnumerator] allObjects] mutableCopy];
                
                if (self.translations.count >= 5) {
                    Translation *t = [[Translation alloc] init];
                    t._id = [NSNumber numberWithInt:-1];
                    [self.translations insertObject:t atIndex:0];
                }
                
                [self.tableView reloadData];
                [self.tableView layoutIfNeeded];
                
                if (self.translations.count > 1) {
                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow: ([self.tableView numberOfRowsInSection:([self.tableView numberOfSections]-1)]-1) inSection: ([self.tableView numberOfSections]-1)];
                   [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
                
                if (self.translations.count == 0) {
                    [self.noTranslationsImageView setHidden:NO];
                }
                
            } else {
            UIAlertController *alert = [AlertObject:@"Atención" message:@"No se encontraron traducciones" actionText:@"Ok"];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    } at: _page];
}

- (void) loadArrows {
    [self.blockingSendActivity startAnimating];
    [Arrow getAll:^(Response *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response.object && [response.object isKindOfClass: [NSMutableArray class]] && response.state) {
                
                self.arrows = (NSMutableArray *) response.object;
                self.selectedArrow = [NSNumber numberWithInt:0];
                
                Arrow *arrow = self.arrows[self.selectedArrow.intValue];
                
                [self updateArrowView:arrow];
                [self.blockingSendActivity stopAnimating];
                
            } else {
            UIAlertController *alert = [AlertObject:@"Atención" message:@"No se encontraron flechas" actionText:@"Ok"];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    }];
}

- (void) loadMore {
    
    self.page = [NSNumber numberWithInt: _page.intValue + 1];
    
    [Translation getAll:^(Response *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (response.object && [response.object isKindOfClass: [NSMutableArray class]] && response.state) {
                
                NSMutableArray *array = ((NSMutableArray *) response.object);
                self.lastPageSize = [NSNumber numberWithInt:array.count];
                array = [[[array reverseObjectEnumerator] allObjects] mutableCopy];
                
                if (array.count == 0) {
                    [self.translations removeObjectAtIndex:0];
                }
                
                NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(1, array.count)];
                
                [self.translations insertObjects:array atIndexes:set];
                
                [self.tableView reloadData];
                [self.tableView layoutIfNeeded];
                
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow:self.lastPageSize.intValue + 1 inSection:0];
               [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
            } else {
            UIAlertController *alert = [AlertObject:@"Atención" message:@"No se encontraron traducciones" actionText:@"Ok"];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        });
    } at: _page];
}

- (void)updateArrowView:(Arrow *) arrow {
    
    self.fromArrowLabel.text = [arrow.from_field.code uppercaseString];
    self.fromArrowLanguageLabel.text = arrow.from_field.language;
    self.toArrowLabel.text = [arrow.to.code uppercaseString];
    self.toArrowLanguageLabel.text = arrow.to.language;
    
    self.techniqueArrowLabel.text = [NSString stringWithFormat:@"%@ - %@", arrow.corpus.technique , arrow.corpus.tokenizer];
    
    self.versionArrowLabel.text = [NSString stringWithFormat:@"%@(%@)", arrow.corpus.name , arrow.corpus.version];
    
    if (self.arrows.count != 0) {
        [self.blockingSendView setHidden:YES];
    } else {
        [self.blockingSendView setHidden:NO];
    }
}

/// Events

- (IBAction)didTapSendButton:(UIButton *)sender {
    [self.sendMessageTextField resignFirstResponder];
    [self.view endEditing:YES];
    [self.sendingActivityIndicator startAnimating];
    [self.sendButton setHidden:YES];
    
    Translation *translation = Translation.new;
    translation._id = [NSNumber numberWithInt:0];
    translation.arrow = self.arrows[self.selectedArrow.intValue];
    translation.original_text = self.sendMessageTextField.text;
    translation.translation = @"";
    translation.app_version = @"0.0.1";
    translation.user_id = user._id;
    
    [translation send:^(Response *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            Translation *trs = (Translation *) response.object;
            if (trs && response.state) {
                [self.translations addObject:trs];
                [self.noTranslationsImageView setHidden:YES];
                [self.tableView reloadData];
                if (self.translations.count > 1) {
                    [self.tableView layoutIfNeeded];
                    NSIndexPath* indexPath = [NSIndexPath indexPathForRow: ([self.tableView numberOfRowsInSection:([self.tableView numberOfSections]-1)]-1) inSection: ([self.tableView numberOfSections]-1)];
                   [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                }
                self.sendMessageTextField.text = @"";
            } else {
                UIAlertController *alert = [AlertObject:@"Atención" message:@"No se pudo traducir" actionText:@"Ok"];
                [self presentViewController:alert animated:YES completion:nil];
            }
            [self.sendingActivityIndicator stopAnimating];
            [self.sendButton setHidden:NO];
        });
    }];
}

- (void)openLanguagesView {
    
    LanguagesTableViewController *langsController = [self.storyboard instantiateViewControllerWithIdentifier:@"LanguagesTableViewController"];
    langsController.arrows = self.arrows;
    langsController.selectedIndex = self.selectedArrow;
    langsController.delegate = self;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:langsController];
    
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {
    [sender setTitle:(self.tableView.editing ? @"Editar":@"Ok")];
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}

- (IBAction)updateAllButtonTapped:(id)sender {
    [self loadAll];
    [self loadArrows];
}



/// Keyboards
- (void)keyboardWillChange:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil];
    
    if (keyboardRect.size.height < [NSNumber numberWithDouble:100.0].doubleValue) {
        self.textAreaHeightConstraint.constant = 170;
    } else {
        self.textAreaHeightConstraint.constant = keyboardRect.size.height - [[[UIApplication sharedApplication] keyWindow] safeAreaInsets].bottom + 8 + 170;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.translations.count > 1) {
                NSIndexPath* indexPath = [NSIndexPath indexPathForRow: ([self.tableView numberOfRowsInSection:([self.tableView numberOfSections]-1)]-1) inSection: ([self.tableView numberOfSections]-1)];
               [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            }
        });
    }
    
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
    
    self.textAreaHeightConstraint.constant = 170;
}

/// Delegates


- (void)didSelectLanguageAt:(NSNumber *)index {
    self.selectedArrow = index;
    [self updateArrowView:self.arrows[index.intValue]];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.sendMessageTextField) {
        if (textField.text.length < 150 || string.length == 0){
            return YES;
        }
        else{
            return NO;
        }
    }
    return YES;
}

@end

