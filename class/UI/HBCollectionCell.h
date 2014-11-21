//
//  HBCollectionCell.h
//  imageHandbook
//
//  Created by chenzb on 14/11/10.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HBImageInfo;

@interface HBCollectionCell : UITableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

-(void)setData:(HBImageInfo*) _imageInfo andHeight:(float) _height;

@end
