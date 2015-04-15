
//  HBImageInfo.m
//  imageHandbook
//
//  Created by chenzb on 14-8-11.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBImageInfo.h"

@implementation HBImageInfo



- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.image_desc forKey:@"image_desc"];
    [aCoder encodeObject:self.image_width forKey:@"image_width"];
    [aCoder encodeObject:self.image_height forKey:@"image_height"];
    [aCoder encodeObject:self.image_url forKey:@"image_url"];
    [aCoder encodeObject:[NSString stringWithFormat:@"%d",self.isCollection ] forKey:@"isCollection"];
    [aCoder encodeObject:self.collectionTime forKey:@"collectionTime"];
    [aCoder encodeObject:self.image_category forKey:@"image_category"];
    [aCoder encodeObject:self.image_date forKey:@"image_date"];
    [aCoder encodeObject:self.image_title forKey:@"image_title"];

}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.image_desc = [aDecoder decodeObjectForKey:@"image_desc"];
        self.image_width = [aDecoder decodeObjectForKey:@"image_width"];
        self.image_height = [aDecoder decodeObjectForKey:@"image_height"];
        self.image_url = [aDecoder decodeObjectForKey:@"image_url"];
        self.isCollection= [[aDecoder decodeObjectForKey:@"isCollection"] boolValue];
        self.collectionTime = [aDecoder decodeObjectForKey:@"collectionTime"];
        
        self.image_category = [aDecoder decodeObjectForKey:@"image_category"];
        self.image_date = [aDecoder decodeObjectForKey:@"image_date"];
        self.image_title = [aDecoder decodeObjectForKey:@"image_title"];

    }
    return self;
}

+ (NSArray *)createModelArrayByDic:(NSDictionary *) _data {
    NSArray *array = [_data objectForKey:@"data"];
    
    NSMutableArray *modelArray = [[NSMutableArray alloc]initWithCapacity:array.count];
    for (NSDictionary *item in array) {
        if ([item allKeys].count == 0) {
            break;
        }
        HBImageInfo *image = [[HBImageInfo alloc]init];
        image.image_desc = [item objectForKey:@"desc"];
        image.image_url = [item objectForKey:@"imageUrl"];
        image.image_width = [item objectForKey:@"imageWidth"];
        image.image_height = [item objectForKey:@"imageHeight"];
        image.image_title = [item objectForKey:@"title"];
        image.image_date = [item objectForKey:@"date"];
        image.image_category = [item objectForKey:@"objTag"];
        [modelArray addObject:image];

    }
    return modelArray;
}

@end
