//  UpdateRowQuery.m
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import "UpdateRowQuery.h"
#import "MobDBConfiguration.h"
#import "NSData+Base64.h"
#import "JSONKit.h"

@implementation UpdateRowQuery

-(void)dealloc{
    
    if(query != nil)
        [query release];
    if(fields != nil)
        [fields release];
    if(fieldValues != nil)
        [fieldValues release];
    if(condition != nil)
        [condition release];
    if(andConditions != nil)
        [andConditions release];
    if(orConditions != nil)
        [orConditions release];
    
}

-(UpdateRowQuery*)initWithTableName:(NSString *)table{
    query = [NSMutableString stringWithFormat:@"UPDATE %@ * ",table];
    return self;
}

-(void)setValueToField:(NSString*)field setString:(NSString*)value{
    
    if( fields == nil ){
        
        fields = [NSMutableArray array];
        
    }
    
    if( fieldValues == nil ){
        
        fieldValues = [NSMutableArray array];
        
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@=?",field]];
    [fieldValues addObject:[NSString stringWithFormat:@"'%@'",value]];
   	
}

-(void)setValueToField:(NSString*)field setInteger:(NSInteger)value{
    
    if( fields == nil ){
        fields = [NSMutableArray array];
    }
    
    if( fieldValues == nil ){
        fieldValues = [NSMutableArray array];
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@=?",field]];
    [fieldValues addObject:[NSNumber numberWithInteger:value]];
    
}

-(void)setValueToField:(NSString*)field setDouble:(double)value{

    if( fields == nil ){
        fields = [NSMutableArray array];
    }
    
    if( fieldValues == nil ){
        fieldValues = [NSMutableArray array];
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@=?",field]];
    [fieldValues addObject:[NSNumber numberWithFloat:value]];
    
}

-(void)setValueToField:(NSString*)field setFileName:(NSString*)fileName setFileData:(NSData*)fileData{
    
    if( fields == nil ){
        
        fields = [NSMutableArray array];
        
    }
    if( fieldValues == nil ){
        
        fieldValues = [NSMutableArray array];
        
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@=?",field]];
    
    NSMutableDictionary *fileElements = [NSMutableDictionary dictionary];
    [fileElements setObject:fileName forKey:FILE_NAME];
    [fileElements setObject:[fileData base64EncodedString] forKey:FILE_DATA];
   
    [fieldValues addObject:fileElements];
    isFilePresent = YES;
}


-(NSArray*) getParameters{
    
    if(!isFilePresent){
		
        return nil;
		
    }
    
    NSMutableArray* params = [NSMutableArray array];
    
    int count =[fieldValues count];
    
    for (int i=0; i<count; i++) {
        [params addObject:[fieldValues objectAtIndex:i]];
    }
    
    return params;
}

-(NSString*) getQueryString{
    
    
    if( condition != nil ){
        
        [query appendFormat:@" WHERE %@",condition];
    }
    
    if( orConditions != nil ){
        
        if( condition != nil ){
            
            [query appendFormat:@" OR %@",(NSString*)[orConditions objectAtIndex:0]];
            
        } else {
            
            [query appendFormat:@" WHERE %@",(NSString*)[orConditions objectAtIndex:0]];
        }
        
        if ([orConditions count] >1) {
            
            NSMutableString *or = [NSMutableString stringWithFormat:@" OR %@",(NSString*)[orConditions objectAtIndex:1]];
            
            for ( int i = 2; i < [orConditions count]; i++ ) {
                
                [or appendFormat:@" OR %@",(NSString*)[orConditions objectAtIndex:i]];
                
            }
            
            [query appendString:or];
        }
    }
    
    if( andConditions != nil ){
        
        if( condition != nil || orConditions != nil){
            
            [query appendFormat:@" AND %@",(NSString*)[andConditions objectAtIndex:0]];
            
        } else {
            
            [query appendFormat:@" WHERE %@",(NSString*)[andConditions objectAtIndex:0]];
        }
        
        if ([andConditions count] > 1) {
            
            NSMutableString*  and = [NSMutableString stringWithFormat:@" AND %@",(NSString*)[andConditions objectAtIndex:1]];    
            
            for ( int i = 2; i < [andConditions count]; i++ ) {
                
                [and appendFormat:@" AND %@",(NSString*)[andConditions objectAtIndex:i]];
                
            }
            
            [query appendString:and];
            
        }
        
    }
       
    if( fields != nil ){
        
        if([fields count] > 0){
            
            NSMutableString* field = [NSMutableString stringWithFormat:@" SET %@",(NSString*)[fields objectAtIndex:0]];     
            
            for ( int i = 1; i < [fields count]; i++ ) {
                
                [field appendFormat:@",%@",(NSString*)[fields objectAtIndex:i]];
                
            }
            
            if([field length] > 0){
                
                query = [[query stringByReplacingOccurrencesOfString:@" * " withString:[NSString stringWithFormat:@" %@ ",field]] mutableCopy];
                
            }
            
        }
        
    }
    if(!isFilePresent){
        
        int len = [fields count];
        
        for ( int i = 0; i < len; i++ ) {
                                    
            NSString* fieldValue = (NSString*)[fields objectAtIndex:i];
            
            NSString* result = [NSString stringWithFormat:@"%@%@", [fieldValue substringWithRange:NSMakeRange(0,[fieldValue length] -1)], (NSString*)[fieldValues objectAtIndex:i]];
            
            query = [[query stringByReplacingOccurrencesOfString:fieldValue withString:result] mutableCopy];
            
        }
        
    }
    
    
    return query;    
	
}



-(void) whereEqualsTo:(NSString*)field setIntegerValue:(NSInteger)value{
    condition = [NSString stringWithFormat:@"%@=%d",field,value];
}

-(void) whereEqualsTo:(NSString*)field setString:(NSString*)value{
    condition = [NSString stringWithFormat:@"%@='%@'",field,value];
}

-(void) whereEqualsTo:(NSString*)field setDoubleValue:(double)value{
    condition = [NSString stringWithFormat:@"%@=%f",field,value];
}

-(void) whereGreaterThen:(NSString*)field setIntegerValue:(NSInteger)value{
    condition = [NSString stringWithFormat:@"%@>%d",field,value];
}


-(void) whereGreaterThen:(NSString*)field setDoubleValue:(double)value{
    condition = [NSString stringWithFormat:@"%@>%f",field,value];
}


-(void) whereLessThen:(NSString*) field setIntegerValue:(NSInteger)value{
    condition = [NSString stringWithFormat:@"%@<%d",field,value];
}

-(void) whereLessThen:(NSString*) field setDoubleValue:(double)value{
    condition = [NSString stringWithFormat:@"%@<%f",field,value];
}

-(void) andEqualsTo:(NSString *)field setIntegerValue:(NSInteger)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@=%d",field,value];
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
    
}


-(void) andEqualsTo:(NSString *)field setStringValue:(NSString*)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@='%@'",field,value];
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
}

-(void) andEqualsTo:(NSString *)field setDoubleValue:(double)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@=%f",field,value];
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
    
}


-(void) andGreaterThen:(NSString *)field setIntegerValue:(NSInteger)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@>%d",field,value];
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
}

