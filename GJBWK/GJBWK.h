//
//  GJBWK.h
//  GJBWK
//
//  Created by sheldon on 14-5-21.
//  Copyright (c) 2014年 SuiShou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJBWK : NSObject
+(GJBWK *)sharedGJBWK;

-(void)addViewToContainer:(UIView *)v withFlag:(NSString *)flag ;
-(UIView *)findViewFromContainer:(NSString *)flag;

+(BOOL) isBlankString:(NSString *)string ;
+(void) setLocalWithOutTransImageView:(UIImageView *)imageView url:(NSURL *)url placeholderImage:(NSString *)placeholder  contentMode:(UIViewContentMode)contentMode;
@end
