//
//  HBApiClient.h
//  imageHandbook
//
//  Created by chenzb on 14-8-5.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "AFHTTPClient.h"

@interface HBApiClient : AFHTTPClient

+(instancetype)shareHBApiClient;

@end
