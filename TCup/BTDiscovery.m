//
//  BTDiscovery.m
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import "BTDiscovery.h"

static NSString *const kPeripheralLocalName = @"TCup";

@interface BTDiscovery () <CBCentralManagerDelegate>

@property (nonatomic, weak) id<BTDiscoveryDelegate> delegate;
@property (nonatomic, strong) CBCentralManager *centralManager;
@property (nonatomic, strong) CBPeripheral *peripheralBLE;		// Connected peripheral

@end

@implementation BTDiscovery

#pragma mark = Initialization

- (instancetype)initWithDelegate:(id<BTDiscoveryDelegate>)delegate {
    if ((self = [super init])) {
        dispatch_queue_t centralQueue = dispatch_queue_create("fr.kevinlefevre.centralManager", DISPATCH_QUEUE_SERIAL);
        _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:nil];
        _delegate = delegate;
    }
    return self;
}

#pragma mark - Public

- (void)startScanning {
    NSLog(@"Start scanning for peripherals");
    [self.centralManager scanForPeripheralsWithServices:nil options:nil];
    [self.delegate peripheralConnecting];
}

#pragma CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBCentralManagerStatePoweredOff:
            NSLog(@"CBCentralManagerStatePoweredOff");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@"CBCentralManagerStateUnauthorized");
            break;
        case CBCentralManagerStateUnknown:
            NSLog(@"CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStatePoweredOn:
            NSLog(@"CBCentralManagerStatePoweredOn");
            [self startScanning];
            break;
        case CBCentralManagerStateResetting:
            NSLog(@"CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@"CBCentralManagerStateUnsupported");
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary *)dict {

}

- (void)centralManager:(CBCentralManager *)central didRetrievePeripherals:(NSArray *)peripherals {
}

- (void)centralManager:(CBCentralManager *)central didRetrieveConnectedPeripherals:(NSArray *)peripherals {

}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {

    // Validate peripheral information
    if (!peripheral || !peripheral.name || ([peripheral.name isEqualToString:@""])) {
        return;
    }

    NSLog(@"Discovered periphal: name: %@, services: %@, data: %@, rssi: %@", peripheral.name, peripheral.services, advertisementData, RSSI);

    // Check for our TCup
    if ([advertisementData[CBAdvertisementDataLocalNameKey] isEqualToString:kPeripheralLocalName]) {
        NSLog(@"TCup found ! - Stopping scan");
        [central stopScan];

        NSLog(@"Connecting to TCup");
        self.peripheralBLE = peripheral; // We do have to retain it
        [central connectPeripheral:peripheral options:nil];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"did connect to TCup :)");
    [self.delegate peripheralDidConnect];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"did fail to connect to TCup :(");
    [self.delegate peripheralDidDisconnect];
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"did disconnect from TCup");
    [self.delegate peripheralDidDisconnect];
}

#pragma mark -

@end
