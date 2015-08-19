//  MobDBRequest.h
//  Created on 3/19/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MobDB;
@protocol MobDBRequestDelegat;

@interface MobDBRequest : NSObject
{
    id<MobDBRequestDelegat>	delegate;
    NSString* baseURL; 
    NSString* contentType;
    NSMutableData* webData;
    NSURLConnection *theConnection;
  
}

@property (retain) id delegate;
@property (retain) NSString* jsonRequest;
@property (readwrite) NSInteger callBackType;
@property (nonatomic) BOOL isSecure;

- (void)setRequestString: (NSString *) requestStr isSecure:(BOOL) secure setCallBackIdx:(NSInteger) idx; 
- (void)sendRequest;
@end

@protocol MobDBRequestDelegat <NSObject>
@required
- (void)success:(BOOL) isSuccess errorValue:(NSInteger ) errValue rawJSONString:(NSString * ) jsonString fileNameWithExtention:(NSString *) fileName fileData:(NSData * ) fileData requestCompleted:(MobDBRequest *) request;


@end


