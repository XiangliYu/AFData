//
//  StarProjectData.m
//  创8
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 LoveSpending. All rights reserved.
//

#import "Data.h"

#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@implementation Data

#pragma mark -- 单例类
+ (Data *)defaultData{
    static dispatch_once_t onceToken;
    static Data *data = nil;
    dispatch_once(&onceToken, ^{
        data = [Data new];
    });
    return data;
}


#pragma mark -- 提交请求
// 第一次请求
- (void)sendFirstRequest{
    
    NSDictionary *dic = @{
                          @"参数名":@" ",
                          };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // POST请求
    [manager POST:@"http://..." parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *resultData = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
        NSString *code = [numFormatter stringFromNumber:[resultData objectForKey:@"code"]];
        
        if ([code isEqualToString:@"200"]) {
        
            NSArray *datas = [resultData objectForKey:@"datas"];
            
            if (self.dataArray.count==0) {
                [self loadDataFrom:datas];
            }else{
                
                [self.dataArray removeAllObjects];
                [self loadDataFrom:datas];
            };
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"failure");
    }];
    
}

// 整理数据
- (void)loadDataFrom:(NSArray *)data{
    
    for (NSDictionary *dic in data) {
        
        Model *model = [[Model alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.dataArray addObject:model];
    }
}

#pragma mark -- 其他方法
// 懒加载
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

// 获得待完成数据
- (NSMutableArray *)getDataArray{
    
    return self.dataArray;
}

// 移除数据
- (void)removeData{
    
    [self.dataArray removeAllObjects];
}


@end
