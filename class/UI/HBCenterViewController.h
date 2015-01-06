//
//  HBCenterViewController.h
//  imageHandbook
//
//  Created by chenzb on 14-8-4.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBViewController.h"

@class GADBannerView,HBCategoryInfo;

@interface HBCenterViewController : HBViewController
{
    GADBannerView    *banner;//广告条
}
-(void)reloadDataType:(dataType) _dataType AndCategory:(HBCategoryInfo *) _category;

@end
