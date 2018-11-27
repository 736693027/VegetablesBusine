//
//  LBResponseModel.m
//  LBAssistant
//
//  Created by WangKeke on 16/4/28.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import "LBResponseModel.h"
#import "YYModel.h"

@implementation LBResponseModel

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    id data = dic[@"data"];
    if (data) {
        self.jsonString =  [data yy_modelToJSONString];
    }
    
    return YES;
}

@end
