//
//  WBJobNetworkManager.h
//  Pods
//
//  Created by 张玲玉 on 2016/10/19.
//
//

#import <Foundation/Foundation.h>
#import "WBNetworkManager.h"
#import "WBNetwork.h"
#import "WBJobNetworkAddress.h"

#define WBJobNetwork [WBJobNetworkManager sharedManager]

@interface WBJobNetworkManager : NSObject

+ (instancetype)sharedManager;

/** 获取缓存数据 */
- (void)requestTarget:(id)target
           requestURL:(NSString *)urlStr
        requestPramas:(NSDictionary *)pramasDic
        cacheInterval:(NSTimeInterval)seconds
      completionBlock:(WBNetworkCompletionBlock)completionBlock;

@end
