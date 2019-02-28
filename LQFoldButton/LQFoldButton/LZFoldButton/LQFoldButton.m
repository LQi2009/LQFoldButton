//
//  LQFoldButton.m
//  LQFoldButton
//
//  Created by LiuQiqiang on 2018/8/24.
//  Copyright © 2018年 LiuQiqiang. All rights reserved.
//

#import "LQFoldButton.h"
//#import "LQFoldButtonCell.h"
//#import "LQFoldButtonItem.h"

@interface LQFoldButton ()<UITableViewDelegate,UITableViewDataSource>
{
    CGSize __foldContentSize;
    BOOL __isFolded;
    CGRect __originRect;
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *foldTable;
@property (nonatomic, strong) UIButton *foldButton;
@property (nonatomic, copy) LQFoldButtonDidSelectedHandler selectedHandler;
@end

@implementation LQFoldButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _contentHeight = 200.0;
        _itemHeight = 44.0;
        __originRect = frame;
        _selectedIndex = -1;
        _textAttribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12], NSForegroundColorAttributeName: [UIColor blueColor]};
    }
    return self;
}

- (void) configDatas:(NSArray *) datas {
    if (self.dataSource.count > 0) {
        [self.dataSource removeAllObjects];
    }
    
    [self.dataSource addObjectsFromArray:datas];
    [self.foldTable reloadData];
    
    if (_selectedIndex > -1 && _selectedIndex < datas.count) {
        
        LQFoldButtonItem *item = [datas objectAtIndex:_selectedIndex];
        [self.foldButton setTitle:item.title forState:(UIControlStateNormal)];
    } else {
        [self.foldButton setTitle:@"请选择" forState:(UIControlStateNormal)];
    }
}

- (void) didSelectedWithHandler:(LQFoldButtonDidSelectedHandler) handler {
    self.selectedHandler = handler;
}

- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    
    return _dataSource;
}

- (UITableView *)foldTable {
    if (_foldTable == nil) {
        _foldTable = [[UITableView alloc]initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        
        _foldTable.delegate = self;
        _foldTable.dataSource = self;
        _foldTable.backgroundColor = [UIColor whiteColor];
        [self addSubview:_foldTable];
    }
    
    return _foldTable;
}

- (UIButton *)foldButton {
    if (_foldButton == nil) {
        _foldButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _foldButton.backgroundColor = [UIColor blueColor];
//        _foldButton.titleLabel.attributedText
        [_foldButton addTarget:self action:@selector(foldButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_foldButton];
    }
    
    return _foldButton;
}

- (void) foldButtonAction:(UIButton *) button {
    //保证在父视图的最前面,不被其他视图遮挡
    if (self.superview != nil) {
        if ([self.superview.subviews lastObject] != self) {
            [self.superview bringSubviewToFront:self];
        }
    }
    
    button.selected = !button.selected;
    if (__isFolded) {
        [self close];
    } else {
        [self open];
    }
}

- (void) close {
    //如果已经关闭了,直接返回
    if (__isFolded == NO) {
        return;
    }
    __isFolded = NO;
    
    CGRect rect = self.frame;
    rect.size.height -= self.contentHeight;
    self.frame = rect;
}

- (void) open {
    //如果已经展开了,直接返回
    if (__isFolded == YES) {
        return;
    }
    __isFolded = YES;
    CGRect rect = self.frame;
    rect.size.height += self.contentHeight;
    
    [UIView animateWithDuration:0.1 animations:^{
        
        self.frame = rect;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (__isFolded == NO) {
        __originRect = self.bounds;
        self.foldButton.frame = self.bounds;
        self.foldTable.frame = CGRectMake(0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), 0);
    } else {
        
        [UIView animateWithDuration:0.1 animations:^{
            self.foldTable.frame = CGRectMake(0, CGRectGetMaxY(self.foldButton.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds) - CGRectGetHeight(self.foldButton.frame));        } completion:^(BOOL finished) {
            
        }];
        self.foldButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(__originRect));
        
    }
}

#pragma mark - UITableView 代理及数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LQFoldButtonCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LQFoldButtonCell class])];
    if (cell == nil) {
        cell = [[LQFoldButtonCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([LQFoldButtonCell class])];
        cell.backgroundColor = tableView.backgroundColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textAttribute = self.textAttribute;
    }
    
    cell.item = [self.dataSource objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.itemHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row;
    LQFoldButtonItem * obj = [self.dataSource objectAtIndex:indexPath.row];
    
    if (self.selectedHandler) {
        self.selectedHandler(obj, indexPath.row);
    }
    
    [self foldButtonAction:self.foldButton];
    [self setTitle:obj.title forState:(UIControlStateNormal)];
}

- (void)setType:(LQFoldButtonType)type {
    _type = type;
    
    if (type == LQFoldButtonTypeImageRight) {
        
        [self.foldButton layoutIfNeeded];
        
        CGSize titleSize = self.foldButton.titleLabel.bounds.size;
        CGSize imageSize = self.foldButton.imageView.bounds.size;
        CGFloat interval = 1.0;
        
        [self.foldButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [self.foldButton setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        
        [self.foldButton setImageEdgeInsets:UIEdgeInsetsMake(0,titleSize.width + interval, 0, -(titleSize.width + interval))];
        [self.foldButton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(imageSize.width + interval), 0, imageSize.width + interval)];
    }
}

/** 设置按钮的标题 */
- (void) setTitle:(NSString*)title forState:(UIControlState)state {
    [self.foldButton setTitle:title forState:state];
}

- (void) setAttributedTitle:(NSAttributedString*)title forState:(UIControlState)state {
    [self.foldButton setAttributedTitle:title forState:state];
}
/** 设置按钮的标题颜色 */
-(void) setTitleColor:(UIColor*)color forState:(UIControlState)state {
    [self.foldButton setTitleColor:color forState:state];
}
/** 设置按钮的背景图片 */
- (void) setBackgroundImage:(UIImage *)image forState:(UIControlState)state {
    [self.foldButton setBackgroundImage:image forState:state];
}
/** 设置按钮的图片 */
- (void) setImage:(UIImage *)image forState:(UIControlState)state {
    [self.foldButton setImage:image forState:state];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

#pragma mark - LQFoldButtonCell

@implementation LQFoldButtonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setItem:(LQFoldButtonItem *)item {
    _item = item;
    if (self.textAttribute) {
        NSAttributedString *attStr = [[NSAttributedString alloc]initWithString:item.title attributes:self.textAttribute];
        self.textLabel.attributedText = attStr;
    } else {
        self.textLabel.text = item.title;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

#pragma mark - LQFoldButtonItem
@implementation LQFoldButtonItem

@end
