//
//  BLEMainTVC.m
//  BLEDevices
//
//  Created by ROMAN RESENCHUK on 03.05.16.
//  Copyright © 2016 ROMAN RESENCHUK. All rights reserved.
//

#import "BLEMainTVC.h"

@import CoreBluetooth;

@interface BLEMainTVC () <CBPeripheralDelegate, CBCentralManagerDelegate>

@property (strong, nonatomic) NSMutableArray *devicesArray;
@property (strong, nonatomic) CBCentralManager *centralManager;

@end

@implementation BLEMainTVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initController];
}

- (void)initController {
    self.devicesArray = [NSMutableArray array];
    self.centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
}

#pragma mark - CoreBluetooth
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state == CBCentralManagerStatePoweredOn) {
        [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary<NSString *,
                        id> *)advertisementData
                  RSSI:(NSNumber *)RSSI {
    [self.devicesArray addObject:peripheral];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.devicesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DeviceCell" forIndexPath:indexPath];
    
    CBPeripheral *peripheral = self.devicesArray[indexPath.row];
    cell.textLabel.text = peripheral.name;
    
    return cell;
}


@end
