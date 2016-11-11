//
//  SearchResultViewController.m
//  ZZSearchControl
//
//  Created by heheda on 2016/11/9.
//  Copyright © 2016年 呵呵嗒. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"嘿嘿，这是结果";
    
    [self initUI];
}
#pragma mark - UI
- (void)initUI
{
    [self initLabel];
}

- (void)initLabel
{
    UILabel *label = [UILabel new];
    label.frame = CGRectMake(20.0f, 100.0f, 100.0f, 30.0f);
    label.text = self.keyWords;
    [self.view addSubview:label];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
