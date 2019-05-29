//
//  WCNewWordInterface.h
//  vci
//
//  Created by 齐江涛 on 2017/11/20.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WCNewWordInterface <NSObject>

@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, copy  ) NSString *userCode;
@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, copy  ) NSString *extra;

@end
