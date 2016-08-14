//
//  XRButtonListView.h
//  私人专科医生
//
//  Created by 柴勇峰 on 7/5/16.
//  Copyright © 2016 Xingren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XRButtonListItem : UIView

@property (nonatomic, strong) NSString *itemTitle;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, readonly) NSInteger index;

@property (nonatomic, strong) UIFont *itemTitleFont;

/*-------------------- Color ---------------------------*/

@property (nonatomic, strong) UIColor *itemTitleColor;

@property (nonatomic, strong) UIColor *itemBorderColor;

@property (nonatomic, strong) UIColor *itemBackgroundColor;

@property (nonatomic, strong) UIColor *itemTitleSelectedColor;

@property (nonatomic, strong) UIColor *itemBorderSelectedColor;

@property (nonatomic, strong) UIColor *itemBackgroundSelectedColor;

/**
 *  @author Brave, 16-07-12 15:07:57
 *
 *  @brief  可设置圆角 @note Default 0
 */
@property (nonatomic, assign) CGFloat itemRadius;

/**
 *  @author Brave, 16-07-07 16:07:16
 *
 *  @brief  是否显示"荐" @note Default is NO
 */
@property (nonatomic, assign) BOOL isRecommend;

@property (nonatomic, weak) id itemTarget;

@property (nonatomic, assign) SEL itemSelector;

@end

/* =============================== 类之界线 ======================================== */

@protocol XRButtonListViewDelegate;

@interface XRButtonListView : UIView

/*-------------------- item frame ---------------------------*/

/**
 *  @author Brave, 16-07-12 15:07:25
 *
 *  @brief  可设置每个item的宽度 @note Default is 109
 */
@property (nonatomic, assign) CGFloat itemWidth;

/**
 *  @author Brave, 16-07-12 15:07:06
 *
 *  @brief  可设置每个item的高度 @note Default is 40
 */
@property (nonatomic, assign) CGFloat itemHeight;

@property (nonatomic, assign) UIEdgeInsets edgeInsets;

/**
 *  @author Brave, 16-07-12 15:07:36
 *
 *  @brief  可设置buttonListView的行间距 @note Default is 10
 */
@property (nonatomic, assign) CGFloat linePadding;

/**
 *  @author Brave, 16-07-12 15:07:10
 *
 *  @brief  可设置buttonListView的列间距 @note Default is 10
 */
@property (nonatomic, assign) CGFloat columnPadding;

/*-------------------- buttonListView frame ---------------------------*/

/**
 *  @author Brave, 16-07-12 15:07:19
 *
 *  @brief  获取buttonListView的宽度
 */
@property (nonatomic, readonly) CGFloat buttonListViewWidth;

/**
 *  @author Brave, 16-07-12 15:07:36
 *
 *  @brief  获取buttonListView的高度
 */
@property (nonatomic, readonly) CGFloat buttonListViewHeight;

- (CGFloat)buttonListViewWidth;

- (CGFloat)buttonListViewHeight;

/**
 *  @author Brave, 16-07-07 16:07:58
 *
 *  @brief  每一行按钮的个数 @note Default is 3
 */
@property (nonatomic, assign) NSInteger numberOfItemsPerLine;

/**
 *  @author Brave, 16-07-07 16:07:59
 *
 *  @brief  是否可以多选 @note Default is NO
 */
@property (nonatomic, assign) BOOL isMultipleSelect;

/**
 *  @author Brave, 16-07-07 18:07:51
 *
 *  @brief  是否可以反选 @note Default is NO
 */
@property (nonatomic, assign) BOOL isInverseSelect;

/**
 *  @author Brave, 16-07-13 18:07:51
 *
 *  @brief  设置代理 @note 在使用GCC编译器语法时 需要在括号外设置代理,否则不会有效果
 */
@property (nonatomic, weak) id<XRButtonListViewDelegate> delegate;

@end

@protocol XRButtonListViewDelegate <NSObject>

- (void)buttonListView:(XRButtonListView *)buttonListView didSelectItem:(XRButtonListItem *)item;

- (XRButtonListItem *)buttonListView:(XRButtonListView *)buttonListView itemForIndex:(NSInteger)index;

- (NSInteger)numberOfItemWithButtonListView:(XRButtonListView *)buttonListView;

@end