-(void) andGreaterThen:(NSString *)field setDoubleValue:(double)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@>%f",field,value];
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
}

-(void) andLessThen:(NSString *)field setIntegerValue:(NSInteger)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@<%d",field,value];
    
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
}

-(void) andLessThen:(NSString *)field setDoubleValue:(double)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@<%f",field,value];
    
    if(andConditions == nil){
        andConditions = [NSMutableArray array];
    }
    
    if(![andConditions containsObject:eCondition]){
        [andConditions addObject:eCondition];
    }
}

-(void)orEqualsTo:(NSString *)field setIntegerValue:(NSInteger)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@=%d",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}

-(void)orEqualsTo:(NSString *)field setStringValue:(NSString*)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@='%@'",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}

-(void)orEqualsTo:(NSString *)field setDoubleValue:(double)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@=%f",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}


-(void) orGreaterThen:(NSString *)field setIntegerValue:(NSInteger)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@>%d",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}

-(void) orGreaterThen:(NSString *)field setDoubleValue:(double)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@>%f",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}

-(void) orLessThen:(NSString *)field setIntegerValue:(NSInteger)value{
    
    NSString* eCondition = [NSString stringWithFormat:@"%@<%d",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}

-(void) orLessThen:(NSString *)field setDoubleValue:(double)value{
    NSString* eCondition = [NSString stringWithFormat:@"%@<%f",field,value];
    if(orConditions == nil){
        orConditions = [NSMutableArray array];
    }
    
    if(![orConditions containsObject:eCondition]){
        [orConditions addObject:eCondition];
    }
}

@end
