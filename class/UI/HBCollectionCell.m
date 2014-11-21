//
//  HBCollectionCell.m
//  imageHandbook
//
//  Created by chenzb on 14/11/10.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBCollectionCell.h"
#import "HBImageInfo.h"
@interface HBCollectionCell ()
{
    UILabel      *collectionTime;//收藏时间
    UIView       *lineView;//分割线
    UIImageView  *dataView;//图片
}
@end

@implementation HBCollectionCell


- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createViews];
    }
    return self;
}

-(void)createViews
{
    collectionTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.width, 20)];
    collectionTime.backgroundColor = [UIColor clearColor];
    collectionTime.textColor = [UIColor grayColor];
    collectionTime.font = [UIFont systemFontOfSize:13.0];
    [self.contentView addSubview:collectionTime];
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(0, collectionTime.bottom, self.width, 1)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineView];
    
    dataView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 22, 120, 180)];
    dataView.backgroundColor = [UIColor blackColor];
    dataView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:dataView];
}

-(void)setData:(HBImageInfo*) _imageInfo andHeight:(float)_height
{
    collectionTime.text = _imageInfo.collectionTime;
    dataView.height = _height;
    [dataView sd_setImageWithURL:[NSURL URLWithString:_imageInfo.image_url]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
