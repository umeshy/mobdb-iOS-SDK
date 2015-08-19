//  MobDB.m
//  Created on 3/19/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import "MobDB.h"
#import "JSONKit.h"
#import "MobDBConfiguration.h"
#import "MobDBRequest.h"
#import "GetRowQuery.h"
#import "InsertRowQuery.h"
#import "UpdateRowQuery.h"
#import "DeleteRowQuery.h"
#import "PushQuery.h"
#import "MultiQuery.h"


@interface MobDB() 

@property (nonatomic, assign) BOOL running;
-(void) execute;
-(void) nextRequest;

@property (nonatomic, retain) MobDBRequest *currentRequest;
@end


@implementation MobDB

@synthesize requests = _requests;
@synthesize callbacks = _callbacks;
@synthesize currentRequest =_currentRequest;
@synthesize running = _running;


static MobDB *_sharedManager = nil;

+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setGetQuery:(GetRowQuery *)getRowdata setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL)secure jsonCallBack:(JSONCallback)callBack{
 
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    
    [_sharedManager.callbacks addObject:callBack];
    
     NSMutableArray* q = [[NSMutableArray alloc] init];
    [ q addObject:[getRowdata getQueryString]];
    [MobDB  setAppKey:appKey setAdminKey:adminKey setQuery:q setParam:nil setAnalyticsTagName:tagName isSecure:secure setCallBackIndex:JSON_CALLBACK];
    [q release];
    
}

+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setInsertQuery:(InsertRowQuery *)insertRowdata setAnalyticsTagName:(NSString *)tagName isSecure:(BOOL)secure jsonCallBack:(JSONCallback)callBack{
    
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    [_sharedManager.callbacks addObject:callBack];
    NSMutableArray* q = [[NSMutableArray alloc] init];
    [ q addObject:[insertRowdata getQueryString]];
    [MobDB  setAppKey:appKey setAdminKey:adminKey setQuery:q setParam:[insertRowdata getParameters] setAnalyticsTagName:tagName isSecure:secure setCallBackIndex:JSON_CALLBACK];
    [q release];
    
}

+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setDeleteQuery:(DeleteRowQuery *)deleteRowdata setAnalyticsTagName:(NSString *)tagName isSecure:(BOOL)secure statusCallBack:(StatusCallback)callBack{
    
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    [_sharedManager.callbacks addObject:callBack];
     NSMutableArray* q = [[NSMutableArray alloc] init];
    [ q addObject:[deleteRowdata getQueryString]];
    [MobDB  setAppKey:appKey setAdminKey:adminKey setQuery:q setParam:nil setAnalyticsTagName:tagName isSecure:secure setCallBackIndex:STATUS_CALLBACK];
    [q release];
    
}

+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setUpdateQuery:(UpdateRowQuery *)updateRowdata setAnalyticsTagName:(NSString *)tagName isSecure:(BOOL)secure statusCallBack:(StatusCallback)callBack{
    
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    
    [_sharedManager.callbacks addObject:callBack];
    
    NSMutableArray* q = [[NSMutableArray alloc] init];
    [ q addObject:[updateRowdata getQueryString]];
    [MobDB  setAppKey:appKey setAdminKey:adminKey setQuery:q setParam:[updateRowdata getParameters] setAnalyticsTagName:tagName isSecure:secure setCallBackIndex:STATUS_CALLBACK];
    [q release];
    
}
+(void) setApplicationKey:(NSString *)appKey setPushQuery:(PushQuery *)push setAnalyticsTagName:(NSString *)tagName isSecure:(BOOL)secure statusCallBack:(StatusCallback)callBack
{
    
    if(appKey == nil) return;
    
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    
    [_sharedManager.callbacks addObject:callBack];
    
    NSMutableDictionary *requestElements = [NSMutableDictionary dictionary];
      
    [requestElements setObject:appKey forKey:KEY];
    
    if (tagName != nil) {
        [requestElements setObject:tagName forKey:BAR_GRAPH];
    }
    
    [requestElements setObject:[push getQueryObject] forKey:PUSH];
    
    MobDBRequest* request = [[MobDBRequest alloc] init];
    [request setDelegate:_sharedManager];
    [request setRequestString:[requestElements JSONString] isSecure:secure setCallBackIdx:STATUS_CALLBACK];
    [ _sharedManager.requests addObject:request];
    [_sharedManager execute];
    
}

+(void) setApplicationKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setMultiQuery:(MultiQuery *)multiRequest setAnalyticsTagName:(NSString *)tagName isSecure:(BOOL)secure multiCallBack:(MultiCallback)callBack{
    
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    
    [_sharedManager.callbacks addObject:callBack];

    [MobDB  setAppKey:appKey setAdminKey:adminKey setQuery:[multiRequest getQueryString] setParam:nil setAnalyticsTagName:tagName isSecure:secure setCallBackIndex:MULTI_CALLBACK];

}

