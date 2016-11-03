//
//  TabBarController.m
//  QuickPay
//
//  Created by Nie on 2016/8/14.
//  Copyright © 2016年 Nie. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"

static NSString * const HomePageVC = @"QPHomePageViewController";
static NSString * const NewsVC = @"QPNewsViewController";
//static NSString * const FindVC = @"QPFindViewController";
static NSString * const ProfileVC = @"QPUserCenterViewController";
//static NSString * const MemberVC = @"QPMemberViewController";


static NSString * const TabbarTitle = @"TabbarTitle";
static NSString * const TabbarImage = @"TabbarImage";
static NSString * const TabbarSelectedImage = @"TabbarSelectedImage";
static NSString * const TabbarItemBadgeValue = @"TabbarItemBadgeValue";


@interface TabBarController ()

@property (nonatomic, strong) NSArray *vcsOrder;
@property (nonatomic, strong) NSDictionary *vcsInfoDict;

@end

@implementation TabBarController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupSubVCs];
}

#pragma mark - setupSubVCs

- (void)setupSubVCs {
    
    [self.vcsOrder enumerateObjectsUsingBlock:^(id  _Nonnull vcName, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *vcInfo = [self.vcsInfoDict objectForKey:vcName];
        
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [clazz new];
        vc.title = vcInfo[TabbarTitle];
        vc.tabBarItem.image = [[UIImage imageNamed:vcInfo[TabbarImage]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
        UIImage *selectedImage = [[UIImage imageNamed:vcInfo[TabbarSelectedImage]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = selectedImage;
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#9b9db1"],
                                                NSFontAttributeName : [UIFont mis_tinyFont]}
                                     forState:UIControlStateNormal];
        
        [vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor orangeColor]}
                                     forState:UIControlStateSelected];
//        NSInteger badge = [vcInfo[TabbarItemBadgeValue] integerValue];

        NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
//        nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)badge];
        [self addChildViewController:nav];
    }];
}

#pragma getters / setters

- (NSArray *)vcsOrder {
    
    return @[HomePageVC, NewsVC,ProfileVC];
}

- (NSDictionary *)vcsInfoDict {
    
    return @{HomePageVC : @{
                     TabbarTitle        : @"首页",
                     TabbarImage        : @"shouye_nor",
                     TabbarSelectedImage: @"shouye_pre",
                     TabbarItemBadgeValue: @(0)
                     },
//             MemberVC : @{
//                     TabbarTitle        : @"会员",
//                     TabbarImage        : @"huiyuan_nor",
//                     TabbarSelectedImage: @"huiyuan_pre",
//                     TabbarItemBadgeValue: @(0)
//                     },
//             FindVC : @{
//                     TabbarTitle        : @"发现",
//                     TabbarImage        : @"faxian_nor",
//                     TabbarSelectedImage: @"faxian_pre",
//                     TabbarItemBadgeValue: @(0)
//                     },
             NewsVC : @{
                     TabbarTitle        : @"消息",
                     TabbarImage        : @"mail_nor",
                     TabbarSelectedImage: @"mail_pre",
                     TabbarItemBadgeValue: @(0)
                     },

             ProfileVC : @{
                     TabbarTitle        : @"我的",
                     TabbarImage        : @"geren_nor",
                     TabbarSelectedImage: @"geren_pre",
                     TabbarItemBadgeValue: @(0)
                     }};
}

@end
