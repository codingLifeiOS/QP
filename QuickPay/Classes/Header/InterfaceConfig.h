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

// 2.1. 登录接口
#define QP_Login QP_HOST@"apis/login"

// 2.2. 获取商户基本信息
#define QP_GetMerInfo QP_HOST@"apis/getMerinfo"

// 2.3. 修改密码
#define QP_Modify_Password QP_HOST@"apis/modify_password"

// 2.4. 获取绑定银行卡
#define QP_GetBind_bank_Card QP_HOST@"apis/getBind_bank_card"

// 2.5. 获取到账记录
#define QP_GetSettlement_Records QP_HOST@"apis/getSettlement_records"

// 2.6. 获取交易流水
#define QP_GetOrder_Records QP_HOST@"apis/getOrder_records"

// 2.7. 获取商户固定二维码
#define QP_GetFixedQR QP_HOST@"apis/getFixedQR"

// 2.8. 动态二维码支付下单接口(正扫)
#define QP_Create_Order QP_HOST@"apis/create_order"

// 2.9. 刷卡支付接口(反扫)
#define QP_Create_Order_ReverseScan QP_HOST@"apis/create_order"

// 3.0. 支付结果查询接口
#define QP_Qrder_Query QP_HOST@"apis/order_query"

#endif /* InterfaceConfig_h */
