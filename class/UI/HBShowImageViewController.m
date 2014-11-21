//
//  HBShowImageControllerView.m
//  imageHandbook
//
//  Created by chenzb on 14-9-11.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBShowImageViewController.h"
#import "HBImageInfo.h"
#import "HBCacheCenter.h"

@interface HBShowImageViewController ()<UIScrollViewDelegate>
{
    UIScrollView    *_scrollView;
    UIImageView     *_currentImageView; //当前视图
    UIImageView     *_nextImageView;    //下一个视图
    UIImageView     *_previousView;     //上一个视图
    BOOL            _isFristDrage; //是否第一次滑动
    UIView          *_bottomView;//底部按钮视图
    NSMutableArray  *_bottomBtnArray;//按钮数组
    
    BOOL            _isHiddinBottomView;//展示底部视图
    
    UIView          *_showImageDescView;//展示图片信息
    UILabel         *_imageTitle;//图片名称
    UILabel         *_imageCategory;//图片分类
    UILabel         *_imageDate;//图片采集时间
    UILabel         *_imageDesc;//图片描述
    
    BOOL            isShowInfo;
    
}
@end

@implementation HBShowImageViewController

@synthesize _dataArray,_index;

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
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, self.view.height)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.userInteractionEnabled = YES;
    _scrollView.backgroundColor = [UIColor blackColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.bounces = NO;
    [self.view addSubview:_scrollView];
    
    if (_dataArray.count ==1) {
        _previousView = [self createImageView:0];
        _scrollView.contentSize = CGSizeMake(self.view.width, 0);
    }else if(_dataArray.count == 2){
        _previousView = [self createImageView:0];
        _currentImageView = [self createImageView:_scrollView.width];
        _scrollView.contentSize = CGSizeMake(2 * self.view.width, 0);
    }else{
        _previousView = [self createImageView:0];
        _currentImageView = [self createImageView:_scrollView.width];
        _nextImageView = [self createImageView:_scrollView.width*2];
        _scrollView.contentSize = CGSizeMake(3 * self.view.width, 0);
    }
        [self createFristImageViews];
    
    [self createBottomView];
    
    [self createShowImageInfoView];
    
    isShowInfo = YES;
}
//创建首次视图布局
-(void)createFristImageViews
{
    if(_index == 0){
        _scrollView.contentOffset = CGPointMake(0, 0);
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index] inView:_previousView];
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index+1] inView:_currentImageView];
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index+2] inView:_nextImageView];
    }else if (_index == _dataArray.count-1){
        _scrollView.contentOffset = CGPointMake(_scrollView.width*2, 0);
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index-2] inView:_previousView];
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index-1] inView:_currentImageView];
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index] inView:_nextImageView];
    }else{
        _scrollView.contentOffset = CGPointMake(_scrollView.width, 0);
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index-1] inView:_previousView];
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index] inView:_currentImageView];
        [self changeImageSizeInView:(HBImageInfo*)[_dataArray objectAtIndex:_index+1] inView:_nextImageView];
    }
}
//创建imageview
-(UIImageView *)createImageView:(float)_left
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_left, 0, VIEW_WIDTH, _scrollView.height)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor blackColor];
    imageView.userInteractionEnabled = YES;
    [_scrollView addSubview:imageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
    [imageView addGestureRecognizer:tap];
    
    return imageView;
}
-(void)createShowImageInfoView
{
    _showImageDescView = [[UIView alloc]initWithFrame:CGRectMake((VIEW_WIDTH-280)/2, (VIEW_HEIGHT-200)/2, 280, 70)];
    _showImageDescView.backgroundColor = [UIColor colorWithRed:.96 green:.96 blue:.96 alpha:1];
    _showImageDescView.hidden = YES;
    [self.view addSubview:_showImageDescView];
    
    _imageTitle = [self createLabel:@"" font:K_FONT_12 color:[UIColor grayColor]];
    _imageTitle.frame = CGRectMake(10, 10, 260, 13);
    _imageCategory = [self createLabel:@"" font:K_FONT_12 color:[UIColor grayColor]];
    _imageCategory.frame = CGRectMake(10, _imageTitle.bottom+10, 260, 13);
    _imageDate = [self createLabel:@"" font:K_FONT_12 color:[UIColor grayColor]];
    _imageDate.frame = CGRectMake(10, _imageCategory.bottom+10, 260, 13);
    _imageDesc = [self createLabel:@"" font:K_FONT_12 color:[UIColor grayColor]];
    _imageDesc.numberOfLines = 0;
    _imageDesc.frame = CGRectMake(10, _imageDate.bottom+10, 260, 13);
}


