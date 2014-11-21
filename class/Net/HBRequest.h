//
//  HBRequest.h
//  imageHandbook
//
//  Created by chenzb on 14-8-5.
//  Copyright (c) 2014年 chenzb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HBBaseModel.h"
typedef enum {
    requestDataUsedCache,
    requestDaTaUnUsedCache
}RequestDataISCache;


typedef void (^SuccessedBlock)(id returnData);
typedef void (^FailedBlock)(NSError *error);

@interface HBRequest : NSObject

@property(nonatomic,copy)SuccessedBlock   successBlock;
@property(nonatomic,copy)FailedBlock     failedBlock;


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
                  fail:(FailedBlock)fail;

/**
 *  带缓存的请求
 *
 *  @param requestUrl 请求的URL后缀
 *  @param parameters 请求需要的参数
 *  @param cache      是否读取缓存
 *  @param success    请求成功后的回调Block
 *  @param fail       请求失败后的回调Block
 */
- (void)requestWithParameters:(NSDictionary *)parameters
                         type:(Class )_class
                      success:(SuccessedBlock)success
                         fail:(FailedBlock)fail;

@end
