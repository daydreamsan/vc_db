//
//  DBConfiguration.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSString DBPath;

@interface DBConfiguration : NSObject

/**
 数据库文件路径
 */
@property (nonatomic, copy) DBPath   *path;

/**
 attach database数据库路径
 */
@property (nonatomic, copy) NSString *attachDBPath;

/**
 attach database数据库的别名
 */
@property (nonatomic, copy) NSString *attachDBAlias;

@end
