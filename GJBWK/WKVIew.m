//
//  WKVIew.m
//  Pods
//
//  Created by sheldon on 6/6/14.
//
//

#import "WKView.h"
#import "GJBWK.h"
@implementation WKView



- (id)initWithFrame:(CGRect)frame withViewLayout:(WKViewLayout *)viewLayout
{
    
    self.viewLayout = viewLayout;

  
    if ([GJBWK isBlankString:viewLayout.type]) {
        self = [super initWithFrame:frame];
    }else{
        CGRect tmpFrame  = CGRectMake(self.viewLayout.origin.x,self.viewLayout.origin.y,self.viewLayout.width, self.viewLayout.height);
        self = [super initWithFrame:tmpFrame];
        
    }
    if (self) {
        // Initialization code
    }
    return self;
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
