//
//  WKViewLayout.h
//  Pods
//
//  Created by sheldon on 6/6/14.
//
//

#import <Foundation/Foundation.h>
#import "WKOrigin.h"
#import "WKPadding.h"
@interface WKViewLayout : NSObject

@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *viewId;
@property (nonatomic,assign) float width;
@property (nonatomic,assign ) float height;
@property (nonatomic,strong) NSString *background;
@property (nonatomic,strong) NSString *borderColor;
@property (nonatomic,assign) float borderWidth;
@property (nonatomic,assign) float opacity;
@property (nonatomic,strong ) WKOrigin *origin;
@property (nonatomic,strong) NSString *rightOf;
@property (nonatomic,strong) NSString *leftOf;
@property (nonatomic,strong) NSString *topOf;
@property (nonatomic,strong) NSString *bottomOf;
@property (nonatomic, strong ) WKPadding *padding;


@property(nonatomic,strong) NSArray *viewsArray; //子View 配置数组

@end
