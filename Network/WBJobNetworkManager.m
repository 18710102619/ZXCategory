//
//  WBJobNetworkManager.m
//  Pods
//
//  Created by 张玲玉 on 2016/10/19.
//
//

#import "WBJobNetworkManager.h"
#import "WBJobCacheManager.h"

@implementation WBJobNetworkManager

+ (instancetype)sharedManager
{
    static WBJobNetworkManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/** 获取缓存数据 */
- (void)requestTarget:(id)target
           requestURL:(NSString *)urlStr
        requestPramas:(NSDictionary *)pramasDic
        cacheInterval:(NSTimeInterval)seconds
      completionBlock:(WBNetworkCompletionBlock)completionBlock
{
    if (seconds==0) {
        [self getBuiltinDataTarget:target requestURL:urlStr completionBlock:completionBlock];
        [self getServiceTarget:target requestURL:urlStr requestPramas:pramasDic completionBlock:completionBlock];
    }
    else{
        NSDictionary *data=[WBJobCache getCacheData:urlStr cacheInterval:seconds];
        if (data!=nil) {
            completionBlock(WBNetworkResponesSuccess,data);
        }
        else {
            [self getServiceTarget:target requestURL:urlStr requestPramas:pramasDic completionBlock:completionBlock];
        }
    }
}

/** 获取服务器数据 */
- (void)getServiceTarget:(id)target
              requestURL:(NSString *)urlStr
           requestPramas:(NSDictionary *)pramasDic
         completionBlock:(WBNetworkCompletionBlock)completionBlock
{
    WBNetworkConfiguration *item=[WBNetworkConfiguration requestWithURL:urlStr requestMethod:WBNetworkRequestGet requestPramas:pramasDic];
    [WBNetwork requestTarget:self configuration:item completionBlock:^(WBNetworkResponesResult resultType, id responseData) {
        if (resultType == WBNetworkResponesSuccess) {
            if ([responseData isKindOfClass:[NSDictionary class]]) {
                completionBlock(WBNetworkResponesSuccess,responseData);
                [WBJobCache cacheData:responseData url:urlStr];
            }
        }
        else {
            [self getBuiltinDataTarget:target requestURL:urlStr completionBlock:completionBlock];
        }
    }];
}

/** 获取内置数据 */
- (void)getBuiltinDataTarget:(id)target
                  requestURL:(NSString *)urlStr
             completionBlock:(WBNetworkCompletionBlock)completionBlock
{
    NSDictionary *data=[WBJobCache getCacheData:urlStr];
    if (data!=nil) {
        completionBlock(WBNetworkResponesSuccess,data);
    }
    else {
        NSString *filePath;
        if ([urlStr isEqualToString:kMain_HTTP]) {
            filePath = [[NSBundle mainBundle] pathForResource:@"JobBuiltinFile.bundle/job_main_page_http" ofType:@"json"];
        }
        else if ([urlStr isEqualToString:kMain_HTTPS]) {
            filePath = [[NSBundle mainBundle] pathForResource:@"JobBuiltinFile.bundle/job_main_page_https" ofType:@"json"];
        }
        else if ([urlStr isEqualToString:kPost_Bigcate_HTTP]) {
            filePath = [[NSBundle mainBundle] pathForResource:@"JobBuiltinFile.bundle/job_post_bigcate_http" ofType:@"json"];
        }
        else if ([urlStr isEqualToString:kPost_Bigcate_HTTPS]) {
            filePath = [[NSBundle mainBundle] pathForResource:@"JobBuiltinFile.bundle/job_post_bigcate_https" ofType:@"json"];
        }
        else if ([urlStr isEqualToString:kResume_Bigcate_HTTP]) {
            filePath = [[NSBundle mainBundle] pathForResource:@"JobBuiltinFile.bundle/job_resume_bigcate_http" ofType:@"json"];
        }
        else if ([urlStr isEqualToString:kResume_Bigcate_HTTPS]) {
            filePath = [[NSBundle mainBundle] pathForResource:@"JobBuiltinFile.bundle/job_resume_bigcate_https" ofType:@"json"];
        }
        else {
            return;
        }
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if (dic!=nil) {
            completionBlock(WBNetworkResponesSuccess,dic);
        }
    }
}

@end
