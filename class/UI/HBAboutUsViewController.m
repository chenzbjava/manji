//
//  HBAboutUsViewController.m
//  imageHandbook
//
//  Created by chenzb on 14/11/16.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBAboutUsViewController.h"

@interface HBAboutUsViewController ()
{
    UIImageView *iconView;
    UILabel *appNameLabel;
    UILabel *authorLabel;
    UILabel *ArtistLabel;
    UILabel *emailLabel;
    UILabel *versionLabel;
}
@end

@implementation HBAboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.leftbtn setImage:[UIImage imageNamed:@"btn_closeOpenView"] forState:UIControlStateNormal];
    [self.leftbtn setImageEdgeInsets:UIEdgeInsetsMake(14, 14, 14, 14)];
    
    iconView = [[UIImageView alloc]initWithFrame:CGRectZero];
    iconView.image = [UIImage imageNamed:@"icon_aboutUs"];
    [self.view addSubview:iconView];
    
    appNameLabel = [self createLabel:@"美妞儿" font:K_FONT_14 color:[UIColor grayColor]];
    appNameLabel.textAlignment = UITextAlignmentCenter;
    authorLabel = [self createLabel:@"开发 :    Atom" font:K_FONT_14 color:[UIColor grayColor]];
    ArtistLabel = [self createLabel:@"美工 :    文全" font:K_FONT_14 color:[UIColor grayColor]];
    emailLabel = [self createLabel:@"邮箱 :    chen_motu@sina.com" font:K_FONT_14 color:[UIColor grayColor]];
    versionLabel = [self createLabel:@"v 1.2.0" font:K_FONT_14 color:[UIColor grayColor]];
    versionLabel.textAlignment = UITextAlignmentCenter;
    
}
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    float left = 50.0;
    float top = NAVIGATION_BOTTOM+50;
    
    iconView.frame = CGRectMake((VIEW_WIDTH - 80)/2, top, 80, 80);
    top+= iconView.height+20;
    appNameLabel.frame = CGRectMake(iconView.left, top, 80, 15);
    top+=appNameLabel.height+50;
    authorLabel.frame = CGRectMake(left, top, 200, 15);
    top+=authorLabel.height+7;
    ArtistLabel.frame = CGRectMake(left, top, 200, 15);
    top+=ArtistLabel.height+7;
    emailLabel.frame = CGRectMake(left, top, 200, 15);
    top+=emailLabel.height+7;
    versionLabel.frame = CGRectMake(60,VIEW_HEIGHT - 50, 200, 15);
    top+=versionLabel.height+7;
}

-(UILabel *)createLabel:(NSString *) _text font:(UIFont *) _font color:(UIColor *) _color
{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.text = _text;
    label.textColor  = _color;
    label.font  = _font;
    label.textAlignment = UITextAlignmentLeft;
    [self.view addSubview:label];
    return label;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)leftBtnPress
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
@end
