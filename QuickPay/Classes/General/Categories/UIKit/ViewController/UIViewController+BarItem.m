//
//  UIViewController+BarItem.m
//  LianjiaNG
//
//  Created by Nie on 14/12/12.
//  Copyright (c) 2014年 Lianjia. All rights reserved.
//

#import "UIViewController+BarItem.h"
#import <objc/runtime.h>

static const CGFloat IMBackBarItemButtonHeight = 35;
static const CGFloat IMBackBarItemButtonInsetTop = -5;

static const CGFloat IMBarButtonLeftInset = -15;
static const CGFloat IMBarButtonTitleLeftInset = 8.0f;

static const CGFloat IMRightItemButtonWidthSpace = 10.0f;
static const CGFloat IMRightItemButtonWidth = 40.0f;
static const CGFloat IMRightShareItemButtonWidth = 20.f;
static const CGFloat IMBackBarItemButtonWidth = 40.0f;

@implementation UIViewController (BarItem)

- (void)createSystemItemWithTitle:(NSString*)buttonTitle
                        titleText:(NSString*)titleString
{
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc]init];
    backItem.title = buttonTitle;
    self.navigationItem.backBarButtonItem = backItem;
    [self addTitleToNavBar:titleString];
}

- (void)createBackBarItemWithoutBackButtonAndTitle:(NSString*)title
{
    [self addTitleToNavBar:title];
}

- (void)createBackBarItemWithTitle:(NSString*)title
{
    [self createBarItemByImageName:IMAGE_BACH_ICON_GRAY
                             title:title
                       buttonTitle:nil
                            target:self
                            action:@selector(commonPushBack)];
}

- (void)createBackBarItemWithTitle:(NSString*)title
                       buttonTitle:(NSString*)buttonTitle
{
    [self createBarItemByImageName:IMAGE_BACH_ICON_GRAY
                             title:title
                       buttonTitle:buttonTitle
                            target:self
                            action:@selector(commonPushBack)];
}

- (void)createBackBarItemsWithTitle:(NSString *)title
                       buttonTitle:(NSString *)buttonTitle
            closeButtonBlockHander:(void(^)(id sender))hander
{
    WEAKSELF();
    UIButton *backButton = [self barButtonItemWithTitle:STRING_BACK buttonWidth:50 handler:^(id sender) {
        [weakSelf commonPushBack];
    }];
    [backButton setImage:[UIImage imageNamed:IMAGE_BACH_ICON_GRAY] forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIButton *closeButton = [self barButtonItemWithTitle:STRING_CLOSE buttonWidth:35 handler:hander];
    UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    UIBarButtonItem *leftFlexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftFlexSpacer.width = IMBarButtonLeftInset;
    self.navigationItem.leftBarButtonItems = @[leftFlexSpacer,backItem,closeItem];
}

- (void)createBackBarItemWithTitle:(NSString *)title
            rightButtonConfigBlock:(void(^)(UIButton *sender))buttonBlock
            rightBarItemClickBlock:(void(^)(id sender))block {
    
    [self createBackBarItemWithTitle:title];
    
    [self createNavigationWithTitle:title rightButtonConfigBlock:buttonBlock rightBarItemClickBlock:block];
}

- (void)createNavigationWithTitle:(NSString *)title
           rightButtonConfigBlock:(void(^)(UIButton *sender))buttonBlock
           rightBarItemClickBlock:(void(^)(id sender))block {
    [self addTitleToNavBar:title];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor textOrangeColor] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, IMRightItemButtonWidth, IMBackBarItemButtonHeight);
    if (buttonBlock) {
        buttonBlock(btn);
    }
    [btn bk_addEventHandler:block forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
                                                                               action:nil];
    flexSpacer.width = -5;
    
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItems = @[flexSpacer,backNavigationItem];
}

- (void)createNavigationWithTitle:(NSString *)title
                rightBarItemTitle:(NSString *)rightBarItemTitle
           rightBarItemClickBlock:(void(^)(id sender))block {
    [self createNavigationWithTitle:title rightButtonConfigBlock:^(UIButton *sender) {
        [sender setTitle:title forState:UIControlStateNormal];
    } rightBarItemClickBlock:block];
    
}

