//
//  VBBluetoothListViewController.h
//  VegetablesBusine
//
//  Created by Apple on 2019/1/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VBBluetoothListViewController : BaseViewController

@property (strong, nonatomic) RACSubject *connectSuccessSubject;

@end

NS_ASSUME_NONNULL_END
