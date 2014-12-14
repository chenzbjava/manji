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
    NSString* urlString =  @"";
    if (_class == [HBImageInfo class]) {
        NSString *channel = @"";
        if ([[HBTools getCateENameFromArrayByName:[parameters objectForKey:@"tag2"]] containsString:@"DM_"]) {
            channel = @"动漫";
        }else{
            channel = @"美女";
        }
        urlString =CATEGORY_IMAGELIST(channel,[parameters objectForKey:@"tag2"],@"0",[parameters objectForKey:@"pn"]);
    }
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    HBApiClient *apiClient = [HBApiClient shareHBApiClient];
    [apiClient getPath:urlString
            parameters:nil
               success:^(AFHTTPRequestOperation *operation, id responseObject) {
                   
                   NSDictionary *requestDic = [(NSData *)responseObject objectFromJSONData];
                   success([_class createModelArrayByDic:requestDic]);
               }
               failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                   fail(error);
               }];
}
@end
