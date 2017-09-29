//
//  ChartCurrentView.h
//  BrokenLineDemo
//
//  Created by wbx_iMac on 2017/9/28.
//  Copyright © 2017年 DaverZhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartCurrentView : UIView
//日期
@property (nonatomic, strong) UILabel * titleLabel;
//收入
@property (nonatomic, strong) UIView * incomeView;

@property (nonatomic, strong) UILabel * incomeLabel;

@property (nonatomic, strong) UIColor * incomeColor;
//退款
@property (nonatomic, strong) UIView * refundView;

@property (nonatomic, strong) UILabel * refundLabel;

@property (nonatomic, strong) UIColor * refundColor;

/**
 设置详细信息

 @param time 标题日期
 @param income 收入
 @param refund 退款
 */
- (void)setChartCurrentDetailWithTime:(NSString *)time income:(NSString *)income refund:(NSString *)refund;
/**
 设置颜色

 @param income 收入
 @param refund 退款
 */
- (void)setChartCurrentColorWithIncome:(UIColor *)income refund:(UIColor *)refund;
@end
