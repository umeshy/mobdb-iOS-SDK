//  Push.h
//  Created on 3/19/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PushQuery : NSObject
{
    NSMutableArray* androidPayload;
    NSMutableArray* registrationIDs;
	NSMutableDictionary* iOSPayload;
	NSString* regId;
	NSString* when;
	NSString* deviceType;
    NSString* label;
	BOOL sendRegIDTomobDB;
}


/**
 * With conditions contracts Push query 
 * @return Push query NSMutableDictionary object
 */
-(NSMutableDictionary*)getQueryObject;

/**
 * Send Push Notification to specific Device
 * @param registrationID Device registrationID
 */
-(void) sendPushTo:(NSString*) token;

/**
 * Set date and time for Schedule Push Notification. 
 * @param month String 
 * @param data String  
 * @param year String 
 * @param hours String example: 18:30
 * @param minutes String example: 18:30
 * @param gmt String format mush be <strong>GMT-05:00</strong>
 */
-(void) setWhenMonth:(NSInteger) month setDate:(NSInteger)date setYear:(NSInteger)year setHours:(NSInteger) hour setMinutes:(NSInteger)minutes setGMT:( NSString*)GMT;

/**
 * Set Android payload HashMap, its required 
 * @param payload HashMap contains key Value pair, which will be passed to app Intent Extra key and value
 */
-(void) setAndroidPayload:(NSMutableDictionary*) payload;

/**
 * Set iOS payload JSON Object, its required 
 * @param iosPayload JSON object
 */
-(void) setiOSPayload:(NSMutableDictionary*) payload;

/**
 * Set Device token JSON array Object, its required 
 * @param registrationIDs JSON array object
 */
-(void) sendPushToList:(NSMutableArray*) registrationIDs;

/**
 * Send received device token to mobDB 
 * @param deviceType String value for device type <strong>'ios'</strong> or <strong>'android'</strong>
 * @param deviceToken device token
 * @param deviceLabel device label
 */
-(void) sendDeviceTokenToMobDB:(NSString*) deviceType setDeviceToken:(NSString*) deviceToken setDeviceLabel:(NSString*) deviceLabel;


@end
