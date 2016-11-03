//
//  QPUserCenterViewController.m
//  QuickPay
//
//  Created by Nie on 2016/10/21.
//  Copyright © 2016年 Nie. All rights reserved.
//
//
#import "QPUserCenterViewController.h"
#import "QPUserCenterViewCell.h"
#import "QPUserOneTableViewCell.h"
#import "XDGroupItem.h"
#import "XDSettingItem.h"
#import "LGLAlertView.h"

@interface QPUserCenterViewController ()
@property (strong, nonatomic) NSMutableArray * groups;/**< 组数组 描述TableView有多少组 */
@end

@implementation QPUserCenterViewController
//让groups进行懒加载
-(NSMutableArray *)groups {
    if (!_groups) {
        _groups = [[NSMutableArray alloc]init];
    }
    return _groups;
}
-(instancetype)init {
    /***设置tableView的样式***/
    return [self initWithStyle:(UITableViewStyleGrouped)];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadComponent];
}
/**
 * 加载组件
 **/
-(void)loadComponent {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self loadUIComponent];
    [self loadDataSource];
}
/**
 * 加载UI组件
 **/
-(void)loadUIComponent {
    //设置Button
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:(UIBarButtonItemStylePlain) target:self action:@selector(PersonalSettings)];
    anotherButton.tintColor = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    //背景图片
    UIImageView *imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gerenzhongxin_bj"]];
    imageView.image=[UIImage imageNamed:@"gerenzhongxin_bj"];
    [self.tableView setBackgroundView:imageView];
}
/**
 * 加载数据源
 **/
-(void)loadDataSource {
    
    [self setGroupsOne];
}
/**
 *  设置
 **/
-(void)PersonalSettings {
    NSLog(@"设置");
}
/**
 *  退出账户
 **/
-(void)exitRegister {
    [LGLAlertView showAlertViewWith:self title:@"温馨提示" message:@"确定退出" CallBackBlock:^(NSInteger btnIndex) {
        if (btnIndex == 0) {
            NSLog(@"取消退出");
        }else {
            NSLog(@"确定退出");
        }
    } cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil,nil];
}
-(void)setGroupsOne {
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"凄清肆水丶" :@"hxp"];
    group.items = @[item];
    [self.groups addObject:group];
    [self setGroupsTwo];
}
-(void)setGroupsTwo {
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"我的银行卡" :@"pir_2"];
    XDSettingItem *itemOne = [XDSettingItem itemWithtitle:@"更换银行卡" :@"pir_3"];
    XDSettingItem *itemTwo = [XDSettingItem itemWithtitle:@"店铺签的结算" :@"pir_4"];
    group.items = @[item,itemOne,itemTwo];
    [self.groups addObject:group];
    [self setGroupsThree];
}
-(void)setGroupsThree {
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"商务合作" :@"pir_5"];
    XDSettingItem *itemOne = [XDSettingItem itemWithtitle:@"用户协议" :@"pir_6"];
    group.items = @[item,itemOne];
    [self.groups addObject:group];
    [self setGroupsFour];
}
-(void)setGroupsFour {
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"关于我们" :@"pir_7"];
    group.items = @[item];
    [self.groups addObject:group];
}


#pragma mark - tableView delegate and datasoure

/**
 *  返回有多少组的代理方法
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}
/**
 *  返回每组有多少行的代理方法
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XDGroupItem *group = self.groups[section];
    return group.items.count;
}

/**
 * 返回每行高度
 */
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    }else {
        return 50;
    }
}
/**
 *  返回每一行Cell的代理方法
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    static NSString *ID1 = @"cell1";
    QPUserCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    QPUserOneTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        if (indexPath.section == 0) {
            cell  = [[QPUserCenterViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        } else {
            cell1 = [[QPUserOneTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ID1];
        }
    }
    
    if (indexPath.section == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        XDGroupItem *group = self.groups[indexPath.section];
        XDSettingItem *item = group.items[indexPath.row];
        cell.textLabel.text = item.title;
        UILabel *QRcode =[[UILabel new]init];
        QRcode.font = [UIFont systemFontOfSize:12];
        QRcode.frame = CGRectMake(100, 60, 150, 20);
        QRcode.text = @"ID: 7758";
        QRcode.backgroundColor = [UIColor clearColor];
        [self.view addSubview:QRcode];
        cell.imageView.image = [UIImage imageNamed:item.image];
        return cell;
    }else {
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        XDGroupItem *group = self.groups[indexPath.section];
        XDSettingItem *item = group.items[indexPath.row];
        cell1.textLabel.text = item.title;
        cell1.textLabel.font = [UIFont systemFontOfSize:14];
        cell1.imageView.layer.cornerRadius = 8;
        cell1.imageView.layer.masksToBounds = YES;
        cell1.imageView.image = [UIImage imageNamed:item.image];
        return cell1;
    }
    
}
/**
 *  cell
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                NSLog(@"个人信息");
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                NSLog(@"我的银行卡");
            }else if (indexPath.row == 1) {
                NSLog(@"更换银行卡");
            }else if (indexPath.row == 2) {
                NSLog(@"店铺签的结算");
            }
            break;
        case 2:if (indexPath.row == 0) {
            NSLog(@"商务合作");
        }else if (indexPath.row == 1){
            NSLog(@"用户协议");
        }
            break;
        case 3:
            NSLog(@"关于我们");
            break;
        case 4:
            NSLog(@"退出登录");
            break;
        default:
            break;
    }
    
}
/**
 *  页脚
 */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 70;
    }else {
        return 9.0;
    }
}
/**
 *  页头
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0;
    }else  {
        return 1.0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(self.view.left, 0, SCREEN_WIDTH, 0))];
        view.backgroundColor = [UIColor clearColor];
        UIButton *exitButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, SCREEN_WIDTH-30, 50)];
        [exitButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
        [exitButton setBackgroundImage:[UIImage imageNamed:@"guanyuwom_bj"] forState:UIControlStateNormal];
        exitButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [exitButton setTitleColor:[UIColor colorWithRed:185/255.0 green:0/255.0 blue:0/255.0 alpha:1] forState:UIControlStateNormal];
        [exitButton addTarget:self action:@selector(exitRegister) forControlEvents:(UIControlEventTouchUpInside)];
        [view addSubview:exitButton];
        return view;
    }
    return nil;
}

@end
