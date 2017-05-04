//
//  NSArray+JobIndex.h
//  58AppDemo
//
//  Created by rano on 16/5/4.
//  Copyright © 2016年 rano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (JobIndex)

- (id)job_objectAtIndex:(NSUInteger)index;

- (NSString *)job_stringAtIndex:(NSUInteger)index;

- (NSDictionary *)job_dictionaryAtIndex:(NSUInteger)index;


@end
