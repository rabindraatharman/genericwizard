//
//  BIDNameAndColorCell.m
//  genericwizard
//
//  Created by Rabindra Nath Sharma on 23/08/17.
//  Copyright © 2017 Rabindra Nath Sharma. All rights reserved.
//

#import "WizardCell.h"

@interface WizardCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation WizardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)n
{
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.nameLabel.text = _name;
    }
}
- (void)setColor:(NSString *)c
{
    if (![c isEqualToString:_color]) {
        _color = [c copy];
        self.colorLabel.text = _color;
    }
}


@end
