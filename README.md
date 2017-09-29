# 折线图
项目需求默默的自定义了一个折线图，封装那块还不够完善后期会慢慢完善，但是功能上可以给各位看官提供参考、思路。
主要就CustomChartView、ChartCurrentView，其中CustomChartView是用来封装画线的类，ChartCurrentView是封装选中某天日期的信息。
![折线图](http://upload-images.jianshu.io/upload_images/1793034-c9f442f8f71f7941.gif?imageMogr2/auto-orient/strip)
### CustomChartView
初始化：
```
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
```
设置折线图，以及数据的方法如下：
```
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
```
# 调用

```
  CustomChartView * chartView = [[CustomChartView alloc] initWithFrame:CGRectMake(0, 100, SCR_W(375), SCR_W(280))];
    
    [chartView setCustomChartWithIncomeColor:[UIColor redColor] incomeData:
  @[@"10",@"50",@"100",@"50",@"70",@"80",@"40"]
                                 refundColor:[UIColor brownColor] refundData:
  @[@"1",@"5",@"0",@"0",@"30",@"20",@"10"]
                                    maxCount:100 timeData:
  @[@"9月1日",@"9月2日",@"9月3日",@"9月4日",@"9月5日",@"9月6日",@"9月7日"]
  ];
    
    [self.view addSubview:chartView];
```
或者
```
    CustomChartView * chartView = [CustomChartView initializeWithFrame:CGRectMake(0, 100, SCR_W(375), SCR_W(280)) incomeColor:[UIColor redColor] incomeData:
                                   @[@"10",@"50",@"100",@"50",@"70",@"80",@"40"]
                                                           refundColor:[UIColor brownColor] refundData:
                                   @[@"1",@"5",@"0",@"0",@"30",@"20",@"10"]
                                                              maxCount:100 timeData:
                                   @[@"9月1日",@"9月2日",@"9月3日",@"9月4日",@"9月5日",@"9月6日",@"9月7日"]];
    [self.view addSubview:chartView];
```
至于类的实现思路这边就不说了，可以看我的[简书](http://www.jianshu.com/p/0f11e8cca81f),如有问题请留言哈，代码后续会更新，毕竟现在封装的不咋样 只是简单的封装了下，够自己现在项目中使用。
