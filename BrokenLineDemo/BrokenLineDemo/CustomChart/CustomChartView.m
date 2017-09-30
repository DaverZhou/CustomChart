//
//  CustomChartView.m
//  BrokenLineDemo
//
//  Created by wbx_iMac on 2017/9/28.
//  Copyright © 2017年 DaverZhou. All rights reserved.
//

#import "CustomChartView.h"

@implementation CustomChartView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //选中线
        _lineView = [[UIView alloc] init];
        [_lineView setBackgroundColor:[UIColor blueColor]];
        _lineView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:_lineView];
        //开始日期
        _startLabel = [self initlizaLabel];

        //结束日期
        _endLabel = [self initlizaLabel];
        
        //详细信息
        _currentView = [[ChartCurrentView alloc] init];
        _currentView.translatesAutoresizingMaskIntoConstraints = NO;
        [self insertSubview:self.currentView aboveSubview:_lineView];

    }
    return self;
}
+ (instancetype)initializeWithFrame:(CGRect)frame incomeColor:(UIColor *)incomeColor incomeData:(NSArray *)incomeAry refundColor:(UIColor *)refundColor refundData:(NSArray *)refundAry maxCount:(CGFloat)maxCount timeData:(NSArray *)timeAry
{
    CustomChartView * customChart = [[CustomChartView alloc] initWithFrame:frame];
    
    [customChart setCustomChartWithIncomeColor:incomeColor incomeData:incomeAry refundColor:refundColor refundData:refundAry maxCount:maxCount timeData:timeAry];
    
    return customChart;
}

- (UILabel *)initlizaLabel
{
    UILabel * label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [label setFont:[UIFont boldSystemFontOfSize:SCR_W(12)]];
    [label setTextColor:[UIColor blackColor]];
    [self addSubview:label];
    return label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取触摸对象
    UITouch * touch = touches.anyObject;
    //返回触摸点在视图中的当前坐标
    CGPoint point = [touch locationInView:[touch view]];
    
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake([self nearBy:point.x], 0, 1, SCR_W(280))];
        
        [self layoutIfNeeded];
        
        _current = _current > _column - 1 ? _column - 1 : _current;
        
        [_currentView setChartCurrentDetailWithTime:_timeAry[_current] income:_incomeAry[_current] refund:_refundAry[_current]];
    }];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    //获取触摸对象
    UITouch * touch = touches.anyObject;
    
    //返回触摸点在视图中的当前坐标
    CGPoint point = [touch locationInView:[touch view]];

    
    [UIView animateWithDuration:0.25 animations:^{
        [_lineView setFrame:CGRectMake([self nearBy:point.x], 0, 1, SCR_W(280))];

        _current = _current > _column -1 ? _column -1 : _current;

        [_currentView setChartCurrentDetailWithTime:_timeAry[_current] income:_incomeAry[_current] refund:_refundAry[_current]];
    }];
}

- (CGFloat)nearBy:(CGFloat)pointX
{
    //超出边距
    if (pointX > _columnWidth * (_column - 1) + SCR_W(10)) {
        
        _current = _column - 1;
        
        return _current * _columnWidth + SCR_W(10);
    }
    //当前位置在第几个
    int tmpX  = pointX /(_columnWidth);
    //判断距离那边近
    CGFloat currentX = pointX - tmpX * (_columnWidth);
    
    _current = currentX - _columnWidth/2 > 0 ? tmpX + 1 : tmpX;
    
    return  _current * _columnWidth + SCR_W(10);
}