- (UIButton *)barButtonItemWithTitle:(NSString *)title
                         buttonWidth:(CGFloat)width
                             handler:(void(^)(id sender))handler
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, IMBackBarItemButtonHeight);
    btn.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    [btn bk_addEventHandler:^(id sender) {
        if (handler) {
            handler(sender);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIButton *)barButtonItemWithTitle:(NSString *)title
                           imageName:(NSString *)imageName
                         buttonWidth:(CGFloat)width
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, width, IMBackBarItemButtonHeight);
    btn.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    [btn setTitleColor:[UIColor textOrangeColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    return btn;
}

- (UIBarButtonItem *)createRightItemWithTitle:(NSString *)title target:(id)target action:(SEL)act
{
    NSDictionary *attri = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor whiteColor]};
    
    CGSize size = [title sizeWithAttributes:attri];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 0, size.width + 15, size.height + 15)];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor textOrangeColor] forState:UIControlStateNormal];
    [btn addTarget:target action:act forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    flexSpacer.width = -10;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItems = @[flexSpacer,item];
    
    return item;
}

- (UIBarButtonItem *)createToolBarItemWithTitle:(NSString *)title target:(id)target action:(SEL)act
{
    NSDictionary *attri = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
    CGSize size = [title sizeWithAttributes:attri];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setFrame:CGRectMake(0, 0, size.width + 15, size.height + 15)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:act forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}

- (UIButton *)createRightItemWithNormalImageName:(NSString *)imgN
                        selectedImageName:(NSString *)imgS
                                   target:(id)target
                                   action:(SEL)act
{
    UIImage *imageN = [UIImage imageNamed:imgN];
    UIImage *imageS = [UIImage imageNamed:imgS];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, IMRightItemButtonWidth, imageN.size.height + IMRightItemButtonWidthSpace);
    [btn setImage:imageN forState:UIControlStateNormal];
    [btn setImage:imageS forState:UIControlStateHighlighted];
    [btn setImage:imageS forState:UIControlStateSelected];
    [btn addTarget:target action:act forControlEvents:UIControlEventTouchUpInside];
    
//    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
//                                                                               target:self
//                                                                               action:nil];
//    flexSpacer.width = -10;
//    
//    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
//    
//    self.navigationItem.rightBarButtonItems = @[flexSpacer,backNavigationItem];
    
    /*隐藏导航栏下的分割线
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IMAGE_NAVGATION_BAR] forBarMetrics:UIBarMetricsDefault];
     */
    return btn;
}

- (void)createBarItemByImageName:(NSString*)imageName
                          title:(NSString*)title
                    buttonTitle:(NSString*)buttonTitle
                         target:(id)target
                         action:(SEL)action

{
    //左侧按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    btn.frame = CGRectMake(0, 0, IMBackBarItemButtonWidth, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:buttonTitle forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = IMBarButtonLeftInset;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];
    if (title && ![title isEqualToString:@""]) {
        [self addTitleToNavBar:title];
    }
}

- (void)createBackBarItem
{
    //左侧按钮
    UIImage *image = [UIImage imageNamed:IMAGE_BACH_ICON_GRAY];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, IMBackBarItemButtonWidth, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(commonPushBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:btn];

    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = IMBarButtonLeftInset;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, backNavigationItem];

}

- (void)setRightItemWithNormalImageName:(NSString *)imgN
                      selectedImageName:(NSString *)imgS
                                 target:(id)target
                                 action:(SEL)act
                                tipView:(UIView *)msgTipView
{
    UIImage *imageN = [UIImage imageNamed:imgN];
    UIImage *imageS = [UIImage imageNamed:imgS];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake(0, 0, IMRightItemButtonWidth, imageN.size.height + IMRightItemButtonWidthSpace);
    [btn setImage:imageN forState:UIControlStateNormal];
    [btn setImage:imageS forState:UIControlStateHighlighted];
    [btn setImage:imageS forState:UIControlStateSelected];
    [btn addTarget:target action:act forControlEvents:UIControlEventTouchUpInside];
    if (msgTipView) {
        [btn addSubview:msgTipView];
    }
    
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
                                                                               action:nil];
    flexSpacer.width = -10;
    
    UIBarButtonItem *backNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    self.navigationItem.rightBarButtonItems = @[flexSpacer,backNavigationItem];
}

