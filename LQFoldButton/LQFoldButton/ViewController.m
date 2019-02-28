//
//  ViewController.m
//  LQFoldButton
//
//  Created by LiuQiqiang on 2018/8/24.
//  Copyright © 2018年 LiuQiqiang. All rights reserved.
//

#import "ViewController.h"
#import "LZFoldButton/LQFoldButton.h"
//#import "LZFoldButton/LQFoldButtonItem.h"


@interface ViewController ()

@property (nonatomic, strong) LQFoldButton *foldButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8"];
    
    NSMutableArray *datas = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSString *title in arr) {
        LQFoldButtonItem *item = [[LQFoldButtonItem alloc]init];
        item.title = title;
        [datas addObject:item];
    }
    
    _foldButton = [[LQFoldButton alloc]init];
    _foldButton.backgroundColor = [UIColor redColor];
    _foldButton.frame = CGRectMake(100, 50, 100, 30);
//    _foldButton.ti
    [_foldButton configDatas:datas];
    
    
//    lz.lzFontSize = 12;
//    lz.lzHeight = 300;
//    lz.lzButtonType = LZFoldButtonTypeRight;
//
//    [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
//    [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
//    [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
    [self.view addSubview:_foldButton];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
