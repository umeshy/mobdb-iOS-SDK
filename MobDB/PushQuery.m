//  Push.m
//  Created on 3/19/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import "PushQuery.h"
#import "MobDBConfiguration.h"
#import "JSONKit.h"

@implementation PushQuery


-(NSMutableDictionary*) getQueryObject{
    
    NSMutableDictionary* push = [NSMutableDictionary dictionary];
    
    if(regId != nil){
        [push setObject:regId forKey:DEVICE_TOKEN ];
    }else if(registrationIDs != nil){
        [push setObject:registrationIDs forKey:DEVICE_TOKEN ];
    }
    
    if(sendRegIDTomobDB){
        [push setObject:deviceType forKey:DEVICE_TYPE];
        [push setObject:label forKey:DEVICE_LABEL];
    }else{
        if (androidPayload != nil) {
            [push setObject:androidPayload forKey:PAYLOAD];
        }else if (iOSPayload != nil) {
            [push setObject:iOSPayload forKey:PAYLOAD];
        }
        
        if(when != nil){
            [push setObject:when forKey:WHEN];
        }
    }
    return push;
    
}

-(void) sendPushTo:(NSString *)token{
    regId = token;
}

-(void)setWhenMonth:(NSInteger) month setDate:(NSInteger)date setYear:(NSInteger)year setHours:(NSInteger) hour setMinutes:(NSInteger)minutes setGMT:( NSString*) GMT{

    when = [NSString stringWithFormat:@"%d/%d/%d,%d:%d,%@",month,date,year,hour,minutes,GMT];
    
}

-(void)setAndroidPayload:(NSMutableDictionary *)payload{

    if(payload == nil) return;
    
    androidPayload = [NSMutableArray array];
    
    NSEnumerator *enumerator = [payload keyEnumerator];
    
    id key;
    
    while ((key = [enumerator nextObject])){
        
        NSMutableDictionary* keyValue = [[NSMutableDictionary alloc] init];
        [keyValue setObject:key forKey:KEY];
        [keyValue setObject:[payload objectForKey: key] forKey:VALUE];
        [androidPayload addObject:keyValue];
        [keyValue release];

    }  
   // NSLog(@"%@",[androidPayload JSONString]);

}

-(void) setiOSPayload:(NSMutableDictionary *)payload{
    
    if(payload == nil) return;
    iOSPayload = payload;
    
}

-(void) sendDeviceTokenToMobDB:(NSString *)deviceOSType setDeviceToken:(NSString *)deviceToken setDeviceLabel:(NSString *)deviceLabel{

    if([deviceOSType isEqualToString:IOS] || [deviceOSType isEqualToString:ANDROID] ){
        deviceType = deviceOSType;
    }else{
        return;
    }
    
    if(deviceToken == nil) return;
    regId = deviceToken;
    label = deviceLabel;
    sendRegIDTomobDB = YES;
    
}

-(void) sendPushToList:(NSMutableArray*) deviceIDlist{
    registrationIDs = deviceIDlist;
}

@end
