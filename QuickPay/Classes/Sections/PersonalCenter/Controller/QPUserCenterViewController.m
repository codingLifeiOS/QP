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
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>


static NSString *const cellIdentifier = @"QPUserCenterViewCell";
static NSString *const cellIdentifier1 = @"QPUserOneTableViewCell";
@interface QPUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
     QPUserModel *userModel;
     UIImage *iconImage;//拍照或者从相册选照片
}
@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) NSArray *myTittleArry;
@property (nonatomic,strong) NSArray *myImageArry;

@end

@implementation QPUserCenterViewController

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTableView];
    
     self.myTittleArry = @[@[@"我的银行卡",@"店铺签的结算"],@[@"商务合作",@"客服中心"],@[@"关于我们",@"设    置"]];
     self.myImageArry =@[@[@"Credit-Card",@"Paper-Dollars-1"],@[@"Users-2",@"kefu"],@[@"guanyuwom",@"shezhi"]];
    
    userModel = [QPUserCenterViewController getUserModel];
    //    [self createRightBarItemByImageName:@"barbuttonicon_set" target:self action:@selector(setbtnclick)];
}
#pragma mark - configureSubViews
-(void)configureTableView
{
    self.homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    self.homeTableView.dataSource = self;
    self.homeTableView.backgroundColor = UIColorFromHex(0xf8f8f8);
    self.homeTableView.delegate = self;
    self.homeTableView.showsVerticalScrollIndicator = NO;
    [self.homeTableView registerClass:[QPUserCenterViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.homeTableView registerClass:[QPUserOneTableViewCell class] forCellReuseIdentifier:cellIdentifier1];
    [self.view addSubview:self.homeTableView];
    [self.homeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 ) {
        return 1;
    } else {
        return 2;
    }
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
        cell.nameLab.text = userModel.arena_name;
        cell.phoneLab.text = userModel.arena_phone;
        NSString *path = [NSString stringWithFormat:@"%@/%@",QP_GetLogo,[QPUtils getMer_code]];
        cell.headimage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:path]]];
        
        return cell;
    } else {
        QPUserOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = self.myTittleArry[indexPath.section-1][indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.imageView.layer.cornerRadius = 8;
        cell.imageView.layer.masksToBounds = YES;
        cell.imageView.image = [UIImage imageNamed:self.myImageArry[indexPath.section-1][indexPath.row]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 3) {
        return 70;
    } else {
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
               [self changeIconClick];
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
                UIAlertView *phoneAlert = [[UIAlertView alloc]initWithTitle:@"010-53385758" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
                phoneAlert.tag = 81;
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

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (actionSheet.tag == 80) {
        [self showImagePicker:buttonIndex];
    }
}

-(void)showImagePicker:(NSInteger)type
{
    NSDictionary *appInfo = [[NSBundle mainBundle] infoDictionary];
    NSString *appName = [appInfo objectForKey:@"CFBundleDisplayName"];
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if (type == 1) {
        ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
        if (author == ALAuthorizationStatusRestricted || author == AVAuthorizationStatusDenied){
            [[QPHUDManager sharedInstance] showTextOnly:@"相册未授权" onView:self.view];
        }else if (author == ALAuthorizationStatusAuthorized) {
            //默认只采用照片库
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:NULL];
        }else if (author == ALAuthorizationStatusNotDetermined) {
            
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupLibrary usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if (*stop) {
                    //点击“好”回调方法:
                    NSLog(@"好");
                    return;
                }
                *stop = TRUE;
                
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
                imagePicker.delegate = self;
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [self presentViewController:imagePicker animated:YES completion:NULL];
                
            } failureBlock:^(NSError *error) {
                
                //点击“不允许”回调方法:
                NSLog(@"不允许");
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }];
        }
        
    } else if (type == 0){
        
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] || authStatus == AVAuthorizationStatusRestricted || authStatus ==AVAuthorizationStatusDenied) {
            [self showAlertWithMessage:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-照片”选项中，允许%@访问你的照片。", appName]];
        }else if (AVAuthorizationStatusNotDetermined == authStatus) {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if(granted){
                        [self imagePickerController];
                    } else {
                        [self showAlertWithMessage:[NSString stringWithFormat:@"请在iPhone的“设置-隐私-相机”选项中，允许%@访问你的相机。", appName]];
                    }
                });
            }];
            
        }else {
            [self imagePickerController];
        }
    }
}

- (void)showAlertWithMessage:(NSString *)message {
   QPAlertView *alert = [[QPAlertView alloc]initWithTitle:@"相机不可用，或未授权" message:message delegate:nil cancelButtonTitle:@"好" otherButtonTitle:nil];
    [alert show];
}

- (UIImagePickerController *)imagePickerController {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
    return imagePicker;
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationItem.titleView.tintColor=[UIColor whiteColor];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor blackColor];
    viewController.navigationController.navigationBar.barTintColor= [UIColor mis_backgroundColor];
    [viewController.navigationItem setHidesBackButton:YES];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [viewController.navigationItem setHidesBackButton:YES];
    
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *headImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    headImage = [UIImage fixOrientation:headImage];
    iconImage = headImage;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    QPUserCenterViewCell *cell = [self.homeTableView cellForRowAtIndexPath:indexPath];
    cell.headimage.image = headImage;
    [self dismissViewControllerAnimated:YES completion:nil];
    [self UpdateUserInforHeadImage];
}

//取消照相机的回调
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:^{}];
}
//保存照片成功后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    NSLog(@"saved..");
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 81){
        if (buttonIndex == 1) {
            if(![[UIApplication sharedApplication]openURL:[NSURL URLWithString:QP_TEL]] ){
                [[QPHUDManager sharedInstance]showTextOnly:@"设备不支持"];
            }
        }
    }
}

- (void)exitRegister {
    [LGLAlertView showAlertViewWith:self title:@"温馨提示" message:@"退出登录" CallBackBlock:^(NSInteger btnIndex) {
        if (btnIndex == 1) {
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            QPLoginViewController *loginVC = [QPLoginViewController new];
            delegate.window.rootViewController = loginVC;
        } else {
            
        }
    } cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:nil,nil];
}

//上传头像
-(void)UpdateUserInforHeadImage
{
   
    [[QPHUDManager sharedInstance]showProgressWithText:@"正在上传头像"];
    [QPHttpManager uploadImage:iconImage Completion:^(id responseData) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        
        [self changeLogoWithPath:[responseData objectForKey:@"path"]];
        
    } failure:^(NSError *error) {
        
        [[QPHUDManager sharedInstance]hiddenHUD];
        
        [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
    }];
    

     
}

- (void)changeLogoWithPath:(NSString*)path{
    
    if ([NSString isNotBlank:path]) {
        [QPHttpManager changeLogoWithUrl:path Completion:^(id responseData) {
            [[QPHUDManager sharedInstance]showTextOnly:[responseData objectForKey:@"resp_msg"]];
        } failure:^(NSError *error) {
            
            [[QPHUDManager sharedInstance]showTextOnly:error.localizedDescription];
        }];
    }
}

-(void)changeIconClick
{
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"从相册选择", nil];
    sheet.tag = 80;
    [sheet showInView:self.view];
}
+ (QPUserModel*)getUserModel{
    
    NSString *path = [QPFileLocationManager getUserDirectory];
    NSString *filePath = [path stringByAppendingPathComponent:@"merInfo.data"];
    NSMutableArray *merInfolist = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return merInfolist[0];
}

@end
