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
#import "QPBusinessCooperationViewController.h"
#import "QPAboutUsViewController.h"
#import "QPMyBankCardViewController.h"
#import "QPLoginViewController.h"
#import "AppDelegate.h"
#import "QPSetUpViewController.h"
#import "QPStoreContractInformationViewController.h"
#import "QPUserModel.h"
#import "QPFileLocationManager.h"
#import "QPHttpManager.h"

static NSString *const cellIdentifier = @"QPUserCenterViewCell";
static NSString *const cellIdentifier1 = @"QPUserOneTableViewCell";
@interface QPUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) NSMutableArray * groups;
@property (nonatomic,strong) UITableView *homeTableView;

@end

@implementation QPUserCenterViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDataSource];
    [self configureTableView];
    //    [self createRightBarItemByImageName:@"barbuttonicon_set" target:self action:@selector(setbtnclick)];
    [self getLogo];
}
#pragma mark - configureSubViews
-(void)configureTableView
{
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.homeTableView.dataSource = self;
    self.homeTableView.backgroundColor = UIColorFromHex(0xf8f8f8);
    self.homeTableView.delegate = self;
    //    [self.homeTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.homeTableView.showsVerticalScrollIndicator = NO;
    [self.homeTableView registerClass:[QPUserCenterViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.homeTableView registerClass:[QPUserOneTableViewCell class] forCellReuseIdentifier:cellIdentifier1];
    
    [self.view addSubview:self.homeTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    XDGroupItem *group = self.groups[section];
    return group.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 90;
    } else {
        return 50;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        QPUserCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        XDGroupItem *group = self.groups[indexPath.section];
        XDSettingItem *item = group.items[indexPath.row];
        cell.textLabel.text = item.title;
        UILabel *QRcode =[[UILabel new]init];
        QRcode.font = [UIFont systemFontOfSize:12];
        QRcode.frame = CGRectMake(100, 60, 150, 20);
        QPUserModel *userModel = [QPUserCenterViewController getUserModel];
        QRcode.text = userModel.arena_phone;
        [cell.contentView addSubview:QRcode];
        cell.imageView.image = [UIImage imageNamed:item.image];
        return cell;
    } else {
        QPUserOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        XDGroupItem *group = self.groups[indexPath.section];
        XDSettingItem *item = group.items[indexPath.row];
        cell.textLabel.text = item.title;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.layer.cornerRadius = 8;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.image = [UIImage imageNamed:item.image];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 70;
    }else {
        return 9.0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 10.0;
    } else {
        return CGFLOAT_MIN;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 3) {
        UIView *view = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, SCREEN_WIDTH, 0))];
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

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                UIActionSheet *action = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"相册", nil];
                [action showInView:self.view];
                
                NSLog(@"个人信息");
            }
            break;
        case 1:
            if (indexPath.row == 0) {
                QPMyBankCardViewController *QPcardVC = [[QPMyBankCardViewController alloc]init];
                [self.navigationController pushViewController:QPcardVC animated:YES];
                NSLog(@"我的银行卡");
            } else if (indexPath.row == 1) {
                QPStoreContractInformationViewController *QPstoreinfoVC = [[QPStoreContractInformationViewController alloc]init];
                [self.navigationController pushViewController:QPstoreinfoVC animated:YES];
                NSLog(@"店铺签的结算");
            }
            break;
        case 2:
            if (indexPath.row == 0) {
                QPBusinessCooperationViewController *QPbuscooVC = [[QPBusinessCooperationViewController alloc]init];
                [self.navigationController pushViewController:QPbuscooVC animated:YES];
                NSLog(@"商务合作");
            } else if (indexPath.row == 1){
                UIAlertView *phoneAlert = [[UIAlertView alloc]initWithTitle:@"15701189832" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
                phoneAlert.tag = 80;
                [phoneAlert show];
                NSLog(@"客户中心");
            }
            break;
        case 3:
            if (indexPath.row == 0) {
                QPAboutUsViewController *QPaboutusVC = [[QPAboutUsViewController alloc]init];
                [self.navigationController pushViewController:QPaboutusVC animated:YES];
                NSLog(@"关于我们");
            } else if (indexPath.row == 1) {
                QPSetUpViewController *QPsetupVC = [[QPSetUpViewController alloc]init];
                [self.navigationController pushViewController:QPsetupVC animated:YES];
                NSLog(@"设置");
            }
            break;
            
        case 4:
            NSLog(@"退出登录");
            break;
        default:
            break;
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *camera = [[UIImagePickerController alloc]init];
            
            //调用相机
            camera.sourceType = UIImagePickerControllerSourceTypeCamera;
            camera.allowsEditing = YES;
            //            camera.delegate = self;
            [self presentViewController:camera animated:YES completion:nil];
        }
    }else if (buttonIndex == 1){
        UIImagePickerController *photoLibrary = [[UIImagePickerController alloc]init];
        //设置图片来源于相册
        photoLibrary.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        photoLibrary.allowsEditing = YES;
        //        photoLibrary.delegate = self;
        [self presentViewController:photoLibrary animated:YES completion:nil];
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //判断选中的媒体是否为图片
    
    UIImage *imageNew = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    //设置image的尺寸
    CGSize imagesize = imageNew.size;
    imagesize.height = 200;
    imagesize.width = 200;
    //对图片大小进行压缩--
    imageNew = [self imageWithImage:imageNew scaledToSize:imagesize];
    
    //        NSData *imageData = UIImageJPEGRepresentation(info[UIImagePickerControllerEditedImage], 0.00001);
    //        NSData *imageData = UIImageJPEGRepresentation(imageNew, 0.00001);
    //        NSData *imageData = UIImagePNGRepresentation(imageNew);
    //        NSString *photoData = [imageData base64EncodedStringWithOptions:0];
    
    //        NSData *data = [[NSData alloc]initWithBase64EncodedString:photoData options:NSDataBase64DecodingIgnoreUnknownCharacters];
    //        UIImage *ima = [[UIImage alloc]initWithData:data];
    //#warning test
    //        self.userPhoto(ima);
    
    //        NSLog(@"%@", _head_thumb);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//对图片尺寸进行压缩--
-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 80){
        if (buttonIndex == 1) {
            if(![[UIApplication sharedApplication]openURL:[NSURL URLWithString:QP_TEL]] ){
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"设备不支持" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil] ;
                [alert show] ;
            }
        }
    }
}

