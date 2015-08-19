//  MultiQuery.m
//  Created on 3/21/12.
//  Copyright (c) 2011 mobDB, LLC. All rights reserved.

#import "MultiQuery.h"

@implementation MultiQuery

-(NSArray*) getQueryString{
        
    NSMutableArray* q = [NSMutableArray array];
    
    if(add != nil){
        int len = [add count];
        for (int i = 0; i<len; i++) {
            [q addObject:[(InsertRowQuery*)[add  objectAtIndex:i] getQueryString]];
        }        
    }

    if(del != nil){
        int len = [del count];
        for (int i = 0; i<len; i++) {
            [q addObject:[(DeleteRowQuery*)[del  objectAtIndex:i] getQueryString]];
        }
    }
    
    if(update != nil){
        int len = [update count];
        for (int i = 0; i<len; i++) {
          [q addObject:[(UpdateRowQuery*)[update  objectAtIndex:i] getQueryString]];
        }
    }
    
    NSMutableArray* query = [NSMutableArray array];
    
    int len = [q count];
    for (int i = 0; i<len; i++) {
        [query addObject:[q objectAtIndex:i]];
    }
    
    return query;
	
}

-(void) setUpdateRowQuery:(UpdateRowQuery *)updateRowQuery{
      
        if(updateRowQuery == nil) return;
        
        if(update == nil){
            update = [NSMutableArray array];
        }
        
        [update addObject:updateRowQuery];
    
}

-(void) setInsertRowQuery:(InsertRowQuery *)insertRowQuery{
        
        if(insertRowQuery == nil) return;
        
        if(add == nil){
            add = [NSMutableArray array];
        }

        [add addObject:insertRowQuery];
    
}

-(void) setDeleteRowQuery:(DeleteRowQuery *)deleteRowQuery{
        
        if(deleteRowQuery == nil) return;
      
        if(del == nil){
            del = [NSMutableArray array];
        }

        [del addObject:deleteRowQuery];
}

@end
