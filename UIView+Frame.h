//
//  UIView+Frame.h
//  彩票
//
//  Created by lihe on 16/10/17.
//  Copyright © 2016年 xiaomage. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)



@property (nonatomic,assign) CGFloat kk_width;
@property (nonatomic,assign) CGFloat kk_height;
@property (nonatomic,assign) CGFloat kk_x;
@property (nonatomic,assign) CGFloat kk_y;


@property (nonatomic, assign) CGFloat kk_centerX;
@property (nonatomic, assign) CGFloat kk_centerY;

@property (nonatomic, assign) CGFloat kk_right;
@property (nonatomic, assign) CGFloat kk_bottom;

+ (instancetype)viewFromXib;
- (BOOL)intersectWithOtherView:(UIView *)view;
@end
