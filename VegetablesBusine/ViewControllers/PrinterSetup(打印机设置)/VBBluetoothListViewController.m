//
//  VBBluetoothListViewController.m
//  VegetablesBusine
//
//  Created by Apple on 2019/1/8.
//  Copyright © 2019 Apple. All rights reserved.
//

#import "VBBluetoothListViewController.h"
#import "HLBLEManager.h"
#import "SVProgressHUD.h"

@interface VBBluetoothListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */

@end

@implementation VBBluetoothListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"蓝牙列表";
    
    _deviceArray = [[NSMutableArray alloc] init];
    _tableView.rowHeight = 60;
    
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    __weak HLBLEManager *weakManager = manager;
    manager.stateUpdateBlock = ^(CBCentralManager *central) {
        NSString *info = nil;
        switch (central.state) {
            case CBCentralManagerStatePoweredOn:
                info = @"蓝牙已打开，并且可用";
                //三种种方式
                // 方式1
                [weakManager scanForPeripheralsWithServiceUUIDs:nil options:nil];
                //                // 方式2
                //                [central scanForPeripheralsWithServices:nil options:nil];
                //                // 方式3
                //                [weakManager scanForPeripheralsWithServiceUUIDs:nil options:nil didDiscoverPeripheral:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
                //
                //                }];
                break;
            case CBCentralManagerStatePoweredOff:
                info = @"蓝牙可用，未打开";
                break;
            case CBCentralManagerStateUnsupported:
                info = @"SDK不支持";
                break;
            case CBCentralManagerStateUnauthorized:
                info = @"程序未授权";
                break;
            case CBCentralManagerStateResetting:
                info = @"CBCentralManagerStateResetting";
                break;
            case CBCentralManagerStateUnknown:
                info = @"CBCentralManagerStateUnknown";
                break;
        }
        
        [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
        [SVProgressHUD showInfoWithStatus:info ];
    };
    @weakify(self);
    manager.discoverPeripheralBlcok = ^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        @strongify(self)
        if (peripheral.name.length <= 0) {
            return ;
        }
        
        if (self.deviceArray.count == 0) {
            NSDictionary *dict = @{@"peripheral":peripheral, @"RSSI":RSSI};
            [self.deviceArray addObject:dict];
        } else {
            BOOL isExist = NO;
            for (int i = 0; i < self.deviceArray.count; i++) {
                NSDictionary *dict = [self.deviceArray objectAtIndex:i];
                CBPeripheral *per = dict[@"peripheral"];
                if ([per.identifier.UUIDString isEqualToString:peripheral.identifier.UUIDString]) {
                    isExist = YES;
                    NSDictionary *dict = @{@"peripheral":peripheral, @"RSSI":RSSI};
                    [self.deviceArray replaceObjectAtIndex:i withObject:dict];
                }
            }
            
            if (!isExist) {
                NSDictionary *dict = @{@"peripheral":peripheral, @"RSSI":RSSI};
                [self.deviceArray addObject:dict];
            }
        }
        
        [self.tableView reloadData];
        
    };
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _deviceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"deviceId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    NSDictionary *dict = [self.deviceArray objectAtIndex:indexPath.row];
    CBPeripheral *peripherral = dict[@"peripheral"];
    cell.textLabel.text = [NSString stringWithFormat:@"名称:%@",peripherral.name];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"信号强度:%@",dict[@"RSSI"]];
    if (peripherral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = [self.deviceArray objectAtIndex:indexPath.row];
    CBPeripheral *peripheral = dict[@"peripheral"];
    HLBLEManager *manager = [HLBLEManager sharedInstance];
    [manager connectPeripheral:peripheral
                connectOptions:@{CBConnectPeripheralOptionNotifyOnDisconnectionKey:@(YES)}
        stopScanAfterConnected:YES
               servicesOptions:nil
        characteristicsOptions:nil
                 completeBlock:^(HLOptionStage stage, CBPeripheral *peripheral, CBService *service, CBCharacteristic *character, NSError *error) {
                     switch (stage) {
                         case HLOptionStageConnection:
                         {
                             if (error) {
                                 [SVProgressHUD showErrorWithStatus:@"连接失败"];
                                 
                             } else {
                                 [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                                 if(self.connectSuccessSubject){
                                     [self.connectSuccessSubject sendNext:@""];
                                 }
                                 [self.navigationController popViewControllerAnimated:YES];
                             }
                             break;
                         }
                         case HLOptionStageSeekServices:
                         {
                             if (error) {
                                 [SVProgressHUD showSuccessWithStatus:@"查找服务失败"];
                             } else {
                                 [SVProgressHUD showSuccessWithStatus:@"查找服务成功"];
                             }
                             break;
                         }
                         case HLOptionStageSeekCharacteristics:
                         {
                             // 该block会返回多次，每一个服务返回一次
                             if (error) {
                                 NSLog(@"查找特性失败");
                             } else {
                                 NSLog(@"查找特性成功");
                             }
                             break;
                         }
                         case HLOptionStageSeekdescriptors:
                         {
                             // 该block会返回多次，每一个特性返回一次
                             if (error) {
                                 NSLog(@"查找特性的描述失败");
                             } else {
                                 NSLog(@"查找特性的描述成功");
                             }
                             break;
                         }
                         default:
                             break;
                     }
                     
                 }];
}


@end
