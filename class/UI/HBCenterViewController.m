//
//  HBCenterViewController.m
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBCenterViewController.h"
#import "HBImageInfo.h"
#import "HBRequest.h"
#import "HBImageView.h"

#import "SVPullToRefresh.h"
#import "PendulumView.h"
#import "HBShowImageViewController.h"

#import "GADBannerView.h"
#import "HBCategoryInfo.h"

#define AdvHeight 50.0

@interface HBCenterViewController ()<UITableViewDelegate,UITableViewDataSource,GADBannerViewDelegate>
{
    UITableView       *_tableViewLeft;
    UITableView       *_tableViewRight;
    
    NSMutableArray    *_dataArray;//数据数组
    
    BOOL              _pullUpLoad;//上拉刷新
    int               _pageIndex;//当前页数
    
    PendulumView     *_topLoadingView;//顶部加载动画
    UILabel          *_bottomShowLoadView;//底部显示加载更多字样
    
    UIButton         *_backTopBtn;//返回顶部按钮
    
    NSString         *_categoryTitle;
    dataType         _dataType;//当前加载数据的类型
    
    NSMutableArray   *leftArray;
    NSMutableArray   *rightArray;
    
    HBCategoryInfo   *nowCategory;
    
}
@end

@implementation HBCenterViewController

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
    if(![HBCacheCenter getStringCacheByKey:CATEGORY_NAME]){
        HBCategoryInfo *info = [[HBCategoryInfo alloc]init];
        info.cName = @"全部";
        info.eName = @"all";
        info.type = 0;
        info.sourceUrl = @"channel";
        [HBCacheCenter cacheModel:info key:CATEGORY_NAME];
        nowCategory = info;
    }
    self.title = ((HBCategoryInfo *)[HBCacheCenter getCacheModelByKey:CATEGORY_NAME]).cName;
    
    [self.leftbtn setImage:[UIImage imageNamed:@"btn_openLeftVc"] forState:UIControlStateNormal];
    [self.rightbtn setImage:[UIImage imageNamed:@"btn_openRightVc"] forState:UIControlStateNormal];
    [self.rightbtn setImageEdgeInsets:UIEdgeInsetsMake(13, 11, 12, 11)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [[NSMutableArray alloc]init];
    
    _topLoadingView = [[PendulumView alloc]initWithFrame:CGRectMake(0, NAVIGATION_BOTTOM, self.view.width, 40) ballColor:[UIColor colorWithRed:.89 green:.11 blue:.27 alpha:1.0]];
    _topLoadingView.hidden = YES;
    [_topLoadingView stopAnimating];
    [self.view addSubview:_topLoadingView];
    
    
                                                
    _bottomShowLoadView = [[UILabel alloc]initWithFrame:CGRectMake(0, self.view.height-20-AdvHeight, self.view.width, 20)];
    _bottomShowLoadView.backgroundColor = [UIColor clearColor];
    _bottomShowLoadView.text = @"正在加载...";
    _bottomShowLoadView.font = [UIFont systemFontOfSize:12];
    _bottomShowLoadView.textColor = [UIColor grayColor];
    _bottomShowLoadView.textAlignment = NSTextAlignmentCenter;
    _bottomShowLoadView.hidden = YES;
    [self.view addSubview:_bottomShowLoadView];
    
    _tableViewLeft = [self createTableView];
    _tableViewLeft.frame =CGRectMake(0, NAVIGATION_BOTTOM, self.view.width/2, NAV_VIEWHEIGHT);
    
    _tableViewRight = [self createTableView];
    _tableViewRight.frame =CGRectMake(self.view.width/2, NAVIGATION_BOTTOM, self.view.width/2, NAV_VIEWHEIGHT);

    //设置上拉和下拉刷新
    __block HBCenterViewController *weakSelf = self;
    [_tableViewLeft addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullUpLoadData];
    }];
    [_tableViewLeft addPullToRefreshWithActionHandler:^{
        [weakSelf pullDownLoadData];
    }];
    
    [_tableViewRight addInfiniteScrollingWithActionHandler:^{
        [weakSelf pullUpLoadData];
    }];
    [_tableViewRight addPullToRefreshWithActionHandler:^{
        [weakSelf pullDownLoadData];
    }];
    
    _tableViewLeft.pullToRefreshView.hidden = YES;
    _tableViewRight.pullToRefreshView.hidden = YES;
    _tableViewLeft.infiniteScrollingView.hidden = YES;
    _tableViewRight.infiniteScrollingView.hidden = YES;
    
    
    _backTopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backTopBtn setBackgroundImage:[UIImage imageNamed:@"btn_arrow_up"] forState:UIControlStateNormal];
    _backTopBtn.frame =CGRectMake(self.view.width-45, self.view.height-50-AdvHeight, 30, 30);
    [_backTopBtn addTarget:self action:@selector(backToTop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backTopBtn];
    
   [_tableViewLeft triggerPullToRefresh];
    
    banner = [[GADBannerView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT-AdvHeight,VIEW_WIDTH, AdvHeight)];
//    banner = [[GADBannerView alloc]initWithAdSize:kGADAdSizeInvalid];
    banner.adUnitID = @"ca-app-pub-9929138593574753/1146256228";
    banner.rootViewController = self;
    banner.delegate = self;
    [self.view addSubview:banner];
    [banner loadRequest:[GADRequest request]];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
-(UITableView *)createTableView
{
    UITableView *tableview = [[UITableView alloc]initWithFrame:CGRectZero];
    tableview.showsVerticalScrollIndicator = NO;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    return  tableview;
}
#pragma mark-----------------btn Press------------------
-(void)backToTop
{
    [_tableViewLeft setContentOffset:CGPointMake(0,0) animated:YES];
}
-(void)leftBtnPress
{
    [HBTools showLeftController:YES];
}
-(void)rightBtnPress
{
    [HBTools showRightController:YES];
}
#pragma mark---------------loadData------------------------------
-(void)reloadDataType:(dataType) dataType AndCategory:(HBCategoryInfo *) _category
{
    nowCategory = _category;
    _dataType = dataType;
    if (dataType == categoty_list || dataType == hot_list) {
        [_tableViewLeft triggerPullToRefresh];
    }else{

    }
}
#pragma mark--------------pullUp and pullDown   load Data-------------------
-(void)pullUpLoadData
{
    _bottomShowLoadView.hidden = NO;
    _pullUpLoad = NO;
    _pageIndex ++;
    [self loadData];
}
-(void)pullDownLoadData
{
    _topLoadingView.hidden = NO;
    _pullUpLoad = YES;
    _pageIndex = 0;
    [self getDataByCache];
}

-(void)getDataByCache
{
    if ([HBCacheCenter getCacheModelByKey:nowCategory.eName]) {
         _dataArray = [HBCacheCenter getCacheModelByKey:nowCategory.eName];
        [self saveNewTitleAndCache];
    }
    [self loadData];
}


-(void)loadData
{
    [_topLoadingView startAnimating];
    HBRequest *request = [[HBRequest alloc]init];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:[NSString stringWithFormat:@"%d",_pageIndex*PAGE_COUNT] forKey:@"pn"];
    [dic setObject:nowCategory==nil?[HBCacheCenter getCacheModelByKey:CATEGORY_NAME]:nowCategory.cName forKey:@"tag2"];
    [request requestWithParameters:dic
                              type:[HBImageInfo class]
                     success:^(id returnData) {
                         [self performSelector:@selector(loadSuccess:) withObject:returnData afterDelay:1.0];
                     }  fail:^(NSError *error) {
                         [self performSelector:@selector(loadFail) withObject:nil afterDelay:1.0];
                     }];
}
-(void)closeLoadimgAnimate
{
    [_topLoadingView stopAnimating];
    if (_tableViewLeft.pullToRefreshView.state == SVPullToRefreshStateLoading || _tableViewRight.pullToRefreshView.state == SVPullToRefreshStateLoading) {
        [_tableViewLeft.pullToRefreshView stopAnimating];
        [_tableViewRight.pullToRefreshView stopAnimating];
        _topLoadingView.hidden = YES;
    }
    if (_tableViewLeft.infiniteScrollingView.state == SVInfiniteScrollingStateLoading || _tableViewRight.infiniteScrollingView.state == SVInfiniteScrollingStateLoading) {
        _bottomShowLoadView.hidden = YES;
        [_tableViewLeft.infiniteScrollingView stopAnimating];
        [_tableViewRight.infiniteScrollingView stopAnimating];
    }
}
-(void)loadSuccess:(NSArray *)_returnData
{
    [self closeLoadimgAnimate];
    [self saveNewTitleAndCache];
    
    if (_pullUpLoad) {//上拉刷新
        [_dataArray removeAllObjects];
    }
    [_dataArray addObjectsFromArray:_returnData];
    
    [HBCacheCenter cacheModel:_dataArray key:nowCategory.eName];
    
    [_tableViewLeft reloadData];
    [_tableViewRight reloadData];
    if (_tableViewLeft.contentSize.height > _tableViewRight.contentSize.height) {
        _tableViewRight.contentSize = _tableViewLeft.contentSize;
    }else{
        _tableViewLeft.contentSize =  _tableViewRight.contentSize;
    }
}
-(void)loadFail
{
    [self closeLoadimgAnimate];
    [_tableViewLeft reloadData];
    [_tableViewRight reloadData];
    [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
}
//保存新的标题和下表，并且修改新标题
-(void)saveNewTitleAndCache
{
    if (_categoryTitle) {
        [HBCacheCenter cacheModel:nowCategory key:CATEGORY_NAME];
    }
    self.title = nowCategory.cName;
}
#pragma mark------------------TableVIew delegate and DataSource------------------------------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HBImageInfo *imageInfo = [self getItemBytableview:tableView andIndex:(int)indexPath.row];
    return (float)(self.view.width/2)/[imageInfo.image_width intValue]*[imageInfo.image_height intValue];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count/2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellName = @"imageCell";
    HBImageView *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[HBImageView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    HBImageInfo *item =[self getItemBytableview:tableView andIndex:(int)indexPath.row];
    cell.isLeft = tableView == _tableViewLeft;
    [cell setImageWithURL:[NSURL URLWithString:item.image_url] height:(self.view.width/2)/[item.image_width intValue]*[item.image_height intValue]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HBShowImageViewController *temp  = [[HBShowImageViewController alloc]init];
    temp._dataArray = _dataArray;
    temp._index =[self getIndexBytableview:tableView andIndex:(int)indexPath.row];
    [HBTools setEnableGesture:NO];
    [self.navigationController pushViewController:temp animated:YES];
}
/**
 *  根据tableview和int 返回左右列表的真实数据下表
 *
 *  @param _tableview
 *  @param _index     下表
 *
 *  @return 真实的下表
 */
-(HBImageInfo *)getItemBytableview:(UITableView *) _tableview andIndex:(int) _index
{
    if (_dataArray.count <= 0) {
        return nil;
    }
    if (_tableview == _tableViewLeft) {
        return [_dataArray objectAtIndex:_index*2];
    }else{
        if (_index==0) {
            return [_dataArray objectAtIndex:1];
        }
        return [_dataArray objectAtIndex:_index*2+1];
    }
}
-(int)getIndexBytableview:(UITableView *) _tableview andIndex:(int) _index
{
    if (_tableview == _tableViewLeft) {
        return _index*2;
    }else{
        if (_index==0) {
            return 1;
        }
        return _index*2+1;
    }
}
#pragma mark-------UISCROLLVIEW Delegate------------------------------

/**
 *  列表同步
 *
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _backTopBtn.hidden = YES;
    if (scrollView == _tableViewLeft) {
        [_tableViewRight setContentOffset:_tableViewLeft.contentOffset];
    }else if (scrollView == _tableViewRight){
        [_tableViewLeft setContentOffset:_tableViewRight.contentOffset];
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView*)scrollView willDecelerate:(BOOL)decelerate
{
    _backTopBtn.hidden = NO;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _backTopBtn.hidden = NO;
}

#pragma --------------
- (void)adViewDidReceiveAd:(GADBannerView *)view
{
    NSLog(@"adv load success");
    [self setFrameisHavaAdv:YES];
}

- (void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error
{
    NSLog(@"adv load fail %@",error.description);
    [self setFrameisHavaAdv:NO];
}

-(void)setFrameisHavaAdv:(BOOL) flag
{
    if (flag) {
        _bottomShowLoadView.top =self.view.height-20-AdvHeight;
        _tableViewLeft.height = NAV_VIEWHEIGHT - AdvHeight;
        _backTopBtn.top = self.view.height-50-AdvHeight;
    }else{
        _bottomShowLoadView.top =self.view.height-20;
        _tableViewLeft.height = NAV_VIEWHEIGHT ;
        _backTopBtn.top = self.view.height-50;
    }
}
@end
