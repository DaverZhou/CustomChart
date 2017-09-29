//
//  CustomChartView.h
//  BrokenLineDemo
//
//  Created by wbx_iMac on 2017/9/28.
//  Copyright © 2017年 DaverZhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartCurrentView.h"

#define Color_Bg [UIColor colorWithRed:242/255.0 green:247/255.0 blue:249/255.0 alpha:1]

#define Color_Line [UIColor colorWithRed:231/255.0 green:241/255.0 blue:245/255.0 alpha:1]

#define SCR_W(w) [UIScreen mainScreen].bounds.size.width/375 * w

@interface CustomChartView : UIView
/**
 列数
 */
@property (nonatomic, assign) int column;
/**
 列宽度
 */
@property (nonatomic, assign) CGFloat columnWidth;
/**
 列数
 */
@property (nonatomic, assign) int current;
/**
 y轴最高点
 */
@property (nonatomic, assign) CGFloat maxPoint;
/**
 比例
 */
@property (nonatomic, assign) CGFloat scale;
/**
 选中当前线
 */
@property (nonatomic, strong) UIView * lineView;
/**
 开始日期
 */
@property (nonatomic, strong) UILabel * startLabel;
/**
 结束日期
 */
@property (nonatomic, strong) UILabel * endLabel;
/**
 收入颜色
 */
@property (nonatomic, strong) UIColor * incomeColor;
/**
 退款颜色
 */
@property (nonatomic, strong) UIColor * refundColor;
/**
 收入数据
 */
@property (nonatomic, strong) NSArray * incomeAry;
/**
 退款数据
 */
@property (nonatomic, strong) NSArray * refundAry;
/**
 日期
 */
@property (nonatomic, strong) NSArray * timeAry;

@property (nonatomic, strong) ChartCurrentView * currentView;

/**
 初始化

 @param frame frame
 @param incomeColor 收入折线颜色
 @param incomeAry 收入数据
 @param refundColor 退款颜色
 @param refundAry 退款数据
 @param maxCount 最大值，退款、收入数据中某一天的最大值
 @param timeAry 日期数据
 @return 初始化
 */
+ (instancetype)initializeWithFrame:(CGRect)frame incomeColor:(UIColor *)incomeColor incomeData:(NSArray *)incomeAry refundColor:(UIColor *)refundColor refundData:(NSArray *)refundAry maxCount:(CGFloat)maxCount timeData:(NSArray *)timeAry;
/**
 设置相关折线

 @param incomeColor 收入折线颜色
 @param incomeAry 收入数据
 @param refundColor 退款折线颜色
 @param refundAry 退款数据
 @param maxCount 最大值，退款、收入数据中某一天的最大值
 @param timeAry 日期数据
 */
- (void)setCustomChartWithIncomeColor:(UIColor *)incomeColor incomeData:(NSArray *)incomeAry refundColor:(UIColor *)refundColor refundData:(NSArray *)refundAry maxCount:(CGFloat)maxCount timeData:(NSArray *)timeAry;

@end
