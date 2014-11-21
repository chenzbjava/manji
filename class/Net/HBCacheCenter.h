//
//  HBCacheCenter.h
//  imageHandbook
//
//  Created by chenzb on 14/10/31.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBCacheCenter : NSObject


+(HBCacheCenter*)defaultObject;

+ (void)cacheModel:(id)_data key:(NSString *)_key;
+ (void)clearCachesWithKey:(NSString *)_key;
+ (id)getCacheModelByKey:(NSString *)_key;

+ (void)cacheString:(NSString *)_string key:(NSString *) _key;
+ (NSString *)getStringCacheByKey:(NSString *) _key;
@end
