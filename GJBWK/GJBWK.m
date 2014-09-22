//
//  GJBWK.m
//  GJBWK
//
//  Created by sheldon on 14-5-21.
//  Copyright (c) 2014年 SuiShou. All rights reserved.
//

#import "GJBWK.h"
#import "UIImageView+AFNetworking.h"
@implementation GJBWK
{
    @private
    NSMutableDictionary *viewContainer;
}
+ (GJBWK *)sharedGJBWK {
    static GJBWK *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedClient = [[self alloc] init];
        _sharedClient -> viewContainer = [[NSMutableDictionary alloc] init];
    });
    return _sharedClient;
}


-(void)addViewToContainer:(UIView *)v withFlag:(NSString *)flag {
    if (v != nil && ![GJBWK isBlankString:flag]) {
        
        if ([[self -> viewContainer allKeys ] containsObject:flag]) {
            [self -> viewContainer removeObjectForKey:flag];
        }
        [self -> viewContainer setObject:v forKey:flag];
    }
  
}
-(UIView *)findViewFromContainer:(NSString *)flag {
    if (![GJBWK isBlankString:flag]) {
        if ([[self -> viewContainer allKeys ] containsObject:flag]) {
            return [self -> viewContainer objectForKey:flag];
        }
    }
    return nil;
}


+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[NSString stringWithFormat:@"%@",string] length]==0) {
        return YES;
    }
    //    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
    //        return YES;
    //    }
    
    return NO;
}


+(void)setLocalWithOutTransImageView:(UIImageView *)imageView url:(NSURL *)url placeholderImage:(NSString *)placeholder  contentMode:(UIViewContentMode)contentMode
{
    [imageView setContentMode:contentMode];
    [imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:placeholder]];
    [imageView setClipsToBounds:YES];
}
@end