-(UILabel *)createLabel:(NSString *) _text font:(UIFont *) _font color:(UIColor *) _color
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = _text;
    label.textColor  = _color;
    label.font  = _font;
    label.textAlignment = UITextAlignmentLeft;
    [_showImageDescView addSubview:label];
    return label;
}
-(void)setImageInfoAndShow:(HBImageInfo *) _info andIsShow:(BOOL) _isShow
{
    if (_isShow) {
        isShowInfo = NO;
        _imageTitle.text = [NSString stringWithFormat:@"标       题: %@",_info.image_title];
        _imageCategory.text = [NSString stringWithFormat:@"分       类: %@",_info.image_category];
        _imageDate.text = [NSString stringWithFormat:@"采集时间: %@",_info.image_date];
        
        NSString *desc =[NSString stringWithFormat:@"简       介: %@",_info.image_desc];
        CGSize size = [desc sizeWithFont:K_FONT_12 constrainedToSize:CGSizeMake(260, 2000) lineBreakMode:NSLineBreakByCharWrapping];
        _imageDesc.text = desc;
        _imageDesc.height = size.height;
        _showImageDescView.height=70+size.height+10+10;
        _showImageDescView.hidden = NO;
        [UIView animateWithDuration:.5 animations:^{
            _showImageDescView.alpha = .9;
        }];
    }else{
        isShowInfo = YES;
        [UIView animateWithDuration:.5 animations:^{
            _showImageDescView.alpha = .0;
        }completion:^(BOOL finished) {
            if (finished) {
                _showImageDescView.hidden = YES;
            }
        }];
    }
}
-(void)createBottomView
{
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-40, VIEW_WIDTH, 40)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    NSArray *btnArray = @[@"btn_back_normal",@"btn_download_normal",@"btn_collection_normal",@"btn_good_normal"];
    NSArray *btnclickArray = @[@"btn_back_click",@"btn_download_click",@"btn_collection_click",@"btn_good_click"];
    for (int i = 0; i< btnArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:[btnArray objectAtIndex:i]]  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:[btnclickArray objectAtIndex:i]]  forState:UIControlStateHighlighted];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(VIEW_WIDTH/4*i, 0, VIEW_WIDTH/4, 40);
        [_bottomView addSubview:btn];
    }
}
/**
 *  改变图片的缩放比例在试图中全屏
 *
 *  @param _imageInfo 图片信息
 */
-(void)changeImageSizeInView:(HBImageInfo*)_imageInfo inView:(UIImageView *)_imageView
{
    __block UIImageView *waekImageView = _imageView;
    [waekImageView sd_setImageWithURL:[NSURL URLWithString:_imageInfo.image_url] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _imageView.image = image;
        }else{
        }
    }];
}
#pragma mark----------scrollview delegate---------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float offset = scrollView.contentOffset.x;
    if(_index == 0 && offset/_scrollView.width == 1){
        _index = 1;
    }
    if ((offset < _scrollView.width && _index == 1) ||//左划到第二张的时候不在做变更处理
        (offset > _scrollView.width && _index == _dataArray.count-2) ||//右划到倒数第二张的时候不在做变更处理
        _index == 0) {//点击第一张时，不做变更处理
        return;
    }
    if (!isShowInfo) {
        [self setImageInfoAndShow:nil andIsShow:isShowInfo];
    }
    if (offset == 0) {
        _index--;
        _currentImageView.image = _previousView.image;
        _previousView.image = nil;
    }
    if (offset == scrollView.width*2) {
        _index++;
        _currentImageView.image = _nextImageView.image;
        _nextImageView.image = nil;
    }
    if (offset == 0 || offset == scrollView.width*2) {
        scrollView.contentOffset = CGPointMake(scrollView.width, 0);
        HBImageInfo *nextItem = [_dataArray objectAtIndex: _index+1];
        [_nextImageView sd_setImageWithURL:[NSURL URLWithString:nextItem.image_url] placeholderImage:nil];
        //加载上一个视图
        HBImageInfo *perviousItem = [_dataArray objectAtIndex:_index-1];
        [_previousView sd_setImageWithURL:[NSURL URLWithString:perviousItem.image_url] placeholderImage:nil];
    }
}
#pragma mark-----------btn action--------
-(void)btnAction:(UIButton *) _btn
{
    if (_btn.tag == 0) {
        [HBTools setEnableGesture:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
    UIImage *image;
    CGPoint _point = _scrollView.contentOffset;
    if (_point.x == 0) {
        image = _previousView.image;
    }else if (_point.x == _scrollView.width){
        image = _currentImageView.image;
    }else if (_point.x == _scrollView.width*2){
        image = _nextImageView.image;
    }
    if (_btn.tag == 1){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil,nil);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"存储照片成功"
                                                        message:@"您已将照片存储于图片库中，打开照片程序即可查看。"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }else if(_btn.tag == 2){
        HBImageInfo *item = [_dataArray objectAtIndex:_index];
        NSMutableArray *collectionArray = (NSMutableArray*)[HBCacheCenter getCacheModelByKey:COLLECTION_LIST];
        if(!collectionArray){
            collectionArray = [[NSMutableArray alloc]init];
        }
        item.isCollection = YES;
        item.collectionTime = [self createDateString];
        [collectionArray addObject:item];
        [HBCacheCenter cacheModel:_dataArray key:[NSString stringWithFormat:@"%@_%@",[HBCacheCenter getStringCacheByKey:CATEGORY_INDEX],DATA_LIST]];
        [HBCacheCenter cacheModel:collectionArray key:COLLECTION_LIST];
        [SVProgressHUD showSuccessWithStatus:@"收藏成功"];
    }else if (_btn.tag == 3){
        HBImageInfo *item = [_dataArray objectAtIndex:_index];
        [self setImageInfoAndShow:item andIsShow:isShowInfo];
//        [SVProgressHUD showSuccessWithStatus:@"+1"];
    }
}
-(NSString *)createDateString
{
    NSDate *date = [NSDate new];
    NSDateFormatter *formart = [[NSDateFormatter alloc]init];
    [formart setDateFormat:@"MM月dd hh:mm"];
    return [formart stringFromDate:date];
}
-(void)imageViewClick:(UITapGestureRecognizer *) _tap
{
    _isHiddinBottomView = !_isHiddinBottomView;
    if (!isShowInfo) {
        [self setImageInfoAndShow:nil andIsShow:isShowInfo];
    }
    [UIView animateWithDuration:0.3 animations:^{
        if (_isHiddinBottomView) {
            _bottomView.top =self.view.height;
        }else{
            _bottomView.top =self.view.height-40;
        }
    }];
}
@end
