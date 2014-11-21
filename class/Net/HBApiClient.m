//
//  HBApiClient.m
//  imageHandbook
//
//  Created by chenzb on 14-8-5.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBApiClient.h"

@implementation HBApiClient

+(instancetype)shareHBApiClient
{
    static HBApiClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        _sharedClient = [[HBApiClient alloc]initWithBaseURL:[NSURL URLWithString:BASE_URL]];
    });
    return _sharedClient;
}

@end
