//
//  HBImageView.h
//  imageHandbook
//
//  Created by chenzb on 14-8-13.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HBImageView : UITableViewCell

@property(nonatomic,assign)BOOL isLeft;

@property(nonatomic,strong)UIImageView *imageView;

-(void)setImageWithURL:(NSURL *) _url height:(float) _height;


@end
