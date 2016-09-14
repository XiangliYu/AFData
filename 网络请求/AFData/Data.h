//
//  StarProjectData.h
//  创8
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 LoveSpending. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface Data : NSObject

// 单例
+ (Data*)defaultData;

// 获得数据
- (NSMutableArray *)getDataArray;

// 首次
- (void)sendFirstRequest;

@property (nonatomic, strong) NSMutableArray *dataArray;


@end
