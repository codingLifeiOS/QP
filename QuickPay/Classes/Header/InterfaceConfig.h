//
//  InterfaceConfig.h
//  QuickPay
//
//  Created by Nie on 16/9/5.
//  Copyright © 2016年 Nie All rights reserved.
//

#ifndef InterfaceConfig_h
#define InterfaceConfig_h
// 接口服务器
#define QP_HOST @"http://mobile.rrgpay.com/"

// 2.1.支付下单接口 生成二维码字符串
#define QP_OrderCP QP_HOST@"order/api/cp"

// 2.3.	交易查询接口
#define QP_OrderQQ QP_HOST@"order/api/qq"

// 2.4. 登录接口
#define QP_Login QP_HOST@"apis/login"

// 2.5. 获取商户基本信息
#define QP_GetMerInfo QP_HOST@"apis/getMerinfo"

#endif /* InterfaceConfig_h */
