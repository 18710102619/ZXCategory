//
//  NSArray+JobIndex.m
//  58AppDemo
//
//  Created by rano on 16/5/4.
//  Copyright © 2016年 rano. All rights reserved.
//

#import "NSArray+JobIndex.h"

@implementation NSArray (JobIndex)

- (id)job_objectAtIndex:(NSUInteger)index
{
    if (![self isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (index < self.count) {
        return [self objectAtIndex:index];
    }else
    {
        return nil;
    }
}

- (NSString *)job_stringAtIndex:(NSUInteger)index
{
    id obj = [self job_objectAtIndex:index];
    if ([obj isKindOfClass:[NSString class]]) {
        return (NSString *)obj;
    }
    return nil;
}

- (NSDictionary *)job_dictionaryAtIndex:(NSUInteger)index
{
    id obj = [self job_objectAtIndex:index];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)obj;
    }
    return nil;
}

@end
