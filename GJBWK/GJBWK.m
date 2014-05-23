//
//  GJBWK.m
//  GJBWK
//
//  Created by sheldon on 14-5-21.
//  Copyright (c) 2014年 SuiShou. All rights reserved.
//

#import "GJBWK.h"

@implementation GJBWK
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
@end
