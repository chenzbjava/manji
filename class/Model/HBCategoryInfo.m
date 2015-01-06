//
//  HBCategoryInfo.m
//  imageHandbook
//
//  Created by chenzb on 15/1/5.
//  Copyright (c) 2015年 chenzb. All rights reserved.
//

#import "HBCategoryInfo.h"

@implementation HBCategoryInfo

@synthesize cName,eName,type,sourceUrl;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.cName forKey:@"cName"];
    [aCoder encodeObject:self.eName forKey:@"eName"];
    [aCoder encodeInt:self.type forKey:@"baiduUserName"];
    [aCoder encodeObject:self.sourceUrl forKey:@"sourceUrl"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.cName = [aDecoder decodeObjectForKey:@"cName"];
    self.eName = [aDecoder decodeObjectForKey:@"eName"];
    self.type = [aDecoder decodeIntForKey:@"type"];
    self.sourceUrl = [aDecoder decodeObjectForKey:@"sourceUrl"];
    
    return self;
}

+ (NSArray *)createModelArrayByDic:(NSDictionary *) _data;
{

    NSArray *array = [_data objectForKey:@"category"];
    
    NSMutableArray *modelArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    for (NSDictionary *item in array) {
        if ([item allKeys].count == 0) {
            break;
        }
        HBCategoryInfo *category = [[HBCategoryInfo alloc]init];
        category.cName = [item objectForKey:@"cName"];
        category.eName = [item objectForKey:@"eName"];
        category.type = [[item objectForKey:@"type"] intValue];
        category.sourceUrl = [item objectForKey:@"sourceUrl"];
        [modelArray addObject:category];
    }
    return modelArray;
}


@end
