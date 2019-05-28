//
//  BaseDAO.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBConfiguration.h"
#import <fmdb/FMDB.h>
#import <JSONModel/JSONModel.h>
#import <YYModel/YYModel.h>

@interface RowMapper : NSObject

@property (nonatomic, copy) id (^rowMap)(FMResultSet *rs);

+ (instancetype)mapperWithRowMap:(id(^)(FMResultSet *rs))mp;

@end

@interface BaseDAO : NSObject

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
- (instancetype)init UNAVAILABLE_ATTRIBUTE;

//- (instancetype)initWithConfiguration:(DBConfiguration *)configuration NS_DESIGNATED_INITIALIZER;

+ (instancetype)daoWithConfiguration:(DBConfiguration *)configuration;

/**
 开启DB附着
 */
- (void)beginAttachDB;

/**
 剥离
 */
- (void)detachDB;

- (void)close;
- (NSString *)stringWithSQL:(NSString*)sql params:(NSArray *)params;
- (NSInteger)integerWithSQL:(NSString*)sql params:(NSArray *)params;

- (id)objectWithSQL:(NSString*)sql params:(NSArray *)params rowMapper:(RowMapper *)mapper;
- (NSArray *)objectsWithSQL:(NSString*)sql params:(NSArray *)params rowMapper:(RowMapper *)mapper;

- (BOOL)updateOne:(NSString *)sql params:(NSArray *)params;
- (BOOL)updateBatch:(NSArray *)sqls params:(NSArray *)paramsArray;
- (BOOL)updateBatchExt:(NSString *)sql params:(NSArray *)paramsArray;

@end

static inline RowMapper* BDDefaultMapper(Class c) {
    RowMapper *mapper = [RowMapper new];
    mapper.rowMap = ^id(FMResultSet *rs) {
        NSError *error;
        JSONModel *model = [[c alloc] initWithDictionary:rs.resultDictionary error:&error];
        if (!model && error) {
            @throw [NSException exceptionWithName:@"daydream_model_crash" reason:@"model should not be nil" userInfo:@{@"cname":NSStringFromClass(c), @"content":rs.resultDictionary, @"error":error}];
        }
        return model;
    };
    return mapper;
}

static inline RowMapper* BDDefaultMapperV2(Class c) {
    RowMapper *mapper = [RowMapper new];
    mapper.rowMap = ^id(FMResultSet *rs) {
        id model = [c yy_modelWithDictionary:rs.resultDictionary];
        if (!model) {
            @throw [NSException exceptionWithName:@"daydream_model_crash" reason:@"model should not be nil" userInfo:@{@"cname":NSStringFromClass(c), @"content":rs.resultDictionary, @"error":@"model is nil"}];
        }
        return model;
    };
    return mapper;
}
