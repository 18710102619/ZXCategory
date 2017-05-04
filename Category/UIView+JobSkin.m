//
//  UIView+JobSkin.m
//  Pods
//
//  Created by 张玲玉 on 2017/4/21.
//
//

#import "UIView+JobSkin.h"
#import "WBJobDefault.h"

#define isSmall_Screen kMainScreen_Width==320

@implementation UIView (JobSkin)

- (void)job_setFont:(double)size
{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label=(UILabel *)self;
        if (isSmall_Screen) {
            size=size-2;
        }
        label.font=[UIFont systemFontOfSize:size];
    }
}

@end
