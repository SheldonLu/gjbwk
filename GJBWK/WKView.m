//
//  WKView.m
//  shiyimm
//
//  Created by sheldon on 14-5-20.
//  Copyright (c) 2014年 shiyimm. All rights reserved.
//

#import "WKView.h"
#import "objc/runtime.h"
#import "GJBWK.h"
#define WK_TAG 51212


@interface WKView()
@property(nonatomic,weak) id target;
@end

@implementation WKView
{
    NSMutableDictionary *idKeyDic;
    
    NSArray *actionsArray;
    
    int tag_count;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}




- (id)initWithFrame:(CGRect)frame withLayout:(id)layouts withTarget:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        _target = target;
        // Initialization code
        
        idKeyDic = [NSMutableDictionary dictionary];
        tag_count = WK_TAG;
        
        NSArray *views = [layouts objectForKey:@"views"];
        [self layoutViews:views rootView:self];
        
        NSArray *binds = [layouts objectForKey:@"binds"];
        [self bindDataAndActions:binds];
        
        actionsArray = [layouts objectForKey:@"actions"];
    }
    return self;
}


- (void)layoutViews:(NSArray *)views rootView:(UIView *)rootView
{
    for (int i=0; views !=nil && i<[views count]; i++) {
        tag_count ++;
        NSDictionary *itemView = [views objectAtIndex:i];
        
        if (![GJBWK isBlankString:[itemView objectForKey:@"id"]]) {
            [idKeyDic setObject:[NSNumber numberWithInt:tag_count] forKey:[itemView objectForKey:@"id"]];
        }
        
        UIView *childView;
        
        if ([[[itemView objectForKey:@"type"] uppercaseString] isEqualToString:@"IMAGEVIEW"]) {
            //组件是ImageView
            childView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[itemView objectForKey:@"width"] intValue], [[itemView objectForKey:@"height"] intValue])];
            [rootView addSubview:childView];
        }
        
        
        if (childView!=nil) {
            childView.tag = tag_count ;
            if ([itemView objectForKey:@"views"] &&
                [[itemView objectForKey:@"views"] isKindOfClass:[NSArray class]]) {
                [self layoutViews:[itemView objectForKey:@"views"] rootView:childView];
            }
        }
        
    }
}


- (void)bindDataAndActions:(NSArray *)binds
{
    for (int i=0; binds && i<[binds count]; i++) {
        NSDictionary *bindItem = [binds objectAtIndex:i];
        if (![GJBWK isBlankString:[bindItem objectForKey:@"id"]] && [idKeyDic objectForKey:[bindItem objectForKey:@"id"]] !=nil) {
            NSNumber *number  = [idKeyDic objectForKey:[bindItem objectForKey:@"id"]];
            UIView *dynamicView =  [self viewWithTag:[number intValue]];
            
            
            if ([dynamicView isKindOfClass:[UIImageView class]]) {
                
                //绑定数据
                if (![GJBWK isBlankString:[bindItem objectForKey:@"img"]]) {
//                    [ImageUtil setLocalWithOutTransImageView:((UIImageView *)dynamicView) url:[NSURL URLWithString:[bindItem objectForKey:@"img"]] placeholderImage:nil contentMode:UIViewContentModeScaleAspectFill];
                }
                
                if ([bindItem objectForKey:@"actions"]) {
                    for (int j=0; j<[[bindItem objectForKey:@"actions"] count]; j++) {
                        NSDictionary *actionItem = [[bindItem objectForKey:@"actions"] objectAtIndex:j];
                        
                        if (![GJBWK isBlankString:[actionItem objectForKey:@"trigger"]] &&
                            ![GJBWK isBlankString:[actionItem objectForKey:@"script"]]) {
                            
                            objc_setAssociatedObject(dynamicView, @"script", [actionItem objectForKey:@"script"], OBJC_ASSOCIATION_COPY);
                            
                            if ([dynamicView isKindOfClass:[UIButton class]]) {
                                
                            }else{
                                if ([[[actionItem objectForKey:@"trigger"] lowercaseString] isEqualToString:@"click"]) {
                                    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doAction:)];
                                    [dynamicView setUserInteractionEnabled:YES];
                                    [dynamicView addGestureRecognizer:tapGestureRecognizer];
                                }
                                
                            }
                            
                        }
                        
                        
                    }
                    
                }
            }
        }
    }
}

-(void)doAction:(id)sender
{
    NSString *script;
    if (sender && [sender isKindOfClass:[UIGestureRecognizer class]]) {
        script = objc_getAssociatedObject(((UIGestureRecognizer *)sender).view, @"script");
    }else if (sender!=nil && [sender isKindOfClass:[UIButton class]]) {
        script = objc_getAssociatedObject(sender, @"script");
    }
    
    if (actionsArray!=nil) {
        for (int i=0; i< [actionsArray count]; i++) {
            id actionItem = [actionsArray objectAtIndex:i];
            if ([[script lowercaseString] isEqualToString:[[actionItem objectForKey:@"id"] lowercaseString]]) {
                if ([[actionItem objectForKey:@"type"] isEqualToString:@"dismiss"]) {
                    if (_target && [_target isKindOfClass:[UIViewController class]]) {
//                        if ([_target respondsToSelector:@selector(popViewController)]) {
//                            [_target popViewController];
//                        }else{
                            [_target dismissViewControllerAnimated:YES completion:nil];
//                        }
                        
                    }

                }
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
