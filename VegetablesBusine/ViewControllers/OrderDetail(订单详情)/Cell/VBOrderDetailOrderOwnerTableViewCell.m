//
//  VBOrderDetailOrderOwnerTableViewCell.m
//  VegetablesBusine
//
//  Created by Apple on 2018/5/24.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "VBOrderDetailOrderOwnerTableViewCell.h"
#import "VBWaitDealListModel.h"
#import "VBMapViewController.h"

@interface VBOrderDetailOrderOwnerTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *orderOwnerLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation VBOrderDetailOrderOwnerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setItemModel:(VBWaitDealListModel *)itemModel {
    _itemModel = itemModel;
    self.orderOwnerLabel.text = itemModel.orderOwer;
    self.orderCountLabel.text = [NSString stringWithFormat:@"#第%@次下单",itemModel.orderCount];
    self.telLabel.text = itemModel.orderTel;
    self.addressLabel.text = itemModel.address;
}
- (IBAction)callTelPhone:(id)sender {
    NSString *telString = [NSString stringWithFormat:@"tel:%@",self.itemModel.orderTel];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
}
- (IBAction)showAddressButtonClick:(id)sender {
    VBMapViewController *mapViewControl = [[VBMapViewController alloc] init];
    mapViewControl.Longitude = self.itemModel.Longitude;
    mapViewControl.latitude = self.itemModel.latitude;
    [self.viewControl.navigationController pushViewController:mapViewControl animated:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
