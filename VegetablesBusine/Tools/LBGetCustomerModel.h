//
//  LBGetCustomerModel.h
//  LBReport
//
//  Created by penzhk on 16/4/27.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "LBBaseModel.h"

@interface LBGetCustomerModel : LBBaseModel

@property (nonatomic, assign) NSInteger vipId;

@property (nonatomic, copy) NSString *vipName;

@property (nonatomic, copy) NSString *loginName;

@end


