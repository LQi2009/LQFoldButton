# 1.LQFoldButton
一个自定义的实现点击按钮,展现一个下拉列表的控件

# 2.效果图
![效果图](https://github.com/LQQZYY/LZFoldButton/blob/master/aaa.gif)

# 3.介绍
LQFoldButton是将UIButton,UITableView和一些其他控件进行封装,并提供外部调用接口,将展示列表数据,选择列表数据等相关逻辑,都在其内部实现,外部只需要使用一个数据源数组初始化,设置相关属性即可;

属性不多, 可直接查看源码

# 4. 使用

```
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

    [_foldButton configDatas:datas];
    
    [self.view addSubview:_foldButton];
    
```

##如果对你有帮助,请给颗星支持一下
##如果在使用中有bug,请反馈给我
[个人博客](http://blog.csdn.net/lqq200912408)
QQ号:302934443
#(完)
