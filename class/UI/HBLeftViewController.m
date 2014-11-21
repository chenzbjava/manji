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
    self.topView.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [HBTools getCategoryArray];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(20, NAVIGATION_BOTTOM, VIEW_WIDTH-20, NAV_VIEWHEIGHT-5)];
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
    }
     cell.textLabel.text = [_dataArray objectAtIndex:indexPath.row];
    if ([[HBCacheCenter getStringCacheByKey:CATEGORY_NAME] isEqualToString:[_dataArray objectAtIndex:indexPath.row]]) {
        cell.selected = YES;
    }
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [HBTools showRootController:YES dataType:categoty_list andTitle:[_dataArray objectAtIndex:indexPath.row]];
}
@end
