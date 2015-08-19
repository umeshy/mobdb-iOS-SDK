//  MultiQuery.h
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UpdateRowQuery.h"
#import "InsertRowQuery.h"
#import "DeleteRowQuery.h"

@interface MultiQuery : NSObject
{

    NSMutableArray* add;
    NSMutableArray* del;
    NSMutableArray* update;
}

/**
 * With conditions contracts SQL query 
 * @return SQL query NSString
 */
-(NSArray*)getQueryString;

-(void) setUpdateRowQuery:(UpdateRowQuery*) updateRowQuery;
-(void) setInsertRowQuery:(InsertRowQuery*) insertRowQuery;
-(void) setDeleteRowQuery:(DeleteRowQuery*) deleteRowQuery;


@end
