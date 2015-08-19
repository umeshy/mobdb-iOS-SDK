//  InsertRowQuery.m
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import "InsertRowQuery.h"
#import "MobDBConfiguration.h"
#import "NSData+Base64.h"
#import "JSONKit.h"

@implementation InsertRowQuery

-(void)dealloc{
    
    if(query != nil)
        [query release];
    if(fields != nil)
        [fields release];
    if(fieldValues != nil)
        [fieldValues release];
    if(condition != nil)
        [condition release];
    
    [super dealloc];

}

-(InsertRowQuery*)initWithTableName:(NSString *)table{
    query = [NSMutableString stringWithFormat:@"INSERT INTO %@ ",table];
    return self;
}

-(void)setValueToField:(NSString*)field setStringValue:(NSString*)value{
    
    if( fields == nil ){
        
        fields = [NSMutableArray array];
        
    }
    if( fieldValues == nil ){
        
        fieldValues = [NSMutableArray array];
        
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@",field]];
    [fieldValues addObject:[NSString stringWithFormat:@"%@",value]];
   	
}

-(void)setValueToField:(NSString*)field setIntegerValue:(NSInteger)value{
    
    if( fields == nil ){
        fields = [NSMutableArray array];
    }
    
    if( fieldValues == nil ){
        fieldValues = [NSMutableArray array];
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@",field]];
    [fieldValues addObject:[NSNumber numberWithInteger:value]];
    
}

-(void)setValueToField:(NSString*)field setDoubleValue:(double)value{
    
    if( fields == nil ){
        fields = [NSMutableArray array];
    }
    
    if( fieldValues == nil ){
        fieldValues = [NSMutableArray array];
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@",field]];
    [fieldValues addObject:[NSNumber numberWithFloat: ceil(value)]];
    
}

-(void)setValueToField:(NSString*)field setFileName:(NSString*)fileName setFileData:(NSData*)fileData{
    
    if( fields == nil ){
        
        fields = [NSMutableArray array];
        
    }
    if( fieldValues == nil ){
        
        fieldValues = [NSMutableArray array];
        
    }
    
    [fields addObject:[NSString stringWithFormat:@"%@",field]];
    
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

-(NSString*)getQueryString{
        
    NSMutableString* fieldsBuff = nil;
    NSMutableString* fieldValueBuff = nil;
    
    if( [fields count] > 0 ){        
       
        fieldsBuff = [NSMutableString stringWithFormat:@" (%@", (NSString*)[fields objectAtIndex:0]]; 
        
    }
    
    if(isFilePresent){        
        
        fieldValueBuff = [NSMutableString stringWithString:@" VALUES(?"];
        int len = [fields count];
        
        for (int i = 1; i < len; i++) {            
            
            [fieldsBuff appendFormat:@",%@",(NSString*)[fields objectAtIndex:i]];
            [fieldValueBuff appendString:@",?"];            
            
        }
        
    }else{        
        
        
        fieldValueBuff = [NSMutableString stringWithFormat:@" VALUES('%@'",(NSString*)[fieldValues objectAtIndex:0]];
        
        int len = [fields count];
        
        for ( int i = 1; i < len; i++ ) {            
           
            [fieldsBuff appendFormat:@",%@",(NSString*)[fields objectAtIndex:i]];
            [fieldValueBuff appendFormat:@",'%@'",[fieldValues objectAtIndex:i]];
            
        }
        
    }    
     
    [fieldsBuff appendString:@")"];
    [fieldValueBuff appendString:@")"];
    [query appendFormat:@"%@%@",fieldsBuff,fieldValueBuff];
    
    return query;
 	
}

@end
