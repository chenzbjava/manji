//
//  HBClooectionViewController.m
//  imageHandbook
//
//  Created by chenzb on 14/11/10.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBCollectionViewController.h"
#import "HBImageInfo.h"
#import "HBCollectionCell.h"
#import "HBImageView.h"

@interface HBCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView       *_tableViewLeft;
    UITableView       *_tableViewRight;
    UIImageView      *_collectionBigImage;
    
    
    NSMutableArray    *leftArray;
    NSMutableArray    *rightArray;
    
    UIView            *noHavaCollectionView;
}
@end

@implementation HBCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收藏";
    [self.leftbtn setImage:[UIImage imageNamed:@"btn_closeOpenView"] forState:UIControlStateNormal];
    [self.leftbtn setImageEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _tableViewLeft = [self createTableView];
    _tableViewLeft.frame =CGRectMake(0, NAVIGATION_BOTTOM, self.view.width/2, NAV_VIEWHEIGHT);
    
    _tableViewRight = [self createTableView];
    _tableViewRight.frame =CGRectMake(self.view.width/2, NAVIGATION_BOTTOM, self.view.width/2, NAV_VIEWHEIGHT);
    
    _collectionBigImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, VIEW_HEIGHT, VIEW_WIDTH,VIEW_HEIGHT)];
    _collectionBigImage.contentMode = UIViewContentModeScaleAspectFit;
    _collectionBigImage.backgroundColor = [UIColor blackColor];
    _collectionBigImage.userInteractionEnabled = YES;
