//
//  HBHotCategoryModel.m
//  imageHandbook
//
//  Created by chenzb on 14/11/16.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBHotCategoryModel.h"

@implementation HBHotCategoryModel


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.hotCategoryName forKey:@"hotCategoryName"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.hotCategoryName = [aDecoder decodeObjectForKey:@"hotCategoryName"];
    }
    return self;
}

+ (NSArray *)createModelArrayByDic:(NSDictionary *) _data;
{
    NSDictionary *dic = [_data objectForKey:@"data"];
    NSArray *array = [dic objectForKey:@"tags"];
    NSMutableArray *modelArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    for (NSDictionary *item in array) {
        if ([item allKeys].count == 0) {
            break;
        }
        HBHotCategoryModel *model = [[HBHotCategoryModel alloc]init];
        model.hotCategoryName = [[item objectForKey:@"tag"] substringFromIndex:3];
        [modelArray addObject:model];
    }
    return modelArray;
}

@end
