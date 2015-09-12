//
//  BTDiscovery.h
//  TCup
//
//  Created by Kevin Lefevre on 12/09/2015.
//  Copyright (c) 2015 BeMyApp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

/* Services & Characteristics UUIDs */
#define RWT_BLE_SERVICE_UUID		[CBUUID UUIDWithString:@"B8E06067-62AD-41BA-9231-206AE80AB550"]
#define RWT_POSITION_CHAR_UUID		[CBUUID UUIDWithString:@"BF45E40A-DE2A-4BC8-BBA0-E5D6065F1B4B"]

@protocol BTDiscoveryDelegate <NSObject>

@required
- (void)peripheralConnecting;
- (void)peripheralDidConnect;
- (void)peripheralDidDisconnect;

@end

@interface BTDiscovery : NSObject

- (instancetype)initWithDelegate:(id<BTDiscoveryDelegate>)delegate;
- (void)startScanning;

@end
