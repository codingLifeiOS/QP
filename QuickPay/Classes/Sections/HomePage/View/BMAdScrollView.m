//
//  BMAdScrollView.m
//  UIPageController
//
//  Created by skyming on 14-5-31.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMAdScrollView.h"
#import "UIImageView+WebCache.h"
#define WIDTH ([UIScreen mainScreen].bounds.size.width)
#define HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define PAGE_WIDTH ([UIScreen mainScreen].bounds.size.width)/4
#define PAGE_HEIGHT 10
#define TITLE_WIDTH WIDTH - ([UIScreen mainScreen].bounds.size.width)/4
#define TITLE_HEIGHT 20
#define rightDirection 1
#define zeroDirection 0
#define INTERVALE 3

@implementation BMButton
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

@end

@implementation BMImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
            
    }
    return self;
}

//新定义初始化视图方法
-(id)initWithImageName:(NSString *)imageName title:(NSString *)titleStr x:(CGFloat)xPoint tFrame:(CGRect)titleFrame iHeight:(CGFloat)imageHeight titleHidden:(BOOL)isTitleHidden tag:(NSInteger)tag
{
    //调用原始初始化方法
    CGFloat imageH = imageHeight;
    if ( !isTitleHidden) {
//        imageH = imageHeight - 30;
    }
    self = [super initWithFrame:CGRectMake(xPoint, 0, WIDTH, imageH)];
    if (self) {
        //设置图片视图
        BMButton *imageBtn = [[BMButton alloc]initWithFrame:CGRectMake(0, 0, WIDTH, imageH)];
        imageBtn.tag = tag;
        //给定网络图片路径
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(0, 0, WIDTH, imageH);
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"pic_1.png"]];
        [imageBtn addSubview:imageView];
        //设置点击方法
        [imageBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:imageBtn];
        
        if (isTitleHidden) {
            return self;
        }
        //设置背景条
        
        UIView *titleBack = [[UIView alloc]initWithFrame:titleFrame];
        titleBack.backgroundColor =[UIColor clearColor];
        [self addSubview:titleBack];
        
        //设置标题文字
        CGRect titleRect = titleFrame;
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:titleRect];
        titleLabel.text=titleStr;
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.backgroundColor =[UIColor clearColor];
        titleLabel.textColor=[UIColor blackColor];
        [self addSubview:titleLabel];
    }
    return self;
}

-(void)click:(UIButton *)sender{
    [self.uBdelegate clickImageWithIndex:(sender.tag - 500)];
}

@end

@interface BMAdScrollView()<UIScrollViewDelegate,UrLImageButtonDelegate>
{
    int switchDirection;//方向
//    CGFloat offsetY;
    NSMutableArray *imageNameArr;//图片数组
    NSMutableArray *titleStrArr;//标题数组
    
    UIScrollView *imageSV;//滚动视图
    UIPageControl *pageControl;
}
@end
static  NSInteger pageNumber;//页码

