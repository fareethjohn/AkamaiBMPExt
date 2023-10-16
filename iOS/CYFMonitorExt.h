//
//  CYFMonitiorExt.h
//  BMPSDKPoc
//
//  Created by Fareeth Sarthar on 9/28/23.
//  Copyright © 2023 Akamai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CYFMonitorExt : NSObject

-(void)getSensorDataIn:(void (^)(NSString *param))handler;
+ (CYFMonitorExt *)sharedInstance;
@end

NS_ASSUME_NONNULL_END
