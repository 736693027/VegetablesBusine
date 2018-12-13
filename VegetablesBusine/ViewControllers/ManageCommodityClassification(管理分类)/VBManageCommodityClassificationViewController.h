//
//  VBManageCommodityClassificationViewController.h
//  
//
//  Created by 刘少轩 on 2018/6/27.
//

#import "BaseViewController.h"
@class RACSubject;

@interface VBManageCommodityClassificationViewController : BaseViewController

@property (strong, nonatomic) RACSubject *didSelectItemSubject;

@end
