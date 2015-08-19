//  InsertRowQuery.h
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InsertRowQuery : NSObject
{
    NSMutableString* query;
    NSString* condition;
    NSMutableArray *fields;
    NSMutableArray *fieldValues;
    BOOL isFilePresent;
    
}

/**
 * With conditions contracts SQL query 
 * @return SQL query NSString
 */
-(NSString*)getQueryString;


/**
 * Returns array of SQL parameter objects
 * @return Object array
 */
-(NSArray*) getParameters;

-(InsertRowQuery*)initWithTableName:(NSString*)table;

/**
 * Save field with string 
 * @param field field name
 * @param value String field value
 */
-(void)setValueToField:(NSString*)field setStringValue:(NSString*)value;

/**
 * Save field with integer 
 * @param field field name
 * @param value Integer field value
 */
-(void)setValueToField:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Save field with double 
 * @param field field name
 * @param value double field value
 */
-(void)setValueToField:(NSString*)field setDoubleValue:(double)value;

/**
 * Save field with file 
 * @param field field name
 * @param value String file name with extention
 * @param value NSData file data
 */
-(void)setValueToField:(NSString*)field setFileName:(NSString*)fileName setFileData:(NSData*)fileData;

@end
