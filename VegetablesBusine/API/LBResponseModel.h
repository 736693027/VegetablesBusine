//
//  LBResponseModel.h
//  LBAssistant
//
//  Created by WangKeke on 16/4/28.
//  Copyright © 2016年 FSLB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    RESPONSE_CODE_SUCCESS = 0,
    RESPONSE_CODE_SESSIONINVALID,
    RESPONSE_CODE_ERROR,
} RESPONSE_CODE;

@interface LBResponseModel : NSObject

/** 返回码 0:成功、1:session失效 */
@property (nonatomic, copy) NSString * reslut;
/** 信息描述 */
@property (nonatomic, copy) NSString * message;
/** json对象 */
@property (nonatomic, copy) NSString *jsonString;

@property (nonatomic, assign) BOOL success;

@end
