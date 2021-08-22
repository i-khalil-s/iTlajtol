//
//  TranslationTableViewCell.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 07/03/21.
//

#import "TranslationTableViewCell.h"
#import <UIKit/UIKit.h>

@implementation TranslationTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.cardView.layer.cornerRadius = 15;
    self.cardView.clipsToBounds = YES;
    self.cardView.backgroundColor = [UIColor colorNamed:@"interactive"];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)copyButtonTapped:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.originalTextLabel.text;
}

- (IBAction)copyTranslationButtonTapped:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.translationTextLabel.text;
}

@end
