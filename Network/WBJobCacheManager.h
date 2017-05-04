//
//  WBJobCacheManager.h
//  Pods
//
//  Created by 张玲玉 on 2016/10/19.
//
//

#import <Foundation/Foundation.h>

#define WBJobCache [WBJobCacheManager sharedManager]

@interface WBJobCacheManager : NSObject

+ (instancetype)sharedManager;

/** 缓存数据 */
- (BOOL)cacheData:(NSDictionary *)data url:(NSString *)url;

/** 获取缓存数据 */
- (NSDictionary *)getCacheData:(NSString *)url;

/** 获取有效缓存数据 */
- (NSDictionary *)getCacheData:(NSString *)url cacheInterval:(NSTimeInterval)seconds;

@end
