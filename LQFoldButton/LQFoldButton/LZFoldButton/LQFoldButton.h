//
//  LQFoldButton.h
//  LQFoldButton
//
//  Created by LiuQiqiang on 2018/8/24.
//  Copyright © 2018年 LiuQiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

//按钮的样式,图片在左侧和在右侧两种
typedef NS_ENUM(NSInteger,LQFoldButtonType) {
    LQFoldButtonTypeNormal = 0,//
    LQFoldButtonTypeImageRight  = 1,//图片在右, title 在左
};

@class LQFoldButtonItem;

/**
 选中的回调 Block

 @param obj 选中的元素
 @param index 选中的索引
 */
typedef void(^LQFoldButtonDidSelectedHandler)(LQFoldButtonItem *obj, NSInteger index);
@interface LQFoldButton : UIView

/**
 展开视图的高度
 */
@property (nonatomic, assign) CGFloat contentHeight;

/**
 每个选择项的高度
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 按钮的类型
 */
@property (nonatomic, assign) LQFoldButtonType type;

/**
 内容文本的属性
 */
@property (nonatomic, strong)NSDictionary<NSAttributedStringKey,id> *textAttribute;

/**
 当前选中的索引, 按钮 title 会默认显示对应item的title
 */
@property (nonatomic, assign) NSInteger selectedIndex ;

/**
 配置需要展示的数据源

 @param datas 数据源
 */
- (void) configDatas:(NSArray *) datas ;

/**
 选中方法回调

 @param handler 回调 Block
 */
- (void) didSelectedWithHandler:(LQFoldButtonDidSelectedHandler) handler ;

/** 设置按钮的标题 */
- (void) setTitle:(NSString*)title forState:(UIControlState)state;
/** 设置按钮的标题颜色 */
-(void) setTitleColor:(UIColor*)color forState:(UIControlState)state ;
- (void) setAttributedTitle:(NSAttributedString*)title forState:(UIControlState)state; 
/** 设置按钮的背景图片 */
- (void) setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
/** 设置按钮的图片 */
- (void) setImage:(UIImage *)image forState:(UIControlState)state;
@end

#pragma mark - LQFoldButtonCell
@interface LQFoldButtonCell : UITableViewCell

@property (nonatomic, strong) LQFoldButtonItem *item;
@property (nonatomic, copy) NSDictionary *textAttribute;
@end

#pragma mark - LQFoldButtonItem
@interface LQFoldButtonItem : NSObject

@property (nonatomic,copy) NSString *title;
@end

