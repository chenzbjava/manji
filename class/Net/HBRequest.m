//
//  HBRequest.m
//  imageHandbook
//
//  Created by chenzb on 14-8-5.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import "HBRequest.h"
#import "HBApiClient.h"
#import "JSONKit.h"
#import "HBImageInfo.h"
#import "HBHotCategoryModel.h"
#import "HBCategoryInfo.h"


@implementation HBRequest
/**
 *  带缓存的请求
 *
 *  @param requestUrl 请求的URL后缀
 *  @param parameters 请求需要的参数
 *  @param cache      是否读取缓存
 *  @param success    请求成功后的回调Block
 *  @param success    请求超时后的回调Block
 *  @param fail       请求失败后的回调Block
 */
- (void)requestWithUrl:(NSString *)requestUrl
            parameters:(NSDictionary *)parameters
               isCache:(RequestDataISCache)cache
               success:(SuccessedBlock)success
                  fail:(FailedBlock)fail
{
    
}

- (void)requestWithParameters:(NSDictionary *)parameters
                         type:(Class)_class
                      success:(SuccessedBlock)success
                         fail:(FailedBlock)fail
{
    HBApiClient *apiClient = [HBApiClient shareHBApiClient];
    [apiClient GET:CATEGORY_IMAGELIST
            parameters:[self getParamByTagName:parameters]
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   success([_class createModelArrayByDic:responseObject]);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   fail(error);
               }];
}

-(NSDictionary *) getParamByTagName:(NSDictionary *)parameters;
{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"动漫" forKey:@"col"];
    [param setValue:[parameters objectForKey:@"tag2"] forKey:@"tag"];
    [param setValue:[parameters objectForKey:@"pn"] forKey:@"pn"];
    [param setValue:@"0" forKey:@"sort"];
    [param setValue:[NSString stringWithFormat:@"%d",PAGE_COUNT] forKey:@"rn"];
    [param setValue:@"" forKey:@"tag3"];
    [param setValue:@"channel" forKey:@"p"];
    [param setValue:@"1" forKey:@"from"];
    
    return param;
}
@end