@implementation BMAdScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//自定义实例化方法
- (instancetype)initWithNameArr:(NSMutableArray *)imageArr titleArr:(NSMutableArray *)titleArr height:(float)heightValue offsetY:(CGFloat)offsetY {
    
    self = [super initWithFrame:CGRectMake(0, offsetY, WIDTH, heightValue)];
    
    if (self) {
        self.ADheight = heightValue;
        pageNumber = 0;//设置当前页为1
        imageNameArr = imageArr;
        titleStrArr =  titleArr;

        [self addADScrollView:imageArr.count height:heightValue];
        [self addImages:imageArr titles:titleArr];
        [self addPageControl:imageArr.count];
        _isPause = NO;
      //设置NSTimer
        _timer = [NSTimer scheduledTimerWithTimeInterval:INTERVALE target:self selector:@selector(runTimePage) userInfo:nil repeats:YES];
    }
    return self;
}
- (void)addADScrollView:(NSInteger)count height:(CGFloat)heightValue
{
    //初始化scrollView
    imageSV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, heightValue)];
    //设置sview属性
    imageSV.directionalLockEnabled = YES;//锁定滑动的方向
    imageSV.pagingEnabled = YES;//滑到subview的边界
    imageSV.bounces = NO;
    imageSV.delegate = self;
    imageSV.showsVerticalScrollIndicator = NO;//不显示垂直滚动条
    imageSV.showsHorizontalScrollIndicator = NO;//不显示水平滚动条
    
    CGSize newSize = CGSizeMake(WIDTH * (count + 2),  0);//设置scrollview的大小
    [imageSV setContentSize:newSize];
    
    [imageSV setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:imageSV];

}
- (void)addImages:(NSArray *)imageArr titles:(NSArray *)titleArr
{
    for (int i = 0; i <= imageArr.count +1; i++) {
        
        NSString *title = @"";
        NSString *imageURL = @"";
        if (i != titleStrArr.count +1 && i != 0) {
            title = titleArr[i - 1];
            imageURL = imageArr[i - 1];
        }
        
        if (i == 0) {
            title = titleArr[titleArr.count - 1];
            imageURL = imageArr[imageArr.count - 1];
        }
        
        else if(i == titleArr.count +1)
        {
            title = titleArr[0];
            imageURL = imageArr[0];
        }
        //创建内容对象
        CGRect titleRect = CGRectMake(0, self.frame.size.height - TITLE_HEIGHT, TITLE_WIDTH, TITLE_HEIGHT);
        BMImageView *imageView =  [[BMImageView alloc]initWithImageName:imageURL title:title x:WIDTH*i tFrame:titleRect iHeight:imageSV.frame.size.height titleHidden:NO tag:(500 + i)];
        
        //制定AOView委托
        imageView.uBdelegate = self;
        //设置视图标示
        imageView.tag = i;
        //添加视图
        [imageSV addSubview:imageView];
    }
    [imageSV setContentOffset:CGPointMake(0, 0)];
    [imageSV scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,self.frame.size.height) animated:NO]; // 默认从序号1位置放第1页 ，序号0位置位置放第4页

}
- (void)addPageControl:(NSInteger)count
{
    if (count > 1) {
        CGRect rect =  CGRectMake(WIDTH - PAGE_WIDTH, self.frame.size.height - PAGE_HEIGHT, PAGE_WIDTH, PAGE_HEIGHT);
        pageControl = [[UIPageControl alloc]initWithFrame:rect];
        pageControl.frame = CGRectMake(WIDTH / 2 - 15, self.ADheight - 20, 30, 20);
        pageControl.numberOfPages = count;
        pageControl.pageIndicatorTintColor = UIColorFromHex(0xbebebe);
        pageControl.currentPageIndicatorTintColor = UIColorFromHex(0xfe850f);
        [self addSubview:pageControl];
    }
    
}

- (void)setPageCenter:(CGPoint)pageCenter
{
    pageControl.center = pageCenter;
}

// scrollview 委托函数
- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pagewidth = imageSV.frame.size.width;
    int page = floor((imageSV.contentOffset.x - pagewidth/([imageNameArr count]+2))/pagewidth)+1;
    page --;  // 默认从第二页开始
    pageControl.currentPage = page;
    pageNumber = pageControl.currentPage;
}

// scrollview 委托函数
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ( _isPause == NO) {
        NSLog(@"暂停计时器");
        _isPause = YES;
        [_timer setFireDate:[NSDate distantFuture]];
        
        [self performSelector:@selector(pauseTimer) withObject:nil afterDelay:5];
    }
    CGFloat pagewidth = imageSV.frame.size.width;
    int currentPage = floor((imageSV.contentOffset.x - pagewidth/ ([imageNameArr count]+2)) / pagewidth) + 1;

    if (currentPage == 0)
    {
        [imageSV scrollRectToVisible:CGRectMake(WIDTH * [imageNameArr count],0,WIDTH,HEIGHT) animated:NO]; // 序号0 最后1页
    }
    else if (currentPage == ([imageNameArr count]+1))
    {
        [imageSV scrollRectToVisible:CGRectMake(WIDTH,0,WIDTH,HEIGHT) animated:NO]; // 最后+1,循环第1页
    }
   
}
-(void)pauseTimer{
    if (self.myThread) {
        [self.myThread cancel];
    }

    self.myThread = [[NSThread alloc] initWithTarget:self
                                            selector:@selector(resumerTimer1)object:nil];
    [_myThread start];
}

- (void)resumerTimer1{
    [_timer setFireDate:[NSDate date]];
    _isPause = NO;
}

// pagecontrol 选择器的方法
- (void)turnPage
{
    NSInteger page = pageControl.currentPage; // 获取当前的page
    [imageSV scrollRectToVisible:CGRectMake(WIDTH*(page+1),0,WIDTH,HEIGHT) animated:NO]; // 触摸pagecontroller那个点点 往后翻一页 +1
}
// 定时器 绑定的方法
- (void)runTimePage
{
    NSInteger page = pageControl.currentPage; // 获取当前的page
    page++;
    page = page > imageNameArr.count-1 ? 0 : page ;
    pageControl.currentPage = page;
    pageNumber = pageControl.currentPage;
    [self turnPage];
}

#pragma UBdelegate
- (void)clickImageWithIndex:(NSInteger)index
{
    //调用委托实现方法
    [self.delegate buttonClick:index];
}
@end
