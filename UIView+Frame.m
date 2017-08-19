//
//  UIView+Frame.m
//  彩票
//
//  Created by lihe on 16/10/17.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)


/**
 加载自定义xib的View

 @return 返回Xib描述的view
 */
+(instancetype)viewFromXib{
    
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]lastObject];
    
}


/**
 是否与其他对象重叠

 @param view 其他view

 @return 判断结果
 */
- (BOOL)intersectWithOtherView:(UIView *)view{
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return  CGRectIntersectsRect(selfRect, viewRect) ;
    
    
}


- (CGFloat)kk_width{
    return self.bounds.size.width;
}

-(CGFloat)kk_height{
    
    return self.bounds.size.height;

}

-(void)setKk_width:(CGFloat)kk_width{

    CGRect frame = self.frame;
    frame.size.width = kk_width;
    self.frame = frame;

}


-(void)setKk_height:(CGFloat)kk_height{
    
    CGRect frame = self.frame;
    frame.size.height = kk_height;
    self.frame = frame;

}

-(CGFloat)kk_x{

    return self.frame.origin.x;
}

-(void)setKk_x:(CGFloat)kk_x{

    CGRect frame = self.frame;
    frame.origin.x = kk_x;
    self.frame = frame;

}

-(CGFloat)kk_y{
    
    return self.frame.origin.y;
}

-(void)setKk_y:(CGFloat)kk_y{
    
    CGRect frame = self.frame;
    frame.origin.y = kk_y;
    self.frame = frame;
    
}


-(CGFloat)kk_centerX{
    
    return self.center.x;
}


-(void)setKk_centerX:(CGFloat)kk_centerX{
    
    CGPoint center = self.center;
    center.x = kk_centerX;
    self.center = center;
    
}


-(CGFloat)kk_centerY{
    
    return self.center.y;
}


-(void)setKk_centerY:(CGFloat)kk_centerY{
    
    CGPoint center = self.center;
    center.y = kk_centerY;
    self.center = center;
    
}


-(CGFloat)kk_right{

    
    return  CGRectGetMaxX(self.frame);
    
}

-(void)setKk_right:(CGFloat)kk_right{
    
    self.kk_x = kk_right - self.kk_width;
    
}


-(CGFloat)kk_bottom{
    
    
    return  CGRectGetMaxY(self.frame);
}

-(void)setKk_bottom:(CGFloat)kk_bottom{
    
    self.kk_y = kk_bottom - self.kk_height;
    
}


@end
