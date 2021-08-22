//
//  TranslationTableViewCell.h
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TranslationTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *originalLanguageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalLanguageCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalTechniqueLabel;
@property (weak, nonatomic) IBOutlet UIButton *originalCopyButton;

/// Translation

@property (weak, nonatomic) IBOutlet UILabel *traslationLanguageNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *translationLanguageCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *translationTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *translationIndicatorLabel;
@property (weak, nonatomic) IBOutlet UIButton *translationCopyButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *translationIndicatorHeight;
@property (weak, nonatomic) IBOutlet UIView *cardView;


@end

NS_ASSUME_NONNULL_END
