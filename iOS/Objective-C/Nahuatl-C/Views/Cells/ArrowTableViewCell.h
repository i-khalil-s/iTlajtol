//
//  ArrowTableViewCell.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 09/03/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArrowTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *arrowButtonView;

@property (weak, nonatomic) IBOutlet UILabel *fromLanguageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLanguageCodeLabel;

@property (weak, nonatomic) IBOutlet UILabel *toLanguageCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLanguageNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *corpusTechniqueLabel;
@property (weak, nonatomic) IBOutlet UILabel *corpusVersionLabel;

@end

NS_ASSUME_NONNULL_END
