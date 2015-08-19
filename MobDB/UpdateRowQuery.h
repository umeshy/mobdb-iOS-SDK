//  UpdateRowQuery.h
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UpdateRowQuery : NSObject
{
    NSMutableString* query;
    NSString* condition;
    NSMutableArray *andConditions;
    NSMutableArray *orConditions;
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

-(UpdateRowQuery*)initWithTableName:(NSString*)table;

/**
 * Update field with string 
 * @param field field name
 * @param value String field value
 */
-(void)setValueToField:(NSString*)field setString:(NSString*)value;

/**
 * Update field with integer 
 * @param field field name
 * @param value Integer field value
 */
-(void)setValueToField:(NSString*)field setInteger:(NSInteger)value;

/**
 * Update field with double 
 * @param field field name
 * @param value double field value
 */
-(void)setValueToField:(NSString*)field setDouble:(double)value;

/**
 * Update field with file 
 * @param field field name
 * @param value String file name with extention
 * @param value NSData file data
 */
-(void)setValueToField:(NSString*)field setFileName:(NSString*)fileName setFileData:(NSData*)fileData;


/**
 * Sets <strong>WHERE field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)whereEqualsTo:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>WHERE field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The String value for condition
 */
-(void)whereEqualsTo:(NSString*)field setString:(NSString*)value;

/**
 * Sets <strong>WHERE field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)whereEqualsTo:(NSString*)field setDoubleValue:(double)value;

/**
 * Set <strong>WHERE field > value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The integer value for condition
 */
-(void)whereGreaterThen:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Set <strong>WHERE field > value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)whereGreaterThen:(NSString*)field setDoubleValue:(double)value;

/**
 * Set <strong>WHERE field < value</strong> condition in SQL query string 
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)whereLessThen:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Set <strong>WHERE field < value</strong> condition in SQL query string 
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)whereLessThen:(NSString*)field setDoubleValue:(double)value;

/**
 * Sets <strong>AND field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)andEqualsTo:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>AND field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The String value for condition
 */
-(void)andEqualsTo:(NSString*)field setStringValue:(NSString*)value;

/**
 * Sets <strong>AND field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)andEqualsTo:(NSString*)field setDoubleValue:(double)value;

/**
 * Sets <strong>AND field > value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)andGreaterThen:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>AND field > value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)andGreaterThen:(NSString*)field setDoubleValue:(double)value;

/**
 * Sets <strong>AND field < value</strong> condition in SQL query string 
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)andLessThen:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>AND field < value</strong> condition in SQL query string 
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)andLessThen:(NSString*)field setDoubleValue:(double)value;

/**
 * Sets <strong>OR field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)orEqualsTo:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>OR field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The String value for condition
 */
-(void)orEqualsTo:(NSString*)field setStringValue:(NSString*)value;

/**
 * Sets <strong>OR field = value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)orEqualsTo:(NSString*)field setDoubleValue:(double)value;

/**
 * Sets <strong>OR field > value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)orGreaterThen:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>OR field > value</strong> condition in SQL query string
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)orGreaterThen:(NSString*)field setDoubleValue:(double)value;

/**
 * Sets <strong>OR field < value</strong> condition in SQL query string 
 * @param field The field which needs to use for condition
 * @param value The int value for condition
 */
-(void)orLessThen:(NSString*)field setIntegerValue:(NSInteger)value;

/**
 * Sets <strong>OR field < value</strong> condition in SQL query string 
 * @param field The field which needs to use for condition
 * @param value The double value for condition
 */
-(void)orLessThen:(NSString*)field setDoubleValue:(double)value;

@end
