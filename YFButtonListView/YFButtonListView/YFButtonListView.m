//
//  XRButtonListView.m
//
//  Created by 柴勇峰 on 7/5/16.
//  Copyright © 2016 Xingren. All rights reserved.
//

#import "YFButtonListView.h"

#import "PureLayout.h"

#define ColorSet(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define Screen_height [UIScreen mainScreen].bounds.size.height
#define TAG_BASE 10086

@interface YFButtonListItem ()

@end

@implementation YFButtonListItem
{
    UILabel *_label;
    
    UILabel *_recommendLabel;
    
    UITapGestureRecognizer *_tapGestureRecognizer;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        [self commonInit];
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:_itemTarget action:_itemSelector];
        
        [self addGestureRecognizer:_tapGestureRecognizer];
    }
    return self;
}

- (void)commonInit
{
    _label = ({
        
        UILabel *label = [[UILabel alloc] init];
        
        label.frame = CGRectMake(0, 0, 110/375.0*Screen_Width, 40);
        
        label.font = [UIFont systemFontOfSize:15.f];
        
        label.textColor = ColorSet(102, 102, 102, 1.0);
        
        label.backgroundColor = [UIColor whiteColor];
        
        label.layer.borderWidth = 1.f;
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.layer.borderColor = ColorSet(223, 223, 221, 1.0).CGColor;
        
        label.layer.masksToBounds = YES;
        
        [self addSubview:label];
        
        [label autoPinEdgesToSuperviewEdgesWithInsets:UIEdgeInsetsZero];
        
        label;
    });
    
    _recommendLabel = ({
       
        UILabel *label = [[UILabel alloc] init];
        
        label.frame = CGRectMake(_label.frame.size.width-18, 3, 15, 15);
        
        label.text = @"荐";
        
        label.font = [UIFont systemFontOfSize:12.f];
        
        label.textColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.backgroundColor = ColorSet(255, 137, 86, 1.0);
        
        label;
    });
}

- (void)setItemTitle:(NSString *)itemTitle
{
    _itemTitle = itemTitle;
    
    _label.text = _itemTitle;
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    _itemTitleColor = itemTitleColor;
    
    _label.textColor = _itemTitleColor;
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont
{
    _itemTitleFont = itemTitleFont;
    
    _label.font = _itemTitleFont;
}

- (void)setItemBorderColor:(UIColor *)itemBorderColor
{
    _itemBorderColor = itemBorderColor;
    
    _label.layer.borderWidth = 1.0;
    
    _label.layer.borderColor = _itemBorderColor.CGColor;
}

- (void)setItemBackgroundColor:(UIColor *)itemBackgroundColor
{
    _itemBackgroundColor = itemBackgroundColor;
    
    _label.backgroundColor = _itemBackgroundColor;
}

- (void)setItemRadius:(CGFloat)itemRadius {
    
    _itemRadius = itemRadius;
    
    _label.layer.cornerRadius = _itemRadius;
}

- (void)setItemTitleSelectedColor:(UIColor *)itemTitleSelectedColor
{
    _itemTitleSelectedColor = itemTitleSelectedColor;
}

- (void)setItemBorderSelectedColor:(UIColor *)itemBorderSelectedColor
{
    _itemBorderSelectedColor = itemBorderSelectedColor;
}

- (void)setItemBackgroundSelectedColor:(UIColor *)itemBackgroundSelectedColor
{
    _itemBackgroundSelectedColor = itemBackgroundSelectedColor;
}

- (void)setIndex:(NSInteger)index
{
    _index = index;
}

- (void)setIsRecommend:(BOOL)isRecommend
{
    _isRecommend = isRecommend;
    
    if (_isRecommend) {
        
        [_label addSubview:_recommendLabel];
    }
}

- (void)setIsSelected:(BOOL)isSelected
{
    _isSelected = isSelected;
    
    if (_isSelected) {
        
        _label.textColor = _itemTitleSelectedColor;
        _label.layer.borderColor = _itemBorderSelectedColor.CGColor;
        _label.backgroundColor = _itemBackgroundSelectedColor;
        
    } else {
        
        _label.textColor = _itemTitleColor;
        _label.layer.borderColor = _itemBorderColor.CGColor;
        _label.backgroundColor = _itemBackgroundColor;
    }
}

- (void)setItemTarget:(id)itemTarget
{
    [_label removeGestureRecognizer:_tapGestureRecognizer];
    
    _itemTarget = itemTarget;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:_itemTarget action:_itemSelector];
    
    [self addGestureRecognizer:_tapGestureRecognizer];
}

