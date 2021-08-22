//
//  MoreButtonTableViewCell.m
//  Nahuatl-C
//
//  Created by Sergio Khalil Bello Garcia on 08/03/21.
//

#import "MoreButtonTableViewCell.h"

@implementation MoreButtonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.loadMoreButton.backgroundColor = [UIColor colorNamed:@"button"];
    self.loadMoreButton.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