//    _collectionBigImage.hidden = YES;
    [self.view addSubview:_collectionBigImage];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeImageVIew)];
    [_collectionBigImage addGestureRecognizer:tap];
    
    
    noHavaCollectionView = [[UIView alloc]initWithFrame:CGRectMake((VIEW_WIDTH-200)/2, (NAV_VIEWHEIGHT-100)/2, 200, 100)];
    noHavaCollectionView.hidden = YES;
    [self.view addSubview:noHavaCollectionView];
    
    UIImageView *nohaveImage  = [[UIImageView alloc]initWithFrame:CGRectMake(63, 0, 77, 77)];
    nohaveImage.image = [UIImage imageNamed:@"icon_collection_noHave"];
    [noHavaCollectionView addSubview:nohaveImage];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, 200, 20)];
    title.textColor = [UIColor grayColor];
    title.text = @"暂无收藏，请在首页添加";
    title.font = K_FONT_14;
    title.textAlignment = UITextAlignmentCenter;
    [noHavaCollectionView addSubview:title];
    
    
    NSArray *allArray= [HBCacheCenter getCacheModelByKey:COLLECTION_LIST];
    if (allArray.count == 0) {
        noHavaCollectionView.hidden = NO;
    }else{
        leftArray = [[NSMutableArray alloc]init];
        rightArray = [[NSMutableArray alloc]init];
        for (int i = 0;i< allArray.count; i++) {
            if (i%2==0) {
                [leftArray addObject:[allArray objectAtIndex:i]];
            }else{
                [rightArray addObject:[allArray objectAtIndex:i]];
            }
        }
        [_tableViewLeft reloadData];
        [_tableViewRight reloadData];
        if (_tableViewLeft.contentSize.height > _tableViewRight.contentSize.height) {
            _tableViewRight.contentSize = _tableViewLeft.contentSize;
        }else{
            _tableViewLeft.contentSize =  _tableViewRight.contentSize;
        }
    }
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)createCollectionBtn:(HBImageView * ) _cell andTag:(int) _tag
{
    UIButton  *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.tag = _tag;
    [downloadBtn setBackgroundColor:[UIColor colorWithRed:.74 green:.74 blue:.74 alpha:.5]];
    [downloadBtn setImage:[UIImage imageNamed:@"btn_collection_downing"] forState:UIControlStateNormal];
    [downloadBtn addTarget:self action:@selector(downloadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cell addSubview:downloadBtn];
    
    UILabel *line =  [[UILabel alloc]initWithFrame:CGRectZero];
    line.tag = 2000;
    line.backgroundColor = [UIColor darkGrayColor];
    [_cell addSubview:line];
    
    UIButton  * deletBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deletBtn.tag = _tag+1;
    [deletBtn setBackgroundColor:[UIColor colorWithRed:.74 green:.74 blue:.74 alpha:.5]];
    [deletBtn setImage:[UIImage imageNamed:@"btn_collection_del"] forState:UIControlStateNormal];
    [deletBtn addTarget:self action:@selector(deletAction:) forControlEvents:UIControlEventTouchUpInside];
    [_cell addSubview:deletBtn];
};
#pragma mark ------btn Action-----------
-(void)closeImageVIew
{
    [UIView animateWithDuration:.3 animations:^{
        _collectionBigImage.top = VIEW_HEIGHT;
    }];
//    _collectionBigImage.hidden = YES;
}
-(void)downloadImageAction:(UIButton *) _btn
{
    UIImageWriteToSavedPhotosAlbum(((HBImageView*)_btn.superview).imageView.image, nil, nil,nil);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功"
                                                    message:@"您已将照片存储于图片库中，打开照片程序即可查看。"
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
    
}
-(void)deletAction:(UIButton *) _btn
{
    if (_btn.tag ==1002) {
        NSIndexPath *indexPath = [_tableViewLeft indexPathForCell:(HBImageView*)_btn.superview];
        [leftArray removeObjectAtIndex:indexPath.row];
        [_tableViewLeft deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }else if (_btn.tag == 1004){
        NSIndexPath *indexPath = [_tableViewRight indexPathForCell:(HBImageView*)_btn.superview];
        [rightArray removeObjectAtIndex:indexPath.row];
        [_tableViewRight deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    NSMutableArray *newCollectionArray = [[NSMutableArray alloc]init];
    
    
    long count = leftArray.count;
    if (count < rightArray.count) {
        count = rightArray.count;
    }
    for (int i = 0; i <= count-1; i++) {
        if (leftArray.count>0 && i <= leftArray.count-1) {
            [newCollectionArray addObject:[leftArray objectAtIndex:i]];
        }
        if (rightArray.count>0 && i <= rightArray.count-1) {
            [newCollectionArray addObject:[rightArray objectAtIndex:i]];
        }
    }
    if (newCollectionArray.count == 0) {
        noHavaCollectionView.hidden = NO;
    }
    [HBCacheCenter cacheModel:newCollectionArray key:COLLECTION_LIST];
}
-(void)leftBtnPress
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark ------UItableview delegate-----------
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableViewLeft) {
        HBImageInfo *imageInfo = [leftArray objectAtIndex:(int)indexPath.row];
        return (float)(self.view.width/2)/[imageInfo.image_width intValue]*[imageInfo.image_height intValue];
    }else{
        HBImageInfo *imageInfo = [rightArray objectAtIndex:(int)indexPath.row];
        return (float)(self.view.width/2)/[imageInfo.image_width intValue]*[imageInfo.image_height intValue];
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tableViewLeft) {
        return leftArray.count;
    }else{
        return rightArray.count;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tableViewLeft) {
        static NSString *cellName = @"imageCell_left";
        HBImageView *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HBImageView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [self createCollectionBtn:cell andTag:1001];
        }
        HBImageInfo *item =[leftArray objectAtIndex:(int)indexPath.row];
        float height =(self.view.width/2)/[item.image_width intValue]*[item.image_height intValue];
        UIButton *load = (UIButton *)[cell viewWithTag:1001];
        UIButton *del = (UIButton *)[cell viewWithTag:1002];
        UILabel *line = (UILabel *)[cell viewWithTag:2000];
        load.frame = CGRectMake(0, height-30, VIEW_WIDTH/4, 30);
        line.frame = CGRectMake(load.right, height-30, 1, 29);
        del.frame = CGRectMake(load.right, height-30, VIEW_WIDTH/4, 30);
        cell.isLeft = YES;
        [cell setImageWithURL:[NSURL URLWithString:item.image_url] height:height];
        
        return cell;
    }else if(tableView == _tableViewRight){
        static NSString *cellName = @"imageCell_right";
        HBImageView *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
        if (!cell) {
            cell = [[HBImageView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
            [self createCollectionBtn:cell andTag:1003];
        }
        HBImageInfo *item =[rightArray objectAtIndex:(int)indexPath.row];
        float height =(self.view.width/2)/[item.image_width intValue]*[item.image_height intValue];
        UIButton *load = (UIButton *)[cell viewWithTag:1003];
        UIButton *del = (UIButton *)[cell viewWithTag:1004];
        load.frame = CGRectMake(0, height-30, VIEW_WIDTH/4, 30);
        del.frame = CGRectMake(load.right, height-30, VIEW_WIDTH/4, 30);
        cell.isLeft = NO;
        [cell setImageWithURL:[NSURL URLWithString:item.image_url] height:height];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    HBImageInfo *item = [self getItemBytableview:tableView andIndex:(int)indexPath.row];
    [_collectionBigImage sd_setImageWithURL:[NSURL URLWithString:item.image_url]];
//    cgpoint point = [tableView]
    [UIView animateWithDuration:.3 animations:^{
        _collectionBigImage.top = 0;
    }];
//    _collectionBigImage.hidden = NO;
}
-(HBImageInfo *)getItemBytableview:(UITableView *) _tableview andIndex:(int) _index
{
    if (_tableview == _tableViewLeft) {
        return [[HBCacheCenter getCacheModelByKey:COLLECTION_LIST] objectAtIndex:_index*2];
    }else{
        if (_index==0) {
            return [[HBCacheCenter getCacheModelByKey:COLLECTION_LIST] objectAtIndex:1];
        }
        return [[HBCacheCenter getCacheModelByKey:COLLECTION_LIST] objectAtIndex:_index*2+1];
    }
}

/**
 *  列表同步
 *
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _tableViewLeft) {
        [_tableViewRight setContentOffset:_tableViewLeft.contentOffset];
    }else if (scrollView == _tableViewRight){
        [_tableViewLeft setContentOffset:_tableViewRight.contentOffset];
    }
}
@end
