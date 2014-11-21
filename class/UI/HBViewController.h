//
//  HBViewController.h
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HBViewController : UIViewController

@property(nonatomic,strong)UIImageView *topView;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)UIButton *leftbtn;
@property(nonatomic,strong)UIButton *rightbtn;

@end
