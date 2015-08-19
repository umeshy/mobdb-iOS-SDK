//  MobDBRequest.m
//  Created on 3/19/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import "MobDBRequest.h"
#import "MobDBConfiguration.h"
#import "JSONKit.h"
#import "MobDB.h"

@implementation MobDBRequest
@synthesize delegate;
@synthesize jsonRequest = _jsonRequest;
@synthesize isSecure = _isSecure;
@synthesize callBackType =_callBackType;


-(void)setRequestString:(NSString *)requestStr isSecure:(BOOL)secure setCallBackIdx:(NSInteger)idx{

    [self setIsSecure:secure];
    [self setJsonRequest:requestStr];
    [self setCallBackType:idx];
    
    baseURL = URL_HTTP;
    
    if(secure){
        baseURL = URL_HTTPS;
    }
       
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSDictionary* headers = [(NSHTTPURLResponse *)response allHeaderFields];
    contentType = [headers objectForKey:@"Content-Type"];
    [webData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [webData appendData:data];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ERROR with theConenction");
    
    if(connection != nil)
        [connection release];
    
    if(webData != nil)
        [webData release];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if(self.callBackType == FILE_CALLBACK){
        
        if([contentType rangeOfString:@"json"].location == NSNotFound){
            
            NSArray *chunks = [contentType componentsSeparatedByString: @";"];
            NSString* fileName = (NSString*)[chunks objectAtIndex:1];
            [[self delegate] success:YES errorValue:-1 rawJSONString:nil fileNameWithExtention:fileName fileData:webData requestCompleted:self];
            
        }else{
            
            NSString *theJSON = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
           // NSLog(@"%@",theJSON);
            NSDictionary *nameElements_ = [theJSON objectFromJSONString];   
            
           id status = [nameElements_ objectForKey:STATUS];
           [[self delegate] success:NO errorValue:[status integerValue] rawJSONString:theJSON fileNameWithExtention:nil fileData:nil requestCompleted:self];

            [theJSON release];
            
        }
    }else if(self.callBackType == MULTI_CALLBACK){
        
        [[self delegate] success:YES errorValue:-1 rawJSONString:nil fileNameWithExtention:nil fileData:nil requestCompleted:self];
        
    }else{
    
        NSString *theJSON = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",theJSON);
    
        NSDictionary *nameElements_ = [theJSON objectFromJSONString];   
        id status = [nameElements_ objectForKey:STATUS];

        //NSLog(@"%d", [status integerValue]);
        if (self.delegate){
            
            if( [status integerValue] == 101 ){
                [[self delegate] success:YES errorValue:-1 rawJSONString:theJSON fileNameWithExtention:nil fileData:nil requestCompleted:self];
            }
            else if([status integerValue] != 101){
                [[self delegate] success:NO errorValue:[status integerValue] rawJSONString:nil fileNameWithExtention:nil fileData:nil requestCompleted:self];
            }
            
        }
    
       [theJSON release];
    }
    
    [theConnection release];    
    [webData release];
    
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]){      
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)sendRequest{
       
    NSURL *url = [NSURL URLWithString:baseURL];
   
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];

    [theRequest addValue:JSON_CONTENT forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [self.jsonRequest dataUsingEncoding:NSUTF8StringEncoding]];
    
    theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    
    
    if( theConnection )
    {
        webData = [[NSMutableData data] retain];
    }
    else
    {
        NSLog(@"theConnection is NULL");
    }

}

@end
