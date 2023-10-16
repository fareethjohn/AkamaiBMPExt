//
//  CYFMonitiorExt.m
//  BMPSDKPoc
//
//  Created by Fareeth Sarthar on 9/28/23.
//  Copyright © 2023 Akamai. All rights reserved.
//

#import "CYFMonitorExt.h"
#import <AkamaiBMP/CYFMonitor.h>

@interface CYFMonitorExt()

@property(nonatomic, retain) NSString *mSD;
@end

@implementation CYFMonitorExt
NSString *const kSD_default_mobile = @"default-mobile";
int const kSD_Sampling_Time = 1.0;
int const kSD_TimeOut = 5;

+(CYFMonitorExt *)sharedInstance {
    static dispatch_once_t pred = 0;
    static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(void)getSensorDataIn:(void (^)(NSString *sd))handler{
    @synchronized (self) {
        _mSD= CYFMonitor.getSensorData;
        if (_mSD == kSD_default_mobile) {
            dispatch_queue_t sdCheckQueue = dispatch_queue_create("com.akamai.bmp", NULL);
            for(int i =0; i <= kSD_TimeOut; i ++){
                dispatch_async(sdCheckQueue, ^ {
                    [NSThread sleepForTimeInterval:kSD_Sampling_Time];
                    self.mSD= CYFMonitor.getSensorData;
                    if (self.mSD != kSD_default_mobile){
                        handler(self.mSD);
                        dispatch_suspend(sdCheckQueue);
                    }
                    else if(i == kSD_TimeOut){
                        handler(self.mSD);
                    }
                });
            }
        }
        else{
            handler(_mSD);
        }
    }
}

@end
