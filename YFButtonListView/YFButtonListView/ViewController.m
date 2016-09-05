//
//  ViewController.m
//  YFButtonListView
//
//  Created by 柴勇峰 on 8/14/16.
//  Copyright © 2016 Brave. All rights reserved.
//

#import "ViewController.h"
#import "YFButtonListView.h"

#define Screen_Width [UIScreen mainScreen].bounds.size.width
#define ColorSet(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface ViewController ()<YFButtonListViewDelegate>
{
    NSArray *_titlesArray;
    YFButtonListView *_buttonListView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self commonInit];
}

- (void)commonInit
{
    _titlesArray = @[@"swift", @"react", @"js", @"oc", @"python", @"php", @"vue", @"c"];
    
    _buttonListView = ({
        
        YFButtonListView *view = [[YFButtonListView alloc] init];
        
        CGFloat scale = Screen_Width / 375.f;
        
        view.itemWidth = 109 * scale;
        view.itemHeight = 40 * scale;
        view.linePadding = 10 * scale;
        view.columnPadding = 9 * scale;
        
        CGFloat padding = 15 * scale;
        view.edgeInsets = UIEdgeInsetsMake(0, padding, 0, padding);
        
        view;
    });
    
    _buttonListView.delegate = self;
    
    [self.view addSubview:_buttonListView];
    
    CGFloat height = _buttonListView.buttonListViewHeight;
    
    _buttonListView.frame = CGRectMake(0, 100, self.view.frame.size.width, height);
}

- (NSInteger)numberOfItemWithButtonListView:(YFButtonListView *)buttonListView
{
    return _titlesArray.count;
}

- (YFButtonListItem *)buttonListView:(YFButtonListView *)buttonListView itemForIndex:(NSInteger)index
{
    YFButtonListItem *item = [[YFButtonListItem alloc] init];
    
    item.itemTitle = _titlesArray[index];
    
    item.itemRadius = 5.f;
    
    item.itemBackgroundColor = [UIColor whiteColor];
    item.itemBorderColor = ColorSet(223, 223, 221, 1.0);
    item.itemTitleColor = ColorSet(102, 102, 102, 1.0);
    
    item.itemBackgroundSelectedColor = ColorSet(33, 152, 200, 1.0);
    item.itemBorderSelectedColor = ColorSet(33, 152, 200, 1.0);
    item.itemTitleSelectedColor = [UIColor whiteColor];
    
    return item;
}

- (void)buttonListView:(YFButtonListView *)buttonListView didSelectItem:(YFButtonListItem *)item
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:item.itemTitle preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:sureAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
