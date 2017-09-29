//
//  ChartCurrentView.m
//  BrokenLineDemo
//
//  Created by wbx_iMac on 2017/9/28.
//  Copyright © 2017年 DaverZhou. All rights reserved.
//

#import "ChartCurrentView.h"

#define SCR_W(w) [UIScreen mainScreen].bounds.size.width/375 * w

@implementation ChartCurrentView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
        [self.layer setCornerRadius:4];
        [self.layer setMasksToBounds:YES];

        _incomeColor = _incomeColor ? _incomeColor : [UIColor redColor];
        
        _refundColor = _refundColor ? _refundColor : [UIColor greenColor];
        //标题
        _titleLabel = [self initlizaLabelWithFont:[UIFont systemFontOfSize:SCR_W(12)]];
        //收入
        _incomeView = [self initlizaViewWithColor:_incomeColor];
        
        _incomeLabel = [self initlizaLabelWithFont:[UIFont boldSystemFontOfSize:SCR_W(15)]];

        //退款
        _refundView = [self initlizaViewWithColor:_refundColor];
        
        _refundLabel = [self initlizaLabelWithFont:[UIFont boldSystemFontOfSize:SCR_W(15)]];
    }
    return self;
}
- (UILabel *)initlizaLabelWithFont:(UIFont *)font
{
    UILabel * label = [[UILabel alloc] init];
    [label setFont:font];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.preferredMaxLayoutWidth = SCR_W(90);
    [self addSubview:label];
    return label;
}
- (UIView *)initlizaViewWithColor:(UIColor *)color
{
    UIView * view = [[UIView alloc] init];
    [view setBackgroundColor:color];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:view];
    return view;
}
- (void)setChartCurrentDetailWithTime:(NSString *)time income:(NSString *)income refund:(NSString *)refund
{
    [_titleLabel setText:time];
    
    [_incomeLabel setText:[NSString stringWithFormat:@"收入%@",income]];
    
    [_refundLabel setText:[NSString stringWithFormat:@"退款%@",refund]];
}
- (void)setChartCurrentColorWithIncome:(UIColor *)income refund:(UIColor *)refund
{
    _incomeColor = income;
    
    [_incomeView setBackgroundColor:_incomeColor];
    
    _refundColor = refund;
    
    [_refundView setBackgroundColor:_refundColor];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    //标题
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant: SCR_W(12)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(12)]];
    //收入
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:SCR_W(20)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:- SCR_W(13)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(11)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(11)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_incomeView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_incomeView attribute:NSLayoutAttributeRight multiplier:1.0 constant: SCR_W(5)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_incomeLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(15)]];
    //退款
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:SCR_W(135)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:- SCR_W(13)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(11)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(11)]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_refundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_refundView attribute:NSLayoutAttributeRight multiplier:1.0 constant:SCR_W(5)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_refundLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(15)]];
    
}

@end
