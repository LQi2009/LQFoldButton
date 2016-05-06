//
//  ViewController.m
//  LZFoldButton
//
//  Created by Artron_LQQ on 16/5/5.
//  Copyright © 2016年 Artup. All rights reserved.
//

#import "ViewController.h"
#import "LZFoldButton.h"

@interface ViewController ()<LZFoldButtonDelegate>
{
    LZFoldButton *lz;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *arr = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8"];
    self.view.backgroundColor = [UIColor grayColor];
    
    lz = [[LZFoldButton alloc]initWithFrame:CGRectMake(100, 50, 100, 30) dataArray:arr];
    
    lz.lzDelegate = self;
    lz.backgroundColor = [UIColor redColor];
    lz.lzFontSize = 12;
    lz.lzHeight = 300;
    lz.lzButtonType = 1;

    [lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
    [lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
    [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
    [self.view addSubview:lz];
    
    lz.lzResultBlock = ^(id obj){
        NSLog(@"block>>%@",obj);
    };
    
}

-(void)LZFoldButton:(LZFoldButton*)foldButton didSelectObject:(id)obj {
    NSLog(@"%@",obj);
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%d",lz.lzSelected);
    
    if (lz.lzSelected) {
        [lz LZCloseTable];
    } else {
        [lz LZOpenTable];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
