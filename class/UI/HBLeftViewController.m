//
//  HBLeftViewController.m
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBLeftViewController.h"

@interface HBLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray  *_dataArray;//列表数据
    
    UITableView     *_tableView;//数据列表
    HBCacheCenter   *_cacheCenter;//缓存对象
    
    UIButton        *_belleBtn;
    UIButton        *_cartoonBtn;
    UIView          *mBottomLine;
}
@end

@implementation HBLeftViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"标签";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _belleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _belleBtn.frame =CGRectMake(0, NAVIGATION_BOTTOM, 100, 40);
    [_belleBtn setTitle:@"美妞" forState:UIControlStateNormal];
    [_belleBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    _belleBtn.tag = 1;
    [_belleBtn setTitleColor:[HBTools colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_belleBtn setTitleColor:[HBTools colorWithHexString:@"f13131"] forState:UIControlStateSelected];
    [self.view addSubview:_belleBtn];
    
    _cartoonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cartoonBtn.frame =CGRectMake(_belleBtn.right, NAVIGATION_BOTTOM, 100, 40);
    [_cartoonBtn setTitle:@"动漫" forState:UIControlStateNormal];
    [_cartoonBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    _cartoonBtn.tag = 2;
    [_cartoonBtn setTitleColor:[HBTools colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_cartoonBtn setTitleColor:[HBTools colorWithHexString:@"f13131"] forState:UIControlStateSelected];
    [self.view addSubview:_cartoonBtn];
    
    mBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _belleBtn.bottom-3, _belleBtn.width, 3)];
    mBottomLine.backgroundColor = [HBTools colorWithHexString:@"e51350"];
    [self.view addSubview:mBottomLine];
    
    UILabel  *mTwoLine = [[UILabel alloc]initWithFrame:CGRectMake(0, _cartoonBtn.bottom-.5, 300, .5)];
    mTwoLine.backgroundColor = [HBTools colorWithHexString:@"e6e6e6"];
    [self.view addSubview:mTwoLine];
    
    _dataArray = [HBTools getCategoryArray:1];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _belleBtn.bottom, VIEW_WIDTH-20, NAV_VIEWHEIGHT-_belleBtn.height-10)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}
-(void)changeChannel:(UIButton *) _btn
{
    _btn.selected = YES;
    if (_btn.tag == 1) {
        _dataArray = [HBTools getCategoryArray:1];
//        [HBCacheCenter cacheString:@"美女" key:LEVEL_ONE_NAME];
        _cartoonBtn.selected = NO;
    }else if (_btn.tag == 2) {
        _dataArray = [HBTools getCategoryArray:2];
//        [HBCacheCenter cacheString:@"动漫" key:LEVEL_ONE_NAME];
        _belleBtn.selected = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
        mBottomLine.left = _cartoonBtn.width*(_btn.tag-1);
    }];
    [_tableView reloadData];
}

#pragma mark--------------UItableview-------------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"categoryCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.left = 20;
        
        UIView *bgView = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:.89 green:.11 blue:.27 alpha:1.0];
        cell.selectedBackgroundView = bgView;
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    }
     cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
//    if ([[HBCacheCenter getStringCacheByKey:CATEGORY_NAME] isEqualToString:[_dataArray objectAtIndex:indexPath.row]]) {
//        cell.selected = YES;
//    }else{
//        cell.selected = NO;
//    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [HBTools showRootController:YES dataType:categoty_list andTitle:[_dataArray objectAtIndex:indexPath.row]];
}
@end
