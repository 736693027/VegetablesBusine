//
//  VBSetupTableViewCell.h
//  VegetablesBusine
//
//  Created by Apple on 2018/6/10.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VBSetupTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *detaiLabel;
@property (weak, nonatomic) IBOutlet UISwitch *stateSwitch;

@end