- (void)exitRegister {
    [LGLAlertView showAlertViewWith:self title:@"温馨提示" message:@"确定退出" CallBackBlock:^(NSInteger btnIndex) {
        if (btnIndex == 0) {
            
        } else {
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            QPLoginViewController *loginVC = [QPLoginViewController new];
            delegate.window.rootViewController = loginVC;
        }
    } cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil,nil];
}

-(NSMutableArray *)groups {
    if (!_groups) {
        _groups = [[NSMutableArray alloc]init];
    }
    return _groups;
}

-(void)loadDataSource {
    
    [self setGroupsOne];
    [self setGroupsTwo];
    [self setGroupsThree];
    [self setGroupsFour];
}

- (void)setGroupsOne {
    
    XDGroupItem *group = [[XDGroupItem alloc]init];
    QPUserModel *userModel = [QPUserCenterViewController getUserModel];
    XDSettingItem *item = [XDSettingItem itemWithtitle:userModel.arena_name :@"geren_touxiang"];
    group.items = @[item];
    [self.groups addObject:group];
}
- (void)setGroupsTwo {
    
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"我的银行卡" :@"Credit-Card"];
    //    XDSettingItem *itemOne = [XDSettingItem itemWithtitle:@"更换银行卡" :@"pir_3"];
    XDSettingItem *itemTwo = [XDSettingItem itemWithtitle:@"店铺签的结算" :@"Paper-Dollars-1"];
    group.items = @[item,itemTwo];
    [self.groups addObject:group];
}
- (void)setGroupsThree {
    
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"商务合作" :@"Users-2"];
    XDSettingItem *itemOne = [XDSettingItem itemWithtitle:@"客服中心" :@"kefu"];
    group.items = @[item,itemOne];
    [self.groups addObject:group];
}
- (void)setGroupsFour {
    
    XDGroupItem *group = [[XDGroupItem alloc]init];
    XDSettingItem *item = [XDSettingItem itemWithtitle:@"关于我们" :@"Info"];
    XDSettingItem *itemOne = [XDSettingItem itemWithtitle:@"设    置" :@"shezhi"];
    group.items = @[item,itemOne];
    [self.groups addObject:group];
}

+ (QPUserModel*)getUserModel{
    
    NSString *path = [QPFileLocationManager getUserDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:@"merInfo.data"];
    NSMutableArray *merInfolist = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return merInfolist[0];
}

- (void)getLogo{
    
    [QPHttpManager getLogo:^(id responseData) {
        
    }failure:^(NSError *error) {
        
    }];
}

@end
