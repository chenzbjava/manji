//
//  HBViewController.m
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBViewController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "HBCenterViewController.h"

@interface HBViewController ()
{    
    UILabel       *_titleLabel;//标题
}
@end

@implementation HBViewController

@synthesize topView,leftbtn,rightbtn;

//@synthesize title;

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
    
    topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, NAVIGATION_BOTTOM)];
    topView.userInteractionEnabled = YES;
    leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.leftbtn addTarget:self action:@selector(leftBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.rightbtn addTarget:self action:@selector(rightBtnPress) forControlEvents:UIControlEventTouchUpInside];
    if (VERSION >=7.0) {
        topView.image = [UIImage imageNamed:@"bg_navBar_64"];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDTH-100)/2, 30, 100, 20)];
        leftbtn.frame = CGRectMake(0, 20, 44, 44);
        rightbtn.frame = CGRectMake(VIEW_WIDTH-44, 20, 44, 44);
    }else{
        topView.image = [UIImage imageNamed:@"bg_navBar_44"];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((VIEW_WIDTH-100)/2, 13, 100, 20)];
        leftbtn.frame = CGRectMake(0, 0, 44, 44);
        rightbtn.frame = CGRectMake(VIEW_WIDTH-44, 0, 44, 44);
    }
    [self.view addSubview:topView];

    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:_titleLabel];
    
    [leftbtn setImageEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
    [topView addSubview:leftbtn];
    
    [rightbtn setImageEdgeInsets:UIEdgeInsetsMake(13, 13, 13, 13)];
    [topView addSubview:rightbtn];
}

-(void)setTitle:(NSString *)_title
{
    if (_title && ![_title isEqualToString:@""]) {
        _titleLabel.text = _title;
    }
}
-(void)leftBtnPress
{
    NSLog(@"left");
}
-(void)rightBtnPress
{
    NSLog(@"right");
}
@end