- (void)setCustomChartWithIncomeColor:(UIColor *)incomeColor incomeData:(NSArray *)incomeAry refundColor:(UIColor *)refundColor refundData:(NSArray *)refundAry maxCount:(CGFloat)maxCount timeData:(NSArray *)timeAry
{
    _maxPoint = maxCount + maxCount / 5;
    
    _incomeColor = incomeColor;
    
    _incomeAry = incomeAry;
    
    _refundColor = refundColor;
    
    _refundAry = refundAry;
    
    _timeAry = timeAry;
    
    _column = (int)incomeAry.count;
    
    _scale = SCR_W(234) / _maxPoint;
    
    _columnWidth = SCR_W(355)/(_column - 1);
    
    _current = 0;
    //头、尾日期
    [_startLabel setText:_timeAry.firstObject];
    
    [_endLabel setText:_timeAry.lastObject];
    //对应日期详细信息
    [_currentView setChartCurrentColorWithIncome:incomeColor refund:refundColor];

    [_currentView setChartCurrentDetailWithTime:_timeAry[_current] income:_incomeAry[_current] refund:_refundAry[_current]];
    //画线
    [self drawLineWithCuttingLineCount:_column];
    
    [self drawLineWithBrokenLintData:_incomeAry lineColor:_incomeColor];
    
    [self drawLineWithBrokenLintData:_refundAry lineColor:_refundColor];
}
- (void)drawLineWithCuttingLineCount:(int)count
{
    if (count == 0) {
        return;
    }
    CAShapeLayer * cutLayer = [CAShapeLayer layer];
    cutLayer.frame = self.bounds;
    cutLayer.fillColor = [UIColor clearColor].CGColor;
    cutLayer.lineWidth = 1;
    cutLayer.strokeColor = Color_Line.CGColor;
    
    UIBezierPath *cutPath = [UIBezierPath bezierPath];
    
    for (int i = 0; i < count; i ++) {
        [cutPath moveToPoint:CGPointMake(_columnWidth * i + SCR_W(10), 0)];
        
        [cutPath addLineToPoint:CGPointMake(_columnWidth * i + SCR_W(10), SCR_W(280))];
        
        cutLayer.path = cutPath.CGPath;
    }
	[self.layer insertSublayer:cutLayer atIndex:0];
}
- (void)drawLineWithBrokenLintData:(NSArray *)dataAry lineColor:(UIColor *)lineColor
{
    if (dataAry.count == 0) {
        return;
    }
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 1;
    shapeLayer.strokeColor = lineColor.CGColor;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (int idx = 0; idx < dataAry.count - 1; idx++) {
        
        CGFloat startY = SCR_W(256) - [dataAry[idx] floatValue] * _scale;
        
        CGFloat endY = SCR_W(256) - [dataAry[idx + 1] floatValue] * _scale;
        
        [path moveToPoint:CGPointMake(_columnWidth * idx + SCR_W(10), startY)];
        
        [path addLineToPoint:CGPointMake(_columnWidth * (idx + 1) + SCR_W(10), endY)];
        
        shapeLayer.path = path.CGPath;
    }
    [self.layer insertSublayer:shapeLayer below:_currentView.layer];
    //设置动画
//    [shapeLayer addAnimation:[self animationFunctionWithName:_animationType] forKey:@"strokeEnd"];
}
- (void)setChartAnimationType:(ChartAnimationType)animationType animationTime:(CGFloat)time
{
    _animationType = animationType;
    
    _animationTime = time;
}
//动画
- (CABasicAnimation *)animationFunctionWithName:(ChartAnimationType)animationType
{
    _animationTime = _animationTime > 0 ? _animationTime : 1.0;
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = _animationTime;
    pathAnimation.fromValue = @(0);
    pathAnimation.toValue = @(1);

    switch (animationType) {
        case chartAnimationNone:
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
            break;
        case chartAnimationLinear:
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            break;
        case chartAnimationEaseOut:
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            break;
        case chartAnimationEaseIn:
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            break;
        case chartAnimationEaseInEaseOut:
            pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            break;
        default:
            break;
    }
    return pathAnimation;
}

- (void)layoutSubviews
{
    //
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_currentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:SCR_W(20)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_currentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_currentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(250)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_currentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(60)]];
    //
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:SCR_W(10)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:1]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_lineView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(280)]];
    //
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_startLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:SCR_W(15)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_startLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:- SCR_W(12)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_startLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(12)]];
    //
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_endLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1.0 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_endLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:- SCR_W(12)]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_endLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:SCR_W(12)]];
}

@end
