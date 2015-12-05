//
//  HFMainViewController.m
//  Hase-F
//
//  Created by 张昊煜 on 15/12/3.
//  Copyright © 2015年 Lab. All rights reserved.
//

#import "HFMainViewController.h"
#import "JKSideSlipView.h"

@interface HFMainViewController ()<UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tabelView;
@property (nonatomic, strong) UIView *firstView;

@property (nonatomic, assign) BOOL cellCollor;

@property (nonatomic, strong) JKSideSlipView *sideSlipView;

@property (nonatomic, assign) CGFloat directionY;

@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIButton *aqiBtn;
@property (nonatomic, strong) UIButton *pmBtn;

@property (nonatomic, assign) CGFloat addHeight;

@end

@implementation HFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGPoint position = CGPointMake(0, 1000);
    
    [self.scrollView setContentOffset:position animated:YES];
    
    self.cellCollor = YES;
    
    [self prefersStatusBarHidden];
    
    self.directionY = 0;
    
    self.addHeight = 1;
    
    [self setupDate];
    [self setupUI];
    
    [self setupMenu];

}

-(BOOL)prefersStatusBarHidden{
    
    return YES;
    
}

- (void)setupMenu
{
    self.sideSlipView = [[JKSideSlipView alloc]initWithSender:self];
    self.sideSlipView.backgroundColor = [UIColor redColor];
    
    UIView *menu = [[UIView alloc] init];
    menu.backgroundColor = [UIColor blackColor];
    
    [self.sideSlipView setContentView:menu];
    [self.view addSubview:self.sideSlipView];
}

- (void)setupDate
{
    
}

- (void)setupUI
{
    self.scrollView.contentSize = CGSizeMake(HFWith, 1000+HFHeight);
    //弹动的效果
    self.scrollView.bounces = NO;
//    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:self.scrollView];
    
    self.firstView = [[UIView alloc] init];
    self.firstView.backgroundColor = [UIColor blackColor];
    
    [self.scrollView addSubview:self.firstView];
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView.mas_top).offset(1000);
        make.left.equalTo(self.scrollView.mas_left);
        make.width.equalTo(@(HFWith));
        make.height.equalTo(@(300));
    }];
    
    self.topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.topBtn setTitle:@"向上" forState:UIControlStateNormal];
    self.topBtn.backgroundColor = [UIColor orangeColor];
    [self.topBtn addTarget:self action:@selector(topBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstView addSubview:self.topBtn];
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top).offset(20);
        make.right.equalTo(self.firstView.mas_right).offset(-20);
        make.width.equalTo(@(50));
        make.height.equalTo(@(20));
    }];
    
    self.aqiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.aqiBtn setTitle:@"aqi" forState:UIControlStateNormal];
    self.aqiBtn.backgroundColor = [UIColor orangeColor];
    [self.aqiBtn addTarget:self action:@selector(aqiBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstView addSubview:self.aqiBtn];
    [self.aqiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.firstView.mas_bottom).offset(-20);
        make.left.equalTo(self.firstView.mas_left).offset(20);
        make.width.equalTo(@(50));
        make.height.equalTo(@(20));
    }];
    
    self.pmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.pmBtn setTitle:@"pm2.5" forState:UIControlStateNormal];
    self.pmBtn.backgroundColor = [UIColor orangeColor];
    [self.pmBtn addTarget:self action:@selector(pmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.firstView addSubview:self.pmBtn];
    [self.pmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.firstView.mas_bottom).offset(-20);
        make.right.equalTo(self.firstView.mas_right).offset(-20);
        make.width.equalTo(@(50));
        make.height.equalTo(@(20));
    }];
    
    self.tabelView.delegate = self;
    self.tabelView.dataSource = self;
    [self.scrollView addSubview:self.tabelView];
//    self.tabelView.bounces = NO;
//    self.scrollView.bounces = NO;
    
    [self.tabelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.scrollView.mas_left);
        make.width.equalTo(@(HFWith));
    }];
    
}

- (void)topBtnClick
{
    CGPoint position = CGPointMake(0, 0);
    
    [self.scrollView setContentOffset:position animated:YES];
}

- (void)aqiBtnClick
{
    self.cellCollor = YES;
    [self.tabelView reloadData];
}

- (void)pmBtnClick
{
    self.cellCollor = NO;
    [self.tabelView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"HFMainViewController";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.userInteractionEnabled = NO;
    if (self.cellCollor) {
        cell.backgroundColor = [UIColor purpleColor];
    }else{
        cell.backgroundColor = [UIColor redColor];
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"select" forState:UIControlStateNormal];
    [button setTitle:@"unSelect" forState:UIControlStateHighlighted];
    
    [cell.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cell.mas_top).offset(10);
        make.left.equalTo(cell.mas_left);
        make.width.equalTo(@(100));
        make.height.equalTo(@(50));
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 1000;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f %f",self.tabelView.contentOffset.y, self.directionY);
    CGFloat nowHeight = self.firstView.frame.size.height;
    if (self.directionY != 0 && self.tabelView.contentOffset.y > 0) {
        //300为firstView 初始高度
        if (self.tabelView.contentOffset.y > self.directionY && nowHeight>150) {
            NSArray* constrains = self.firstView.constraints;
//            NSLog(@"%@",constrains);
            for (NSLayoutConstraint* constraint in constrains) {
                if([constraint isEqual:constraint])
                {
                    [self.firstView removeConstraint:constraint];
                }
            }
            [self addLayout];
            
            NSLog(@"nowHeight %f",nowHeight);
            [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(HFWith));
                make.height.equalTo(@(nowHeight-self.tabelView.contentOffset.y+self.directionY));
            }];
        }
    }
    
    if(self.tabelView.contentOffset.y < 0 && nowHeight<=300 && self.directionY != 0 ){
        self.addHeight=self.addHeight+10;
        NSArray* constrains = self.firstView.constraints;
        //            NSLog(@"%@",constrains);
        for (NSLayoutConstraint* constraint in constrains) {
            if([constraint isEqual:constraint])
            {
                [self.firstView removeConstraint:constraint];
            }
        }
        [self addLayout];
        [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(HFWith));
            make.height.equalTo(@(nowHeight-self.tabelView.contentOffset.y + 50));
        }];
    }
    
    self.directionY = self.tabelView.contentOffset.y;
    
}

- (void)addLayout
{
    [self.topBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.firstView.mas_top).offset(20);
        make.right.equalTo(self.firstView.mas_right).offset(-20);
    }];
    
    [self.aqiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.firstView.mas_bottom).offset(-20);
        make.left.equalTo(self.firstView.mas_left).offset(20);
    }];
    
    [self.pmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.firstView.mas_bottom).offset(-20);
        make.right.equalTo(self.firstView.mas_right).offset(-20);
    }];
}

#pragma mark - getters

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, HFWith, HFHeight)];
    }
    return _scrollView;
}

- (UITableView *)tabelView
{
    if (!_tabelView) {
        _tabelView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _tabelView;
}

@end
