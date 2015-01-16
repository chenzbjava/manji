//
//  HBRightViewController.m
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBRightViewController.h"
#import "SDImageCache.h"
#import "HBImageInfo.h"
#import "HBAboutUsViewController.h"
#import "UMFeedback.h"
#import "HBRequest.h"
#import "HBHotCategoryModel.h"
#import "HBCollectionViewController.h"
#import "HBCategoryInfo.h"

@interface HBRightViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSArray        *_dataArray;
    UITableView    *_tableView;
    NSMutableArray *hotBtnArray;
    NSArray        *hotCategoryList;
    NSArray        *cellBtnArray;
    NSArray        *cellBtnClickArray;
}
@end

@implementation HBRightViewController

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
//    self.topView.hidden = YES;
    self.title = @"设置";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = @[@"我的收藏",@"清除缓存",@"意见反馈",@"关于我们"];
    cellBtnArray = @[@"btn_right_collection_n",@"btn_right_clearCache_n",@"btn_right_msgBack_n",@"btn_right_aboutUs_n"];
    cellBtnClickArray = @[@"btn_right_collection_c",@"btn_right_clearCache_c",@"btn_right_msgBack_c",@"btn_right_aboutUs_c"];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, NAVIGATION_BOTTOM+20, VIEW_WIDTH-40, 160)];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.delegate =self;
    _tableView.dataSource =self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = YES;
    _tableView.bounces = YES;
    [self.view addSubview:_tableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor grayColor];
        cell.textLabel.textAlignment = NSTextAlignmentRight;
        cell.textLabel.left = 20;
        
        
        UIImageView *iconView = [[UIImageView alloc]initWithFrame:CGRectMake(180, 11, 19, 19)];
        iconView.image =[UIImage imageNamed:[cellBtnArray objectAtIndex:indexPath.row]];
        iconView.highlightedImage =[UIImage imageNamed:[cellBtnClickArray objectAtIndex:indexPath.row]];
        [cell.contentView addSubview:iconView];
        
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 39, VIEW_WIDTH, .5)];
        lineLabel.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineLabel];
        
        UIView *bgView = [[UIView alloc]initWithFrame:cell.contentView.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:.89 green:.11 blue:.27 alpha:1.0];
        cell.selectedBackgroundView = bgView;
        
    }
    cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        HBCollectionViewController *collectionVc = [[HBCollectionViewController alloc]init];
        [HBTools ShowRightMenuVc:collectionVc];
    }else if(indexPath.row == 1){
        [self clearTmpPics];
    }else if(indexPath.row == 2){
        [HBTools ShowRightMenuVc:[UMFeedback feedbackModalViewController]];
    }else if(indexPath.row == 3){
        HBAboutUsViewController *aboutUsVc = [[HBAboutUsViewController alloc]init
                                              ];
        [HBTools ShowRightMenuVc:aboutUsVc];
    }
}


- (void)clearTmpPics
{
    float tmpSize = [[SDImageCache sharedImageCache] getSize];
    NSLog(@"tmpSize : %f",tmpSize);
    UIAlertView *alert  = [[UIAlertView alloc]initWithTitle:@"清理缓存"
                                                    message:[NSString stringWithFormat:@"清理缓存(%.1fM)",tmpSize/1024/1024]
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"清除", nil];
    [alert show];
}
#pragma mark--------UIAlertView Delegate------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //清楚分类列表中得所以缓存图片，不删除收藏
        NSArray *array = [HBTools getCategoryArray];
        for (int i = 0; i<array.count; i++) {
            HBCategoryInfo *info = [array objectAtIndex:i];
            NSArray *cacheList = [HBCacheCenter getCacheModelByKey:info.eName];
            for (int j = 0; j<cacheList.count; j++) {
                HBImageInfo *item = [cacheList objectAtIndex:j];
                if (!item.isCollection) {
                    [[SDImageCache sharedImageCache] removeImageForKey:item.image_url];
                }
            }
            [HBCacheCenter cacheModel:nil key:info.eName];
        }
    }
}
@end
