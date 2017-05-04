//
//  WBJobCacheManager.m
//  Pods
//
//  Created by 张玲玉 on 2016/10/19.
//
//

#import "WBJobCacheManager.h"
#import "NSString+MD5.h"

@interface WBJobCacheManager ()

/// 当前App版本号
@property(nonatomic,copy)NSString *appVersion;

@end

@implementation WBJobCacheManager

+ (instancetype)sharedManager
{
    static WBJobCacheManager *instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

/** 创建文件夹 */
- (BOOL)createDirectoryAtPath:(NSString *)path
{
    BOOL *isSuccess=NO;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        for (int i = 0; i < 10; i++) {
            NSError *error = nil;
            [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
            if (error) {
                continue;
            }
            else {
                isSuccess=YES;
                break;
            }
        }
    }
    return isSuccess;
}

/** 删除文件夹 */
- (BOOL)removeItemAtPath:(NSString *)path
{
    BOOL *isSuccess=NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        for (int i = 0; i < 10; i++) {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            if (error) {
                continue;
            }
            else {
                isSuccess=YES;
                break;
            }
        }
    }
    return isSuccess;
}

/** 获取当前版本 */
- (NSString *)appVersion
{
    if (_appVersion==nil) {
        NSDictionary *dic = [[NSBundle mainBundle] infoDictionary];
        _appVersion = [dic objectForKey:@"CFBundleVersion"];
        
        NSString *oldVersion=[[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundleVersion"];
        if (oldVersion==nil) {
            [[NSUserDefaults standardUserDefaults] setObject:_appVersion forKey:@"CFBundleVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        else if(![_appVersion isEqualToString:oldVersion])
        {
            NSString *folder=[self getFolderPath:oldVersion];
            [self removeItemAtPath:folder];
            [[NSUserDefaults standardUserDefaults] setObject:_appVersion forKey:@"CFBundleVersion"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return _appVersion;
}

/** 获取文件夹路径 */
- (NSString *)getFolderPath:(NSString *)appVersion
{
    NSString *folderName = [NSString stringWithFormat:@"%@_%@", appVersion, @"CacheFile.bundle"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *folderPath = [[[paths objectAtIndex:0] stringByAppendingPathComponent:folderName] copy];
    [self createDirectoryAtPath:folderPath];
    return folderPath;
}

/** 获取文件路径 */
- (NSString *)getFilePath:(NSString *)url
{
    NSString *fileName=[NSString stringWithFormat:@"%@.json",[url md5:url]];
    NSString *filePath=[[self getFolderPath:self.appVersion] stringByAppendingPathComponent:fileName];
    return filePath;
}

/** 缓存数据 */
- (BOOL)cacheData:(NSDictionary *)dic url:(NSString *)url
{
    NSString *filePath=[self getFilePath:url];
    if ([[NSFileManager defaultManager] createFileAtPath:filePath contents:nil attributes:nil]) {
        NSData *data=[NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
        [data writeToFile:filePath atomically:NO];
    }
}

/** 获取缓存数据 */
- (NSDictionary *)getCacheData:(NSString *)url
{
    NSString *filePath=[self getFilePath:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        return dic;
    }
    return nil;
}

/** 获取有效缓存数据 */
- (NSDictionary *)getCacheData:(NSString *)url cacheInterval:(NSTimeInterval)seconds
{
    NSString *filePath=[self getFilePath:url];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        NSDate *updateDate=[fileAttributes objectForKey:@"NSFileModificationDate"];
        NSDate *timeoutDate=[updateDate addTimeInterval:seconds];
        NSDate *nowDate=[NSDate date];
        if (NSOrderedAscending==[timeoutDate compare:nowDate]) {
            return nil;
        }
        NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        return dic;
    }
    return nil;
}

@end
