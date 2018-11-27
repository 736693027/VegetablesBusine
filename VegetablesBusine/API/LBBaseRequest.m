//
//  LBBaseRequest.m
//  LBQuote
//
//  Created by FSLB on 16/2/29.
//  Copyright © 2016年 fengshunlubao. All rights reserved.
//

#import "LBBaseRequest.h"
#import "LBBaseModel.h"
//#import "LBUserManager.h"

@implementation LBBaseRequest

- (void) startRequestWithDicSuccess:(void (^)(NSDictionary *responseDic))success failModel:(void (^)(LBResponseModel *errorModel))error fail:(void (^)(YTKBaseRequest *request))fail{
    [self startRequestWithDicSuccess:success arraySuccuss:nil failModel:error fail:fail];
}

- (void) startRequestWithArraySuccess:(void (^)(NSArray *responseArray))success failModel:(void (^)(LBResponseModel *errorModel))error fail:(void (^)(YTKBaseRequest *request))fail{
    [self startRequestWithDicSuccess:nil arraySuccuss:success failModel:error fail:fail];
}

- (void) clearBlock{
    self.successDicBlock = nil;
    self.successArrayBlock = nil;
    
    _errorModelBlock = nil;
    _failBlock = nil;
    _timeOut = nil;
}
//超时时间
- (NSTimeInterval)requestTimeoutInterval{
    return 30;
}

#pragma mark - private

- (void)startRequestWithDicSuccess:(void (^)(NSDictionary *responseDic))dicSuccess arraySuccuss:(void (^)(NSArray *responseArray))arraySuccess failModel:(void (^)(LBResponseModel *errorModel))error fail:(void (^)(YTKBaseRequest *request))fail{
    
    self.successDicBlock = dicSuccess;
    self.successArrayBlock = arraySuccess;
    self.failBlock = fail;
    self.errorModelBlock = error;
    
    
    void(^successBlock)(id response) = nil;
    
    if (dicSuccess) {
        successBlock = dicSuccess;
    }else if(arraySuccess){
        successBlock = arraySuccess;
    }
    
    __weak typeof(self) weakSelf = self;
    
    [self startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
        
        if(request.responseString){
            
            LBResponseModel * responseModel = [LBResponseModel yy_modelWithJSON:request.responseString];
            
            if (responseModel.reslut.integerValue == RESPONSE_CODE_SUCCESS){//请求成功
                
                if ([responseModel.jsonString isKindOfClass:[NSString class]]) {
                    
                    NSData *jsonData = [(NSString *)responseModel.jsonString dataUsingEncoding : NSUTF8StringEncoding];
                    
                    id dicOrArray = jsonData?[NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL]:nil;
                    
                    if ((dicSuccess && [dicOrArray isKindOfClass:[NSDictionary class]])|| //保证请求返回指定类型，或者nil
                        (arraySuccess && [dicOrArray isKindOfClass:[NSArray class]])) {

                        dispatch_async(dispatch_get_main_queue(), ^{
                            successBlock(dicOrArray);
                        });
                        
                    }else{
                        successBlock(nil);
                    }
                    
                }else{
                    successBlock(nil);
                }
                
            }else if(responseModel.reslut.integerValue == RESPONSE_CODE_SESSIONINVALID){//session失效
                
                dispatch_async(dispatch_get_main_queue(), ^{
                });
                
            }else{//业务错误
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    error(responseModel);
                });
            }
            
        }else{//请求错误
            
            dispatch_async(dispatch_get_main_queue(), ^{
                fail(request);
            });
        }
        
        [weakSelf clearBlock];
        
    } failure:^(YTKBaseRequest *request) {
        weakSelf.failBlock(request);
        [weakSelf clearBlock];
    }];

}

@end
