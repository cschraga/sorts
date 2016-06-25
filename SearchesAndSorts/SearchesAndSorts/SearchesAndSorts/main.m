//
//  main.m
//  SearchesAndSorts
//
//  Created by Christian Schraga on 6/24/16.
//  Copyright © 2016 Straight Edge Digital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Sorter.h"

int main(int argc, char * argv[]) {
    @autoreleasepool {
        
        NSArray *test = @[@91, @34, @89, @30, @64, @101, @40, @108, @58, @62, @49, @7];
        NSMutableArray *copy = [test mutableCopy];
        [Sorter bucketSortNSNumberArray:copy];
        
        for (NSNumber *number in copy) {
            NSLog(@"next: %d", number.intValue);
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
