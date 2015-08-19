//  DeleteRowQuery.m
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import "DeleteRowQuery.h"

@implementation DeleteRowQuery

-(void)dealloc{
    [super dealloc];
    if(query != nil)
        [query release];
    if(condition != nil)
        [condition release];
    if(andConditions != nil)
        [andConditions release];
    if(orConditions != nil)
        [orConditions release];
    
}

-(DeleteRowQuery*)initWithTableName:(NSString *)table{
    query = [NSMutableString stringWithFormat:@"DELETE FROM %@",table];
    return self;
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
   
    return query;    
	
}


-(void) whereEqualsTo:(NSString*)field setIntegerValue:(NSInteger)value{
    condition = [NSString stringWithFormat:@"%@=%d",field,value];
}

-(void) whereEqualsTo:(NSString*)field setStringValue:(NSString*)value{
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
