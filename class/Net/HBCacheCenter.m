//
//  HBCacheCenter.m
//  imageHandbook
//
//  Created by chenzb on 14/10/31.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBCacheCenter.h"

@implementation HBCacheCenter
static HBCacheCenter * _default = nil;
+(HBCacheCenter *)defaultObject{
    if (!_default) {
        _default = [[HBCacheCenter alloc]init];
    }
    return _default;
}

+ (void)cacheModel:(id)_data key:(NSString *)_key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_data];
    [defaults setObject:data forKey:_key];
    [defaults synchronize];
}
+ (id)getCacheModelByKey:(NSString *)_key
{
    if(!_key){
        return nil;
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:_key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+ (void)cacheString:(NSString *)_string key:(NSString *)_key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_string forKey:_key];
    [defaults synchronize];
}

+ (NSString *)getStringCacheByKey:(NSString *) _key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *data = [defaults stringForKey:_key];
    return data;
}

+ (void)clearCachesWithKey:(NSString *)_key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:_key];
    [defaults synchronize];
}
@end
