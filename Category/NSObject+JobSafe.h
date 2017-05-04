//
//  NSObject+JobSafe.h
//  Pods
//
//  Created by 张玲玉 on 2017/2/22.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (JobSafe)

- (id)job_valueForKey:(NSString *)key;

- (void)job_setValue:(id)value forKey:(NSString *)key;

- (void)job_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

- (void)job_removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath;

- (id)job_objectAtIndex:(NSUInteger)index;

- (void)job_addObject:(id)anObject;

- (id)job_objectForKey:(NSString *)aKey;

- (void)job_setObject:(id)anObject forKey:(id)aKey;

- (NSString *)job_stringForKey:(NSString *)key;

- (void)job_insertString:(NSString *)aString atIndex:(NSUInteger)loc;

- (NSString *)job_getUrlString:(NSString *)url;

- (void)job_sd_setImageWithURL:(nullable NSURL *)url placeholderImage:(nullable UIImage *)placeholder;

@end




