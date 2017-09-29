//
//  ViewController.m
//  BrokenLineDemo
//
//  Created by wbx_iMac on 2017/9/28.
//  Copyright © 2017年 DaverZhou. All rights reserved.
//

#import "ViewController.h"
#import "CustomChartView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    CustomChartView * chartView = [[CustomChartView alloc] initWithFrame:CGRectMake(0, 100, SCR_W(375), SCR_W(280))];
    
    [chartView setCustomChartWithIncomeColor:[UIColor redColor] incomeData:
  @[@"10",@"50",@"100",@"50",@"70",@"80",@"40"]
                                 refundColor:[UIColor brownColor] refundData:
  @[@"1",@"5",@"0",@"0",@"30",@"20",@"10"]
                                    maxCount:100 timeData:
  @[@"9月1日",@"9月2日",@"9月3日",@"9月4日",@"9月5日",@"9月6日",@"9月7日"]
  ];
    
    [self.view addSubview:chartView];
    
}




@end
