//
//  Sorter.m
//  SearchesAndSorts
//
//  Created by Christian Schraga on 6/24/16.
//  Copyright © 2016 Straight Edge Digital. All rights reserved.
//

#import "Sorter.h"

@interface Sorter ()

//quicksort
+(void) quicksortNSNumberArray:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right;
+(void) swapArrayPositions: (NSMutableArray *)array fromIndex:(NSInteger)from toIndex: (NSInteger)to;
+(NSInteger) partition: (NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right;

//mergesort;
+(void)merge:(NSMutableArray *)array left:(NSInteger)l  mid:(NSInteger)r right:(NSInteger)r;
+(void)mergesortNSNumberArray:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right;


@end

@implementation Sorter

#pragma public methods
+(void) quicksortNSNumberArray:(NSMutableArray *)array {
    [Sorter quicksortNSNumberArray:array leftIndex:0 rightIndex:array.count - 1];
}

+(void)mergesortNSNumberArray:(NSMutableArray *)array {
    [Sorter mergesortNSNumberArray:array leftIndex:0 rightIndex:array.count - 1];
}

+(void)insertionSortNSNumberArray:(NSMutableArray *)array {
    
    NSInteger j = 0;
    NSInteger n = array.count;
    NSNumber *key;
    
    for (NSInteger i = 0; i < n; ++i) {
        key = array[i];
        j = i - 1;
        
        while (j >= 0 && [(NSNumber *)array[j] compare:key] == NSOrderedDescending) {
            array[j + 1] = array[j];
            --j;
        }
        array[j + 1] = key;
    }
    
    
}

+(void) bucketSortNSNumberArray:(NSMutableArray *)array {
    
    //constants
    NSInteger n = (array.count < 20) ? 5 : 10; //count of buckets
    NSInteger size = 0;
    NSNumber  *min = (array.count > 0) ? [array objectAtIndex:0] : [NSNumber numberWithInt:0];
    NSNumber  *max = [NSNumber numberWithInt:0];
    NSMutableArray *buckets = [NSMutableArray arrayWithCapacity:n];
    
    
    //find min and max
    for (NSNumber *each in array) {
        min = ([each compare:min] == NSOrderedAscending)  ? each : min;
        max = ([each compare:max] == NSOrderedDescending) ? each : max;
    }
    
    //evenly sized buckets
    size = (max.integerValue + min.integerValue) / n;
    
    //build buckets
    for (NSInteger i = 0; i < n; ++i) {
        NSMutableArray *bucket = [NSMutableArray array];
        [buckets addObject:bucket];
    }
    
    //insert into buckets
    for (NSNumber *number in array) {
        NSInteger index = (size != 0) ? number.integerValue / size : 0;
        NSMutableArray *bucket = buckets[index];
        [bucket insertObject:number atIndex:bucket.count];
    }
    
    //remerge
    [array removeAllObjects];
    for (NSMutableArray *bucket in buckets) {
        [array addObjectsFromArray:bucket];
    }
    
    //insertion sort
    [Sorter insertionSortNSNumberArray:array];
    
    NSLog(@"poop");
}

#pragma class methods

+(void)merge:(NSMutableArray *)array left:(NSInteger)l mid:(NSInteger)m right:(NSInteger)r {
    
    //1) get subarray count
    NSInteger lcount = m - l + 1;
    NSInteger rcount = r - m;
    
    //1) create temp arrays
    NSMutableArray *L = [NSMutableArray arrayWithCapacity:lcount];
    NSMutableArray *R = [NSMutableArray arrayWithCapacity:rcount];
    
    //2) Copy data to temp arrays L[] and R[]
    for (NSInteger z = 0; z < lcount; ++z) {
        L[z] = array[z + l];
    }
    
    for (NSInteger z = 0; z < rcount; ++z) {
        R[z] = array[z + m + 1];
    }
    
    //3) Merge the temp arrays back into arr[l..r]
    NSInteger i = 0; //left array index;
    NSInteger j = 0; //right array index;
    NSInteger k = l; //main array index starts at l;
    
    while (i < lcount && j < rcount) {
        
        NSNumber *iVal = (NSNumber *)L[i];
        NSNumber *jVal = (NSNumber *)R[j];
        
        if ([iVal compare:jVal] != NSOrderedDescending) {
            array[k] = iVal;
            ++i;
        } else {
            array[k] = jVal;
            ++j;
        }
        
        ++k;
        
    }
    
    //4) Copy the remaining elements of L[], if there are any
    while (i < lcount) {
        NSNumber *iVal = (NSNumber *)L[i];
        array[k] = iVal;
        ++i;
        ++k;
    }
    
    //5) Copy the remaining elements of R[], if there are any
    while (j < rcount) {
        NSNumber *jVal = (NSNumber *)R[j];
        array[k] = jVal;
        ++j;
        ++k;
    }

}

+(void)mergesortNSNumberArray:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right {
    
    if (left < right) {
        
        NSInteger mid = (left + right) / 2;
        [Sorter mergesortNSNumberArray:array leftIndex:left rightIndex:mid];
        [Sorter mergesortNSNumberArray:array leftIndex:mid + 1 rightIndex:right];
        
        [Sorter merge:array left:left mid:mid right:right];
        
    }
    
}

+(void) quicksortNSNumberArray:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right {
    NSInteger partitionIndex = [self partition:array leftIndex:left rightIndex:right];
    if (left < partitionIndex - 1) {
        [self quicksortNSNumberArray:array leftIndex:left rightIndex:partitionIndex - 1];
    }
    if (partitionIndex < right) {
        [self quicksortNSNumberArray:array leftIndex:partitionIndex rightIndex:right];
    }
    
    
}

+(NSInteger) partition:(NSMutableArray *)array leftIndex:(NSInteger)left rightIndex:(NSInteger)right {
    
    NSInteger leftIndex = left;
    NSInteger rightIndex = right;
    NSInteger pivotIndex = (left + right) / 2;
    NSNumber *pivotValue = (NSNumber *)array[pivotIndex];
    
    while (leftIndex <= rightIndex) {
        while ([(NSNumber *)array[leftIndex] compare:pivotValue] == NSOrderedAscending) {
            ++leftIndex;
        }
        
        while ([(NSNumber *)array[rightIndex] compare:pivotValue] == NSOrderedDescending) {
            --rightIndex;
        }
        
        if (leftIndex <= rightIndex) {
            [self swapArrayPositions:array fromIndex:leftIndex toIndex:rightIndex];
            ++leftIndex;
            --rightIndex;
        }
    }
    
    return leftIndex;
}

+(void) swapArrayPositions:(NSMutableArray *)array fromIndex:(NSInteger)from toIndex:(NSInteger)to {
    NSNumber *save = (NSNumber *)array[from];
    array[from]    = (NSNumber *)array[to];
    array[to]      = (NSNumber *)save;
}

@end
