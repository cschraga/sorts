//
//  Sorter.h
//  SearchesAndSorts
//
//  Created by Christian Schraga on 6/24/16.
//  Copyright © 2016 Straight Edge Digital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Sorter : NSObject

+(void) quicksortNSNumberArray: (nonnull NSMutableArray *)array;
+(void) mergesortNSNumberArray: (nonnull NSMutableArray *)array;

@end
