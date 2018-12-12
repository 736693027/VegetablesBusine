//
//  VBManageCommodityDeleteClassificationRequest.m
//  VegetablesBusine
//
//  Created by Apple on 2018/12/12.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "VBManageCommodityDeleteClassificationRequest.h"

@implementation VBManageCommodityDeleteClassificationRequest{
    NSString *_classificationId;
}

- (instancetype)initWithClassificationId:(NSString *)classificationId {
    self = [super init];
    if(self){
        _classificationId = classificationId
    }
    return self;
}
@end
