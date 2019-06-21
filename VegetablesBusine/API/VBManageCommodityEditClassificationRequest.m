//
//  VBManageCommodityEditClassificationRequest.m
//  VegetablesBusine
//
//  Created by ldv on 2019/1/6.
//  Copyright © 2019年 Apple. All rights reserved.
//

#import "VBManageCommodityEditClassificationRequest.h"
#import "VBAddGoodsInfoModel.h"
#import "AFURLRequestSerialization.h"

@implementation VBManageCommodityEditClassificationRequest
{
    VBAddGoodsInfoModel *innerModel;
    UIImage *_uploadImage;
}

- (instancetype)initWithGoodsInfoModel:(VBAddGoodsInfoModel *)model uploadImage:(UIImage *)uploadImage{
    if (self = [super init]) {
        innerModel = model;
        _uploadImage = uploadImage;
    }
    return self;
}

- (NSString *)requestUrl {
    return @"/api/store/commodityEdit";
}

- (AFConstructingBlock)constructingBodyBlock{
    return ^(id<AFMultipartFormData>formData){
        NSData *imageData = UIImagePNGRepresentation(_uploadImage);
        [formData appendPartWithFileData:imageData
                                    name:@"imgs"
                                fileName:@"imgs"
                                mimeType:@"image/jpg"];
    };
}
- (id)requestArgument {
    NSString *standardsString = [innerModel.standards componentsJoinedByString:@","];
    NSDictionary *dic = @{
                          @"name":OBJC(innerModel.name),
                          @"subtitle":OBJC(innerModel.subtitle),
                          @"commodityID":@(innerModel.commodityID.integerValue),
                          @"price":OBJC(innerModel.price),
                          @"foodContainerPrice":OBJC(innerModel.foodContainerPrice),
                          @"uniti":OBJC(innerModel.uniti),
                          @"classifyID":OBJC(innerModel.classifyID),
                          @"standards":@(standardsString.integerValue),
                          @"inventory":OBJC(innerModel.inventory),
                          @"sessionKey":OBJC(self.sessionKey)
                          };
    return dic;
}
- (NSTimeInterval)requestTimeoutInterval{
    return 60;
}
@end