- (void)createRightItemsWithNormalImageName1:(NSString *)imgN1
                          selectedImageName1:(NSString *)imgS1
                                     target1:(id)target1
                                     action1:(SEL)act1
                                    tipView1:(UIView *)msgTipView1
                                       Name2:(NSString *)imgN2
                          selectedImageName2:(NSString *)imgS2
                                     target2:(id)target2
                                     action2:(SEL)act2
                                    tipView2:(UIView *)msgTipView2
{
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
                                                                            action:nil];
    flexSpacer.width = -10;
    UIImage *imageN = [UIImage imageNamed:imgN1];
    UIImage *imageS = [UIImage imageNamed:imgS1];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, IMRightItemButtonWidth, imageN.size.height + IMRightItemButtonWidthSpace);
    [btn1 setImage:imageN forState:UIControlStateNormal];
    [btn1 setImage:imageS forState:UIControlStateHighlighted];
    [btn1 setImage:imageS forState:UIControlStateSelected];
    [btn1 addTarget:target1 action:act1 forControlEvents:UIControlEventTouchUpInside];
    if (msgTipView1) {
        [btn1 addSubview:msgTipView1];
    }
    UIImage *imageN2 = [UIImage imageNamed:imgN2];
    UIImage *imageS2 = [UIImage imageNamed:imgS2];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, IMRightShareItemButtonWidth, imageN2.size.height + IMRightItemButtonWidthSpace);
    [btn2 setImage:imageN2 forState:UIControlStateNormal];
    [btn2 setImage:imageS2 forState:UIControlStateHighlighted];
    [btn2 setImage:imageS2 forState:UIControlStateSelected];
    [btn2 addTarget:target2 action:act2 forControlEvents:UIControlEventTouchUpInside];
    if (msgTipView2) {
        [btn2 addSubview:msgTipView2];
    }
    UIBarButtonItem *backNavigationItem1 = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    UIBarButtonItem *backNavigationItem2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItems = @[flexSpacer,backNavigationItem2,backNavigationItem1];
}

- (void)createBarItemWithButtonTitle:(NSString*)buttonTitle
{
    UIBarButtonItem *backItem=[[UIBarButtonItem alloc] initWithTitle:buttonTitle style:UIBarButtonItemStylePlain target:self action:@selector(commonPushBack)];
    [backItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE], NSForegroundColorAttributeName : [UIColor textOrangeColor]} forState:UIControlStateNormal];
    [backItem setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE], NSForegroundColorAttributeName : [UIColor textOrangeColor]} forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)createLeftBarItemWithTitle:(NSString *)leftItemTitle
                 rightBarItemTitle:(NSString *)rightItemTitle
                             title:(NSString *)title
               LeftItemBlockHander:(void (^)(UIButton *))leftHander
              rightItemBlockHandle:(void (^)(UIButton *))rightHandle {
    
    //左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, IMBackBarItemButtonWidth, IMBackBarItemButtonHeight);
    [leftBtn setTitle:leftItemTitle forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, IMBarButtonTitleLeftInset, 0, 0)];
    [leftBtn setContentEdgeInsets:UIEdgeInsetsMake(0, IMBackBarItemButtonInsetTop, 0, 0)];
    [leftBtn bk_addEventHandler:^(id sender) {
        leftHander(sender);
    } forControlEvents:UIControlEventTouchUpInside];
    //右侧按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, IMBackBarItemButtonWidth, IMBackBarItemButtonHeight);
    [rightButton setTitle:rightItemTitle forState:UIControlStateNormal];
    rightButton.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    [rightButton setTitleColor:[UIColor textOrangeColor] forState:UIControlStateNormal];
    [rightButton setTitleEdgeInsets:UIEdgeInsetsMake(0, IMBarButtonTitleLeftInset, 0, 0)];
    [rightButton setContentEdgeInsets:UIEdgeInsetsMake(0, IMBackBarItemButtonInsetTop, 0, 0)];
    [rightButton bk_addEventHandler:^(id sender) {
        rightHandle(sender);
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    negativeSpacer.width = IMBarButtonLeftInset;
    self.navigationItem.leftBarButtonItems = @[negativeSpacer, leftBarItem];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightBarItem];
    
    if (title && title.length) {
        [self addTitleToNavBar:title];
    }
}

- (void)commonPushBack
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addTitleToNavBar:(NSString *)title
{
    self.navigationItem.title = title;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:FONT_OF_BOLD size:CUSTOME_FONT_SIZE + 2], NSFontAttributeName, [UIColor textBlack], NSForegroundColorAttributeName, nil];
    /*隐藏导航栏分割线
     */
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:UIColorFromHex(0xf6f6f6)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, NAV_BAR_HEIGHT - 20, SCREEN_WIDTH, UI_SINGLELINE)];
    line.backgroundColor = [UIColor seperateLineColor];
    [self.navigationController.navigationBar addSubview:line];
}

