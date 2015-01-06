//
//  HBImageView.m
//  imageHandbook
//
//  Created by chenzb on 14-8-13.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBImageView.h"
//#import "UIImageView+AFNetworking.h"

@interface HBImageView ()
{
    UILabel                 *_loadLabel;
}
@end

@implementation HBImageView

@synthesize isLeft,imageView;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.layer.borderWidth = 0.5;
        imageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:imageView];
        
        _loadLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _loadLabel.backgroundColor = [UIColor clearColor];
        _loadLabel.textAlignment = NSTextAlignmentCenter;
        _loadLabel.font = [UIFont systemFontOfSize:10];
        _loadLabel.textColor = [UIColor darkGrayColor];
        _loadLabel.text = @"加载中....";
        _loadLabel.hidden = YES;
        [self.contentView addSubview:_loadLabel];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    _loadLabel.frame = CGRectMake(0, (self.height-15)/2, self.width, 15);
    
    if (isLeft) {
        imageView.frame = CGRectMake(2, 1, self.width-3, self.height-2);
    }else{
        imageView.frame = CGRectMake(1, 1, self.width-3, self.height-2);
    }
}

-(void)setImageWithURL:(NSURL *) _url height:(float) _height
{
    _loadLabel.hidden = NO;
    imageView.image = nil;
    __block UIImageView *waekImageView = imageView;
    [waekImageView sd_setImageWithURL:_url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            _loadLabel.hidden = YES;
            imageView.image = image;
        }else{
            _loadLabel.hidden = NO;
            _loadLabel.text = @"加载失败";
        }
    }];
}
@end