- (void)setItemSelector:(SEL)itemSelector
{
    [_label removeGestureRecognizer:_tapGestureRecognizer];
    
    _itemSelector = itemSelector;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:_itemTarget action:_itemSelector];
    
    [self addGestureRecognizer:_tapGestureRecognizer];
}

@end

/* ===================================== 类之界线 ============================================== */
@interface YFButtonListView ()

@property (nonatomic, strong) NSArray *itemsArray;

@end

@implementation YFButtonListView
{
    NSMutableArray *_dataArray;
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        _numberOfItemsPerLine = 3;
        
        _itemWidth = 109.f/375.0*Screen_Width;
        
        _itemHeight = 40.f;
        
        _linePadding = 10.f/375.0*Screen_Width;
        
        _columnPadding = 10.f/375.0*Screen_Width;
        
        _dataArray = [NSMutableArray array];
    }
    return self;
}

- (void)setDelegate:(id<YFButtonListViewDelegate>)delegate
{
    _delegate = delegate;
    
    NSInteger itemCount = 0;
    
    if (_delegate && [_delegate respondsToSelector:@selector(numberOfItemWithButtonListView:)]) {
        
        itemCount = [_delegate numberOfItemWithButtonListView:self];
    }
    
    for (int i = 0; i < itemCount; i++) {
        
        YFButtonListItem *item;
        
        if (_delegate && [_delegate respondsToSelector:@selector(buttonListView:itemForIndex:)]) {
            
            item = [_delegate buttonListView:self itemForIndex:i];
            
            item.itemTarget = self;
            item.itemSelector = @selector(buttonListViewClicked:);
            item.index = i;
            
            [_dataArray addObject:item];
        }
    }
    
    self.itemsArray = _dataArray;
}

- (void)setItemsArray:(NSArray *)itemsArray
{
    _itemsArray = itemsArray;
    
    if (_itemsArray.count > 0) {
        
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }
    
    for (UIView *item in _itemsArray) {
        
        [self addSubview:item];
    }
    
    [self setNeedsLayout];
}

- (void)buttonListViewClicked:(UIGestureRecognizer *)gesture
{
    YFButtonListItem *item = (YFButtonListItem *)gesture.view;
    
    if (!_isMultipleSelect) {
        
        for (YFButtonListItem *otherItem in _itemsArray) {
            
            if ([otherItem isEqual:item]) {
                
                continue;
            }
            
            otherItem.isSelected = NO;
        }
    }
    
    item.isSelected = (item.isSelected && _isInverseSelect) ? NO : YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(buttonListView:didSelectItem:)]) {
        
        [_delegate buttonListView:self didSelectItem:item];
    }
}

- (void)setItemWidth:(CGFloat)itemWidth
{
    _itemWidth = itemWidth;
    
    [self setNeedsLayout];
}

- (void)setItemHeight:(CGFloat)itemHeight
{
    _itemHeight = itemHeight;
    
    [self setNeedsLayout];
}

- (void)setNumberOfItemsPerLine:(NSInteger)numberOfItemsPerLine
{
    _numberOfItemsPerLine = numberOfItemsPerLine;
    
    [self setNeedsLayout];
}

- (void)setColumnPadding:(CGFloat)columnPadding
{
    _columnPadding = columnPadding;
    
    [self setNeedsLayout];
}

- (void)setLinePadding:(CGFloat)linePadding
{
    _linePadding = linePadding;
    
    [self setNeedsLayout];
}

- (void)setEdgeInsets:(UIEdgeInsets)edgeInsets {
    
    _edgeInsets = edgeInsets;
    
    [self setNeedsLayout];
}

- (CGFloat)buttonListViewWidth
{
    CGFloat ret = _edgeInsets.left + _edgeInsets.right + _itemWidth * _numberOfItemsPerLine + (_numberOfItemsPerLine - 1) * _columnPadding;
    
    return ret;
}

- (CGFloat)buttonListViewHeight
{
    NSInteger numberOfLines = (_itemsArray.count - 1) / _numberOfItemsPerLine + 1;
    
    CGFloat ret = _edgeInsets.top + _edgeInsets.bottom + _itemHeight * numberOfLines + (numberOfLines - 1) * _linePadding;
    
    return ret;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < _itemsArray.count; i++) {
        
        NSInteger colum = i % _numberOfItemsPerLine;
        
        CGFloat x = _edgeInsets.left + (_itemWidth + _columnPadding) * colum;
        
        NSInteger line = i / _numberOfItemsPerLine;
        
        CGFloat y = _edgeInsets.top + (_itemHeight + _linePadding) * line;
        
        YFButtonListItem *item = [_itemsArray objectAtIndex:i];
        
        item.frame = CGRectMake(x, y, _itemWidth, _itemHeight);
    }
}

@end
