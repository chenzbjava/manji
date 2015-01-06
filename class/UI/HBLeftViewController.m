//
//  HBLeftViewController.m
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBLeftViewController.h"
#import "HBCategoryInfo.h"

@interface HBLeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray   *catoomCategoryArray;
    NSMutableArray   *originalityArray;
    
    UITableView     *_tableView;//数据列表
    HBCacheCenter   *_cacheCenter;//缓存对象
    
    UIButton        *_belleBtn;
    UIButton        *_cartoonBtn;
    UIView          *mBottomLine;
    
    int             cateGoryType;
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
    
    [self createListByTabbar];
    
    
    _belleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _belleBtn.frame =CGRectMake(0, NAVIGATION_BOTTOM, 100, 40);
    [_belleBtn setTitle:@"动漫" forState:UIControlStateNormal];
    [_belleBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    _belleBtn.tag = 0;
    [_belleBtn setTitleColor:[HBTools colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_belleBtn setTitleColor:[HBTools colorWithHexString:@"f13131"] forState:UIControlStateSelected];
    [self.view addSubview:_belleBtn];
    
    _cartoonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cartoonBtn.frame =CGRectMake(_belleBtn.right, NAVIGATION_BOTTOM, 100, 40);
    [_cartoonBtn setTitle:@"创意" forState:UIControlStateNormal];
    [_cartoonBtn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
    _cartoonBtn.tag = 1;
    [_cartoonBtn setTitleColor:[HBTools colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [_cartoonBtn setTitleColor:[HBTools colorWithHexString:@"f13131"] forState:UIControlStateSelected];
    [self.view addSubview:_cartoonBtn];
    
    [self changeChannel:_belleBtn];
    
    mBottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, _belleBtn.bottom-3, _belleBtn.width, 3)];
    mBottomLine.backgroundColor = [HBTools colorWithHexString:@"e51350"];
    [self.view addSubview:mBottomLine];
    
    UILabel  *mTwoLine = [[UILabel alloc]initWithFrame:CGRectMake(0, _cartoonBtn.bottom-.5, 300, .5)];
    mTwoLine.backgroundColor = [HBTools colorWithHexString:@"e6e6e6"];
    [self.view addSubview:mTwoLine];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _belleBtn.bottom, VIEW_WIDTH-20, NAV_VIEWHEIGHT-_belleBtn.height-10)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    [self.view addSubview:_tableView];
    
}
-(void)createListByTabbar
{
    catoomCategoryArray = [[NSMutableArray alloc]init];
    originalityArray = [[NSMutableArray alloc]init];
    for (HBCategoryInfo *info in [HBTools getCategoryArray]) {
        if (info.type == 0) {
            [catoomCategoryArray addObject:info];
        }else if(info.type ==1){
            [originalityArray addObject:info];
        }
    }
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
    cateGoryType = (int)_btn.tag;
    if (_btn.tag == 0) {
        _cartoonBtn.selected = NO;
    }else if (_btn.tag == 1) {
        _belleBtn.selected = NO;
    }
    [UIView animateWithDuration:0.2 animations:^{
        mBottomLine.left = _cartoonBtn.width*(_btn.tag);
    }];
    [_tableView reloadData];
}
-(NSMutableArray *)categoryType
{
    if (cateGoryType == 0) {
        return catoomCategoryArray;
    }else if (cateGoryType == 1){
        return originalityArray;
    }
    return nil;
}

#pragma mark--------------UItableview-------------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self categoryType].count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"categoryCell";
    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.left = 20;
        
        UIView *bgView = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:.89 green:.11 blue:.27 alpha:1.0];
        cell.selectedBackgroundView = bgView;
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
    }
    HBCategoryInfo *info = [[self categoryType] objectAtIndex:indexPath.row];
    HBCategoryInfo *category = [HBCacheCenter getCacheModelByKey:CATEGORY_NAME];
    if ([category.cName isEqualToString:info.cName]) {
        cell.selected = YES;
        NSIndexPath *ipath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        [tableView selectRowAtIndexPath:ipath animated:NO scrollPosition:UITableViewScrollPositionNone];
    }
     cell.textLabel.text = info.cName;
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBCategoryInfo *info = [[self categoryType] objectAtIndex:indexPath.row];
    [HBTools showRootController:YES dataType:categoty_list andCategory:info];
}
@end
