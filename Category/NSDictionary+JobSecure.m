//
//  NSDictionary+JobSecure.m
//  58AppDemo
//
//  Created by rano on 16/5/4.
//  Copyright © 2016年 rano. All rights reserved.
//

#import "NSDictionary+JobSecure.h"

#define classValueForKey(_cls_)\
if (![self isKindOfClass:[NSDictionary class]]) {\
return nil;\
}\
if (!key) {\
return nil;\
}\
if ([key isEqual:[NSNull null]]) {\
return nil;\
}\
id value = [self objectForKey:key];\
if (!value || [value isEqual:[NSNull null]]) {\
return nil;\
}\
if ([value isKindOfClass:_cls_]) {\
return value;\
}\
return nil;


@implementation NSDictionary (JobSecure)

- (NSString *)job_stringValueForKey:(id)key
{
    if (![self isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    if (!key) {
        return nil;
    }
    if ([key isEqual:[NSNull null]]) {
        return nil;
    }
    id value = [self objectForKey:key];
    if (!value || [value isEqual:[NSNull null]]) {
        return nil;
    }
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    }
    if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    }
    return nil;

}

- (NSArray *)job_arrryValueForKey:(id)key
{
    classValueForKey([NSArray class]);
}

- (NSDictionary *)job_dicValueForKey:(id)key
{
    classValueForKey([NSDictionary class]);
}

- (NSNumber *)job_numberValueForKey:(id)key
{
    classValueForKey([NSNumber class]);
}

- (id)job_customCalss:(Class)cls valueForKey:(id)key
{
    classValueForKey(cls);
}

@end
