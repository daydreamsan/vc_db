//
//  WCSentenceBridgeInterface.h
//  vci
//
//  Created by 齐江涛 on 2017/12/11.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WCSentenceBridgeInterface <NSObject>

@property (nonatomic, assign) NSInteger sentenceID;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *english;
@property (nonatomic, copy  ) NSString *chinese;
@property (nonatomic, copy  ) NSString *highlight;
@property (nonatomic, copy  ) NSString *media;
@property (nonatomic, copy  ) NSString *source;
@property (nonatomic, assign) NSInteger showType;
@property (nonatomic, assign) NSInteger selected;
@property (nonatomic, assign) NSInteger playState;

@end

