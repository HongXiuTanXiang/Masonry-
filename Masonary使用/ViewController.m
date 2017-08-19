//
//  ViewController.m
//  Masonary使用
//
//  Created by lihe on 17/4/23.
//  Copyright © 2017年 lihe. All rights reserved.
//

#import "ViewController.h"

//1. 使用全局宏定义, 可以在调用masonry方法的时候不使用mas_前缀
#define MAS_SHORTHAND

//2. 可以使equalTo等效于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
//导入头文件前先定义上面两个宏
#import "Masonry.h"

#import "KKButton.h"
#import "UIView+Frame.h"

@interface ViewController ()

@property (nonatomic, weak) UIView *redView;
@property (nonatomic, weak) KKButton *btn;

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *blueView;
@property (nonatomic, strong) UIView *yellowView;


@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGFloat scacle;


@property (nonatomic, assign) BOOL isExpanded;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self test2];

}


- (void)createExpandButton {
    self.isExpanded = NO;
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    self.growingButton.backgroundColor = [UIColor redColor];
    [self.growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-350);
    }];
}





- (void)createGrowingButton {
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"点我放大" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    [self.growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    self.scacle = 1.0;
    [self.growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scacle);
        // 最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
    }];
}

- (void)onGrowButtonTaped:(UIButton *)sender {
//    self.scacle += 1.0;
//    // 告诉self.view约束需要更新
//    [self.view setNeedsUpdateConstraints];
//    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
//    [self.view updateConstraintsIfNeeded];
//    [UIView animateWithDuration:0.3 animations:^{
//        [self.view layoutIfNeeded];
//    }];
    
    self.isExpanded = !self.isExpanded;
    if (!self.isExpanded) {
        [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
    } else {
        [self.growingButton setTitle:@"点我收起" forState:UIControlStateNormal];
    }
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}




// 重写该方法来更新约束,这个方法系统自动调用,使用autolayout之后,系统在view显示之前,或则有需要更新约束的时候,都会来调用这个方法
- (void)updateViewConstraints {
//    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        // 这里写需要更新的约束，不用更新的约束将继续存在
//        // 不会被取代，如：其宽高小于屏幕宽高不需要重新再约束
//        make.width.height.mas_equalTo(20 * self.scacle);
//    }];
//    [super updateViewConstraints];
    
    
    // 这里使用update也能实现效果
    // remake会将之前的全部移除，然后重新添加
    __weak __typeof(self) weakSelf = self;
    [self.growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        // 这里重写全部约束，之前的约束都将失效
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        if (weakSelf.isExpanded) {
            make.bottom.mas_equalTo(0);
        } else {
            make.bottom.mas_equalTo(-350);
        }
    }];
    [super updateViewConstraints];
}


- (void)testBasic
{
    int padding = 15;
    UIView *greenView = [[UIView alloc]init];
    [self.view addSubview:greenView];
    greenView.backgroundColor = [UIColor greenColor];
    UIView *redView = [[UIView alloc]init];
    [self.view addSubview:redView];
    redView.backgroundColor = [UIColor redColor];
    UIView *blueView = [[UIView alloc]init];
    [self.view addSubview:blueView];
    blueView.backgroundColor = [UIColor blueColor];
    // 对 绿色View 进行约束
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(padding); // X
        make.top.mas_equalTo(self.view.mas_top).with.offset(padding); // Y
        make.bottom.mas_equalTo(blueView.mas_top).with.offset(-padding);// Y --> 推断出 Height
        make.width.mas_equalTo(redView); // Width == 红色View（它推断出Width）
    }];
    // 对 红色View 进行约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(greenView.mas_right).with.offset(padding); // X
        make.right.mas_equalTo(self.view.mas_right).with.offset(-padding);// X --> 推断出 Width
        make.bottom.and.height.mas_equalTo(greenView); // Y & Height == 绿色View（它推断出 Height&Y）
    }];
    // 对 蓝色View 进行约束
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(padding); // X
        make.right.mas_equalTo(self.view.mas_right).with.offset(-padding); // X --> 推断出 Width
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-padding); // Y
        make.height.mas_equalTo(greenView); // 注意1：Height == 绿色View（它推断出Height）,这里也可以填写某个固定值
    }];
}

- (void)test_priority {
    // 红色View
    UIView *redView = [[UIView alloc]init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    // 蓝色View
    self.blueView = [[UIView alloc]init];
    self.blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.blueView];
    // 黄色View
    UIView *yellowView = [[UIView alloc]init];
    yellowView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:yellowView];
    // ---红色View--- 添加约束
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(20);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-80);
        make.height.equalTo([NSNumber numberWithInt:50]);
    }];
    // ---蓝色View--- 添加约束
    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(redView.mas_right).with.offset(40);
        make.bottom.width.height.mas_equalTo(redView);
    }];
    // ---黄色View--- 添加约束
    [yellowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.blueView.mas_right).with.offset(40);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-20);
        make.bottom.width.height.mas_equalTo(redView);
        // 优先级设置为250，最高1000（默认）
        make.left.mas_equalTo(redView.mas_right).with.offset(20).priority(250);
    }];
}

// 点击屏幕移除蓝色View
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.blueView removeFromSuperview];
    [UIView animateWithDuration:1.0 animations:^{
        [self.view layoutIfNeeded];
    }];
}


