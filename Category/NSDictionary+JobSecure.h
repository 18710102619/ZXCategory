//
//  NSDictionary+JobSecure.h
//  58AppDemo
//
//  Created by rano on 16/5/4.
//  Copyright © 2016年 rano. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JobSecure)

- (NSString *)job_stringValueForKey:(id)key;
- (NSArray *)job_arrryValueForKey:(id)key;
- (NSDictionary *)job_dicValueForKey:(id)key;
- (NSNumber *)job_numberValueForKey:(id)key;

- (id)job_customCalss:(Class)cls valueForKey:(id)key;

@end
