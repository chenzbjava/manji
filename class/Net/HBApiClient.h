//
//  HBApiClient.h
//  imageHandbook
//
//  Created by chenzb on 14-8-5.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "AFNetworking.h"

@interface HBApiClient : AFHTTPRequestOperationManager

+(instancetype)shareHBApiClient;

@end
