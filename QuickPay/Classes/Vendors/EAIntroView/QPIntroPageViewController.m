//
//  WBIntroPageViewController.m
//  EnterpriseMicroBlog
//
//  Created by liyang on 14-3-26.
//  Copyright (c) 2014年 Enterprise. All rights reserved.
//

#import "QPIntroPageViewController.h"

@interface QPIntroPageViewController ()<UIScrollViewDelegate>
{
}

@property (nonatomic, strong) UIScrollView *pageScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *skipButton;
@end

#define COUNT_PAGE 4

@implementation QPIntroPageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    self.pageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.pageScrollView setContentSize:CGSizeMake(SCREEN_WIDTH*COUNT_PAGE, SCREEN_HEIGHT)];
    self.pageScrollView.pagingEnabled = YES;
    self.pageScrollView.backgroundColor = self.view.backgroundColor;
    self.pageScrollView.delegate = self;
    self.pageScrollView.showsHorizontalScrollIndicator = NO;
    self.pageScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.pageScrollView];
    
    UIImageView *page1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImageView *page2 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImageView *page3 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    UIImageView *page4 = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*3, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.pageScrollView addSubview:page1];
    [self.pageScrollView addSubview:page2];
    [self.pageScrollView addSubview:page3];
    [self.pageScrollView addSubview:page4];
    
    BOOL isIphone4 = [[UIScreen mainScreen] bounds].size.height > 480 ? NO : YES;
    if(isIphone4)
    {
        page1.image = [UIImage imageNamed:@"intro_bg_01"];
        page2.image = [UIImage imageNamed:@"intro_bg_02"];
        page3.image = [UIImage imageNamed:@"intro_bg_03"];
        page4.image = [UIImage imageNamed:@"intro_bg_04"];
    }
    else if(SCREEN_HEIGHT == 568)
    {
        page1.image = [UIImage imageNamed:@"intro_bg_01_568"];
        page2.image = [UIImage imageNamed:@"intro_bg_02_568"];
        page3.image = [UIImage imageNamed:@"intro_bg_03_568"];
        page4.image = [UIImage imageNamed:@"intro_bg_04_568"];
    }
    else if(SCREEN_WIDTH == 375)
    {
        page1.image = [UIImage imageNamed:@"intro_bg_01_750"];
        page2.image = [UIImage imageNamed:@"intro_bg_02_750"];
        page3.image = [UIImage imageNamed:@"intro_bg_03_750"];
        page4.image = [UIImage imageNamed:@"intro_bg_04_750"];
    }else{
        page1.image = [UIImage imageNamed:@"intro_bg_01"];
        page2.image = [UIImage imageNamed:@"intro_bg_02"];
        page3.image = [UIImage imageNamed:@"intro_bg_03"];
        page4.image = [UIImage imageNamed:@"intro_bg_04"];
    }
    
    [self buildFooterView];
}

- (void)buildFooterView {
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-60, SCREEN_WIDTH, 20)];
    [self.pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.pageControl.numberOfPages = COUNT_PAGE;
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:253/255.0 green:176/255.0 blue:94/255.0 alpha:0.4];
    [self.pageControl setCurrentPageIndicatorTintColor:UIColorFromHex(0xffb155)];
    [self.view addSubview:self.pageControl];

    int margin = 60;
    int x = (SCREEN_WIDTH - 318/2) /2;
    int y = SCREEN_HEIGHT - margin - 34;
    self.skipButton = [[UIButton alloc] initWithFrame:CGRectMake(x, y, 318/2, 47)];
    [self.skipButton setAutoresizingMask: UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin];
    [self.skipButton setBackgroundColor:self.view.backgroundColor];
    [self.skipButton.layer setMasksToBounds:YES];
    [self.skipButton.layer setCornerRadius:16.0f];
    self.skipButton.layer.borderColor = UIColorFromHex(0xffb155).CGColor;
    self.skipButton.layer.borderWidth = 1.0f;
    [self.skipButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [self.skipButton setTitleColor:UIColorFromHex(0xffb155) forState:UIControlStateNormal];
    self.skipButton.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [self.skipButton addTarget:self action:@selector(skipIntroduction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.skipButton];
    [self.skipButton setHidden:YES];
}

- (void)skipIntroduction
{
    if ([self.delegate respondsToSelector:@selector(introDidFinish)]) {
        [self.delegate introDidFinish];
    }
    [self.navigationController popViewControllerAnimated:NO];
    [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x / self.pageScrollView.frame.size.width;
    NSInteger page = (int)(offset);
    
    [self.pageControl setCurrentPage:page];
    
    if (page == COUNT_PAGE-1) {
        [self.pageControl setHidden:YES];
        [self.skipButton setHidden:NO];
    }else{
        [self.pageControl setHidden:NO];
        [self.skipButton setHidden:YES];
    }
}

@end
