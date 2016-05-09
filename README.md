#1.LZFoldButton
一个自定义的实现点击按钮,展现一个下拉列表的控件
#2.效果图
![效果图](https://github.com/LQQZYY/LZFoldButton/blob/master/aaa.gif)
#3.介绍
LZFoldButton是将UIButton,UITableView和一些其他控件进行封装,并提供外部调用接口,将展示列表数据,选择列表数据等相关逻辑,都在其内部实现,外部只需要使用一个数据源数组初始化,设置相关属性即可;

###3.1初始化
初始化的时候请使用我提供的一个初始化方法,参数增加了一个数据源数组,目前设定的是数组内加入的是字符串,如果需要传入模型,可以根据自己的需求进行修改;
```
-(instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray<NSString *> *)dataArray;
```
###3.2设置属性
关于属性的设置,请不要直接使用`UIView`的默认属性,其背景色的设置,可以使用`backgroundColor`,这个方法我进行了重写;
在进行按钮的设置时,我尽量使用了和系统按钮类似的方式:
```
/** 设置按钮的标题 */
- (void)LZSetTitle:(NSString*)title forState:(UIControlState)state;
/** 设置按钮的标题颜色 */
-(void)LZSetTitleColor:(UIColor*)color forState:(UIControlState)state ;
/** 设置按钮的背景图片 */
- (void)LZSetBackgroundImage:(UIImage *)image forState:(UIControlState)state;
/** 设置按钮的图片 */
- (void)LZSetImage:(UIImage *)image forState:(UIControlState)state;
```
增加了以下几个属性的设置:
```
/** 设置按钮的样式 */
@property (assign,nonatomic)LZFoldButtonType lzButtonType;

/** 设置按钮标题字号 */
@property (assign,nonatomic)CGFloat lzTitleFontSize;
/** 选择后是否改变title为选择的内容,默认YES */
@property (assign,nonatomic)BOOL lzTitleChanged;
/** 按钮的选中状态 */
@property (assign,nonatomic,readonly)BOOL lzSelected;
/** 设置按钮的代理 */
@property (weak,nonatomic) id <LZFoldButtonDelegate> lzDelegate;
```
属性的作用都有注释;

-----
对于下拉列表的内容的一些设置,我提供了以下几个属性:
```
/** 设置展开的视图背景色 */
@property (strong,nonatomic)UIColor *lzColor;
/** 设置展开后的视图透明度 */
@property (assign,nonatomic)CGFloat lzAlpha;

/** 设置下拉列表文字大小 */
@property (assign,nonatomic)CGFloat lzFontSize;
/** 设置下拉列表文字颜色 */
@property (strong,nonatomic)UIColor *lzFontColor;
/** 展开列表的高度 默认 200 */
@property (assign,nonatomic)CGFloat lzHeight;
```
另外还提供了外部打开列表,关闭列表的方法:
```
/** 外部关闭列表的方法 */
- (void)LZCloseTable;

/** 外部打开列表的方法 */
- (void)LZOpenTable;
```
主要是考虑到,可能会有在外部手动打开/关闭列表的需求,一般是不需要的;
###4.获取结果
关于结果的获取,我提供了两种方式`Block`和`Delegate`,可根据自己的需求选择:
```
/** 以block形式回调选中结果 */
@property (copy,nonatomic) LZFoldButtonBlock lzResultBlock;

@protocol LZFoldButtonDelegate <NSObject>

-(void)LZFoldButton:(LZFoldButton*)foldButton didSelectObject:(id)obj;
@end
```
###5.使用
使用其实特别简单:

```
NSArray *arr = @[@"测试1",@"测试2",@"测试3",@"测试4",@"测试5",@"测试6",@"测试7",@"测试8"];
 self.view.backgroundColor = [UIColor grayColor];
 
 lz = [[LZFoldButton alloc]initWithFrame:CGRectMake(100, 50, 100, 30) dataArray:arr];
 
lz.lzDelegate = self;
lz.backgroundColor = [UIColor redColor];
lz.lzFontSize = 12;
lz.lzHeight = 300;
lz.lzButtonType = LZFoldButtonTypeRight;

[lz LZSetTitle:@"请选择" forState:UIControlStateNormal];
[lz LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
 [lz LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
 [self.view addSubview:lz];
 ```
 
 以上就可以在界面显示一个可以折叠的下拉列表了;可以在代理方法或block里获取选择的结果;
 使用block获取结果:
 ```
 lz.lzResultBlock = ^(id obj){
  NSLog(@"block>>%@",obj);
  };
  ```
  使用代理获取结果:
  ```
   //使用代理回调结果
-(void)LZFoldButton:(LZFoldButton*)foldButton didSelectObject:(id)obj {
   NSLog(@"%@",obj);
   
}
```
##如果对你有帮助,请给颗星支持一下
##如果在使用中有bug,请反馈给我
[个人博客](http://blog.csdn.net/lqq200912408)
QQ号:302934443
#(完)
