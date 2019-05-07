//
//  VBMerchantSettlementDataViewRequest.h
//  VegetablesBusine
//
//  Created by ldv on 2019/1/6.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "VBSessionKeyBaseRequest.h"

@interface VBMerchantSettlementDataViewRequest : VBSessionKeyBaseRequest
- (instancetype)initWithTabNumber:(NSInteger)tab currentPage:(NSInteger)page;
@end
