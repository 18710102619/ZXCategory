//
//  NSString+MD5.m
//  Pods
//
//  Created by 张玲玉 on 2016/10/19.
//
//

#import "NSString+MD5.h"
#import<CommonCrypto/CommonDigest.h>  

@implementation NSString (MD5)

- (NSString *)md5:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), digest);
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

@end
