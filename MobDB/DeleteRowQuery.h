//  DeleteRowQuery.h
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeleteRowQuery : NSObject
{
   NSMutableString* query;
   NSString* condition;
   NSMutableArray *andConditions;
   NSMutableArray *orConditions;   
}

/**
 * With conditions contracts SQL query 
 * @return SQL query NSString
 */
-(NSString*)getQueryString;

-(DeleteRowQuery*)initWithTableName:(NSString*)table;


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
-(void)whereEqualsTo:(NSString*)field setStringValue:(NSString*)value;

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
