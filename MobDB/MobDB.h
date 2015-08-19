//  MobDB.h
//  Created on 3/19/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.

#import <Foundation/Foundation.h>
#import "MobDBRequest.h"
#import "GetRowQuery.h"
#import "InsertRowQuery.h"
#import "UpdateRowQuery.h"
#import "DeleteRowQuery.h"
#import "PushQuery.h"
#import "MultiQuery.h"

typedef void (^StatusCallback)(BOOL success, NSInteger  msgValue);
typedef void (^JSONCallback)(BOOL success, NSInteger msgValue, NSString * jsonString);
typedef void (^FileCallback)(BOOL success, NSInteger msgValue, NSString * fileName, NSData * fileData);
typedef void (^MultiCallback)(BOOL success);

@interface MobDB : NSObject<MobDBRequestDelegat>
@property (nonatomic, retain) NSMutableArray *callbacks;
@property (nonatomic, retain) NSMutableArray *requests;


/*!
 Retrieves table rows in JSON string format
 @param appKey Application key
 @param getRowdata GetRowData class object, generates SELECT SQL statement for retrieving table rows
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setGetQuery:(GetRowQuery *) getRowdata setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure jsonCallBack: (JSONCallback) callBack;

/*!
 Insert(Add new) row into table
 @param appKey Application key
 @param insertRowdata InsertRowData class object, generates INSERT SQL statement
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setInsertQuery:(InsertRowQuery *) insertRowdata setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure jsonCallBack: (JSONCallback) callBack;

/*!
 Update(Edit) table rows 
 @param appKey Application key
 @param updateRowdata UpdateRowData class object, generates UPDATE SQL statement
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setUpdateQuery:(UpdateRowQuery *) updateRowdata setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure statusCallBack: (StatusCallback) callBack;

/*!
 Delete table rows 
 @param appKey Application key
 @param deleteRowdata DeleteRowData class object, generates DELETE SQL statement
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setDeleteQuery:(DeleteRowQuery *) deleteRowdata setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure statusCallBack: (StatusCallback) callBack;

/*!
 Push related API requests  
 @param appKey Application key
 @param push PushQuery class object, which generates PUSH request JSON string 
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setPushQuery:(PushQuery *) push setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure statusCallBack: (StatusCallback) callBack;

/*!
 File data(NSData) retrieving API request  
 @param appKey Application key
 @param fileID file ID which is received from GetRowData API call example: GET file=hfdjh6djfh
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setFileQuery:(NSString *) fileID setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure fileCallBack: (FileCallback) callBack;

/*!
 Send Multiple SQL (excluding NON data returning and file data insert or update request) request in single API call
 @param appKey Application key
 @param multiRequest MultiQuery calss object can ONLY holds InsertRowData, UpdateRowData and DeleteRowData 
 @param tagName Analytics custom tag name, records this API call and generate analytics report  
 @param isSecure Make API call with SSL  
 @param callBack Depends on your API request set CallBack
 */
+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setMultiQuery:(MultiQuery *) multiRequest setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure multiCallBack: (MultiCallback) callBack;

+(void) setAppKey:(NSString *) appKey setAdminKey:(NSString *)adminKey setQuery:(NSArray *) query setParam:(NSArray *) param setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL) secure setCallBackIndex:(NSInteger) idx;

@end