+(void) setApplicationKey:(NSString *)appKey setFileQuery:(NSString *)fileID setAnalyticsTagName:(NSString *)tagName isSecure:(BOOL)secure fileCallBack:(FileCallback)callBack{
    
    if(_sharedManager == nil){
        _sharedManager = [[super allocWithZone:NULL] init];
        _sharedManager.requests = [NSMutableArray array];
        _sharedManager.callbacks = [NSMutableArray array];
    }
    
    [_sharedManager.callbacks addObject:callBack];       
    
    NSMutableArray* q = [[NSMutableArray alloc] init];
    [ q addObject:fileID];
    [MobDB  setAppKey:appKey setAdminKey:nil setQuery:q setParam:nil setAnalyticsTagName:tagName isSecure:secure setCallBackIndex:FILE_CALLBACK];
    [q release];

}

+(void) setAppKey:(NSString *)appKey setAdminKey:(NSString *)adminKey setQuery:(NSArray *)query setParam:(NSArray *) param setAnalyticsTagName:(NSString *) tagName isSecure:(BOOL)secure setCallBackIndex:(NSInteger) idx{
    
    if(appKey == nil) return;
    
    NSMutableDictionary *requestElements = [NSMutableDictionary dictionary];
    
    NSMutableDictionary *sqlElements = [NSMutableDictionary dictionary];

    NSMutableArray *queries = [NSMutableArray array];
        
    [requestElements setObject:appKey forKey:KEY];

    if (adminKey != nil) {
        [requestElements setObject:adminKey forKey:ADMIN_KEY];
    }
    
    if (tagName != nil) {
        [requestElements setObject:tagName forKey:BAR_GRAPH];
    }
    
    NSEnumerator *enumerator = [query objectEnumerator];
    NSString *q;
    int len = 0;
    
    while (q = [enumerator nextObject]) {
          [queries addObject:q];
          len++;
    }
    
    if(len == 1 && param != nil){        
        NSObject *p;
        NSEnumerator *e = [param objectEnumerator];
        NSMutableArray *params = [NSMutableArray array];
        
        while (p = [e nextObject]) {
            [params addObject:p];
        }
        
        [sqlElements setObject:params forKey:PARAM];        
    }
    
    [sqlElements setObject:queries forKey:QUERY];
    [requestElements setObject:sqlElements forKey:SQL];
    
    NSString* jsonString = [requestElements JSONString]; 
   // NSLog(@"%@",jsonString);
      
    MobDBRequest* request = [[MobDBRequest alloc] init];
    [request setDelegate:_sharedManager];
    [request setRequestString:jsonString isSecure:secure setCallBackIdx:idx];
    [ _sharedManager.requests addObject:request];
    [_sharedManager execute];
   
}

-(void)execute{
    
    if(!self.running){
        
     if([self.requests count] <= 0) return;
        
        self.running = YES;    
        self.currentRequest = [self.requests objectAtIndex:0];
        [self.currentRequest sendRequest];
        
    }
    
}

-(void) nextRequest{
    
    self.running = NO;
    self.currentRequest = nil;
    [self execute];    

}

-(void)success:(BOOL)isSuccess errorValue:(NSInteger)errValue rawJSONString:(NSString *)jsonString fileNameWithExtention:(NSString *) fileName fileData:(NSData * ) fileData requestCompleted:(MobDBRequest *)request{
    
    if([_sharedManager.requests containsObject:request]){
        
        NSInteger index = [_sharedManager.requests indexOfObject:request];
        id callback = [self.callbacks objectAtIndex:index];
      
        switch ([request callBackType]) {

            case STATUS_CALLBACK:
            {
                StatusCallback  mCallback =  (StatusCallback)callback;
                mCallback(isSuccess, errValue);
                break;
            }
            case JSON_CALLBACK:            
            {
                JSONCallback  mCallback =  (JSONCallback)callback;
                mCallback(isSuccess, errValue, jsonString);
                break;
            }
            case FILE_CALLBACK:
            {
                FileCallback  mCallback =  (FileCallback)callback;
                mCallback(isSuccess, errValue, fileName, fileData);
                break;
            }
            case MULTI_CALLBACK:
            {
                FileCallback  mCallback =  (FileCallback)callback;
                mCallback(isSuccess, errValue, fileName, fileData);
                break;
            }
       
        }
        
        [self.callbacks removeObjectAtIndex:index];
        [_sharedManager.requests removeObject:request];
       
        [self nextRequest];
    }
    
}

@end