- (void)setNavigationBarTranslucent:(BOOL)translucent
{
    if (translucent) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
        self.navigationController.navigationBar.translucent = YES;
    } else {
        // 进入其他视图控制器
//        self.navigationController.navigationBar.tintColor = [UIColor lianjiaNavigationBarColor];
        self.navigationController.navigationBar.translucent = NO;
        self.navigationController.navigationBar.barTintColor = UIColorFromHex(0x2e313c);
//        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:IMAGE_NAVGATION_BAR] forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.shadowImage = [UIImage new];
    }
}

- (void)createRightBarItemByImageName:(NSString*)imageName
                              target:(id)target
                              action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    
    btn.frame = CGRectMake(0, 0, IMBackBarItemButtonWidth, image.size.height);
    [btn setImage:image forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, IMBarButtonTitleLeftInset, 0, 0)];
    [btn setContentEdgeInsets:UIEdgeInsetsMake(0, IMBackBarItemButtonInsetTop, 0, 0)];
    UIBarButtonItem *rightNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [self addRightBarButtonItem:rightNavigationItem];
}

- (void)addLeftBarButton:(UIButton *)leftBarButton
{
    leftBarButton.frame = CGRectMake(0, 0, IMBackBarItemButtonWidth, IMBackBarItemButtonHeight);
//    leftBarButton.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
//    leftBarButton.imageEdgeInsets = UIEdgeInsetsMake(0,-15, 0, 0);
//    [leftBarButton setTitleColor:[UIColor textOrangeColor] forState:UIControlStateNormal];

    UIBarButtonItem *leftNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarButton];
    [self addLeftBarButtonItem:leftNavigationItem];
}

- (void)addRightBarButton:(UIButton *)rigthBarButton
{
    rigthBarButton.frame = CGRectMake(0, 0, rigthBarButton.width, IMBackBarItemButtonHeight);
    rigthBarButton.titleLabel.font = [UIFont fontWithName:FONT_OF_NORMAL size:CUSTOME_FONT_SIZE];
    rigthBarButton.imageEdgeInsets = UIEdgeInsetsMake(0,-15, 0, 0);
    [rigthBarButton setTitleColor:[UIColor textOrangeColor] forState:UIControlStateNormal];

    UIBarButtonItem *rightNavigationItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBarButton];
    [self addRightBarButtonItem:rightNavigationItem];
}

- (void)addRightBarButtonItems:(NSArray *)rightBarButtonItems
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = [self spaceOffsetForRightButton];
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:5];
        [array addObject:negativeSpacer];
        [array addObjectsFromArray:rightBarButtonItems];
        
        [self.navigationItem setRightBarButtonItems:array animated:NO];
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self.navigationItem setRightBarButtonItems:rightBarButtonItems animated:NO];
    }
}

- (void)addLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = [self spaceOffsetForLeftButton];
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, leftBarButtonItem, nil] animated:NO];
    } else {
        // Just set the UIBarButtonItem as you would normally
//        [self.navigationItem setLeftBarButtonItem:leftBarButtonItem animated:NO];
        [self.navigationItem setLeftBarButtonItem:leftBarButtonItem animated:NO];
    }
}

- (void)addRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                           target:nil action:nil];
        negativeSpacer.width = [self spaceOffsetForRightButton];
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, rightBarButtonItem, nil] animated:NO];
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self.navigationItem setRightBarButtonItem:rightBarButtonItem animated:NO];
    }
}

- (void)addLeftBarButtonItems:(NSArray *)leftBarButtonItems
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        // Add a negative spacer on iOS >= 7.0
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                        target:nil action:nil];
        negativeSpacer.width = -10;
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:5];
        [array addObject:negativeSpacer];
        [array addObjectsFromArray:leftBarButtonItems];
        
        [self.navigationItem setLeftBarButtonItems:leftBarButtonItems animated:NO];
    } else {
        // Just set the UIBarButtonItem as you would normally
        [self.navigationItem setLeftBarButtonItems:leftBarButtonItems animated:NO];
    }
}

- (CGFloat)spaceOffsetForLeftButton
{
    BOOL iOS8 = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0);
    if (iOS8) {
        return IMBarButtonLeftInset;
    }
    return -10;
}

- (CGFloat)spaceOffsetForRightButton
{
    BOOL iOS8 = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0);
    if (iOS8) {
        return -14;
    }
    return -10;
}

@end
