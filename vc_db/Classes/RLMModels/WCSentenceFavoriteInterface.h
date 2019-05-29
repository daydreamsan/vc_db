//
//  WCSentenceFavoriteInterface.h
//  vci
//
//  Created by 齐江涛 on 2017/11/17.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WCSentenceFavoriteInterface <NSObject>

@property (nonatomic, assign) NSInteger sentenceID;
@property (nonatomic, copy  ) NSString *userCode;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, assign) NSInteger edition;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSTimeInterval timestamp;

@property (nonatomic, copy  ) NSString *english;
@property (nonatomic, copy  ) NSString *chinese;
@property (nonatomic, copy  ) NSString *soundFile;
@property (nonatomic, copy  ) NSString *highlight;
@property (nonatomic, copy  ) NSString *source;

@end
