//
//  VBOrderManagerTableViewViewController.h
//  VegetablesBusine
//
//  Created by Apple on 2018/5/9.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "BaseTableViewController.h"
#import "VBOrderManagerEnumHeaderFile.h"

@interface VBOrderManagerTableViewViewController : BaseTableViewController

@property (nonatomic) VBOrderManagerTableViewStyle viewStyle;
@property (copy, nonatomic) NSString *searchDateTime;
@end