- (void)test00 {
    UIView *containerView = [[UIView alloc]init];
    containerView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:containerView];
    
    UIEdgeInsets  padding = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //用法1,四约法
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.left).and.offset(padding.left);
        make.right.equalTo(self.view.right).and.offset(-padding.right);
        make.bottom.equalTo(self.view.bottom).and.offset(-padding.bottom);
        //
        make.height.equalTo(200);
        
        
    }];
    
    
    //用法2,边约法
    UIView *redview = [UIView new];
    _redView = redview;
    redview.backgroundColor = [UIColor redColor];
    [containerView addSubview:redview];
    [redview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.edges.equalTo(containerView).insets(padding);
        //简写,现在可以大胆的使用equalTo了
        make.edges.equalTo(padding);
        
    }];
    
    
#ifdef DEBUG
    
    MASAttachKeys(containerView,redview);
    
#else
    
#endif
    
    
    KKButton *btn1 = [[KKButton alloc]init];
    _btn = btn1;
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"点我啊" forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[self imageWithColor:[UIColor greenColor]] forState:UIControlStateNormal];
    [redview addSubview:btn1];
    
    [btn1 makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(redview.center);
        make.size.equalTo(redview).and.sizeOffset(CGSizeMake(-20, -20));
    }];
    
    
    [self test3];
    
}

/**
 首尾间距固定且等间距
 */
-(void)test0{
    //首先添加5个视图
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 5; i ++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor greenColor];
        [self.view addSubview:view];
        [array addObject:view]; //保存添加的控件
    }
    
    //水平首尾固定等间距,
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:15.0 leadSpacing:10.0 tailSpacing:10.0];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.top).and.offset(100);
        make.height.equalTo(60);
    }];
    
}


/**
 首尾固定,宽度固定,间距变化
 */
-(void)test1{
    //首先添加5个视图
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 5; i ++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
        [array addObject:view]; //保存添加的控件
    }
    
    [array mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:40.0 leadSpacing:10 tailSpacing:10];
    [array mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(300);
        make.height.equalTo(60);
    }];
    
}


/**
 多行label问题
 */
-(void)test2{
    //创建label
    UILabel *label = [[UILabel alloc]init];
    _label = label;
    self.label.numberOfLines = 0;
    _label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = [UIColor redColor];
    self.label.lineBreakMode = NSLineBreakByTruncatingTail;
    self.label.text = @"OpenGL存储它的所有深度信息于一个Z缓冲(Z-buffer)中，也被称为深度缓冲(Depth Buffer)。GLFW会自动为你生成这样一个缓冲（就像它也有一个颜色缓冲来存储输出图像的颜色）。深度值存储在每个片段里面（作为片段的z值），当片段想要输出它的颜色时，OpenGL会将它的深度值和z缓冲进行比较，如果当前的片段在其它片段之后，它将会被丢弃，否则将会覆盖。这个过程称为深度测试(Depth Testing)，它是由OpenGL自动完成的。然而，如果我们想要确定OpenGL真的执行了深度测试，首先我们要告诉OpenGL我们想要启用深度测试；它默认是关闭的。我们可以通过glEnable函数来开启深度测试。glEnable和glDisable函数允许我们启用或禁用某个OpenGL功能。这个功能会一直保持启用/禁用状态，直到另一个调用来禁用/启用它。现在我们想启用深度测试，需要开启GL_DEPTH_TEST：";
    [self.view addSubview:label];
    
    self.label.textColor = [UIColor blackColor];
    
    [label makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.top.equalTo(20);
        make.right.equalTo(-20);
    }];
    
    
}



/**
 scrollView使用自动布局
 */
- (void)test3 {
    //创建滚动视图
    UIScrollView *scrollView = [UIScrollView new];
    self.scrollView = scrollView;
    
    scrollView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:scrollView];
    
    [self.scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //约束UIScrollView上contentView
    UIView *contentView = [UIView new];
    [self.scrollView addSubview:contentView];
    
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
//        make.width.equalTo(200);
//        make.width.equalTo(1000);
        make.width.equalTo(300);
        
    }];
    
    

    
    //添加控件到contentView，约束原理与自动布局相同
    UIView *lastView;
    CGFloat height = 30;
    for (int i = 0; i <15; i ++) {
        UIView *view = UIView.new;
        view.backgroundColor = [UIColor colorWithRed:arc4random() % 255 / 256.0  green:arc4random() % 255 / 256.0 blue:arc4random() % 255 / 256.0 alpha:1.0];
        [contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView ? lastView.bottom : @0);
            make.left.equalTo(0);
            make.width.equalTo(800);
            make.height.equalTo(height);
        }];
        
        height += 30;
        lastView = view;
    }
    
    
    //最后再改变一下 容器view的底部约束,这样就确定了scorllView的滚动范围了;
    [contentView makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastView.bottom);
    }];

}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 40;
    NSLog(@"%@",NSStringFromCGRect(self.label.frame));
    

}

- (void)btnClick:(UIButton*)btn{
    
    

    [UIView animateWithDuration:2.0 animations:^{
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_redView.center);
            make.size.equalTo(_redView).sizeOffset(CGSizeMake(-60, -60));
        }];
        
        //动画必须用这个方法实现
        [btn.superview layoutIfNeeded];
        
    }];
    


}






//获得一张图片
- (UIImage *)imageWithColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 8, 8);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
