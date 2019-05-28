//
//  BaseDAO.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/7.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "BaseDAO.h"

@implementation RowMapper

+ (instancetype)mapperWithRowMap:(id(^)(FMResultSet *rs))mp {
    id one = self.new;
    [one setRowMap:mp];
    return one;
}

@end

static NSMutableDictionary *daoCache;

@interface BaseDAO ()

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@property (nonatomic, strong) DBConfiguration *configuration;

@end

@implementation BaseDAO

- (instancetype)initWithConfiguration:(DBConfiguration *)configuration {
    self = [super init];
    
    self.configuration = configuration;
    
    NSAssert(configuration.path.length, @"DB Path should not be NIL !!!");
    self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:configuration.path];
    
    return self;
}

+ (instancetype)daoWithConfiguration:(DBConfiguration *)configuration {
    if (!daoCache) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            daoCache = @{}.mutableCopy;
        });
    }
    NSString *key = configuration.path;
    BaseDAO *dao = daoCache[key];
    if (!dao) {
        dao = [self.alloc initWithConfiguration: configuration];
    }
    return dao;
}

- (void)beginAttachDB {
    NSAssert(self.configuration.attachDBPath.length && self.configuration.attachDBAlias.length, @"无法开启Attach");
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"ATTACH DATABASE %@ AS %@;", self.configuration.attachDBPath, self.configuration.attachDBAlias];
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {}
    }];
}

- (void)detachDB {
    NSAssert(self.configuration.attachDBPath.length && self.configuration.attachDBAlias.length, @"无法DETACH");
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSString *sql = [NSString stringWithFormat:@"DETACH DATABASE %@;", self.configuration.attachDBAlias];
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {}
    }];
}

- (void)close {
    [self.dbQueue close];
}

- (NSString *)stringWithSQL:(NSString*)sql params:(NSArray *)params {
    __block NSString *result;
    
    @try {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:params];
            while ([rs next]) {
                result = [rs stringForColumnIndex:0];
                break;
            }
            [rs close];
        }];
    }
    @catch (NSException *exception) {
        
    }
    return result;
}

- (NSInteger)integerWithSQL:(NSString*)sql params:(NSArray *)params {
    __block NSInteger result = 0;
    
    @try {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:params];
            while ([rs next]) {
                result = [rs intForColumnIndex:0];
                break;
            }
            
            [rs close];
        }];
    }
    @catch (NSException *exception) {}
    
    return result;
}

- (id)objectWithSQL:(NSString*)sql params:(NSArray *)params rowMapper:(RowMapper *)mapper {
    __block id result;
    
    @try {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:params];
            __weak typeof(rs) weakRS = rs;
            while ([rs next]) {
                if (!mapper || !mapper.rowMap) {
                    result = rs.resultDictionary;
                    break;
                }
                result = mapper.rowMap(weakRS);
                break;
            }
            
            [rs close];
        }];
    }
    @catch (NSException *exception) {
        
    }
    
    return result;

}
- (NSArray *)objectsWithSQL:(NSString*)sql params:(NSArray *)params rowMapper:(RowMapper *)mapper {
    NSMutableArray *result =[[NSMutableArray alloc] init];
    
    @try {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:params];
            __weak typeof(rs) weakRS = rs;
            while ([rs next]) {
                @autoreleasepool {
                    id obj;
                    if (mapper.rowMap) {
                        obj = mapper.rowMap(weakRS);
                    } else {
                        obj = rs.resultDictionary;
                    }
                    NSAssert(obj != nil, @"obj can not be nil !!!");
                    [result addObject:obj];
                }
            }
            [rs close];
        }];
    }
    @catch (NSException *exception) {
        NSLog(@"%s:%@", __func__, exception);
    }
    
    return result;
}

- (BOOL)updateOne:(NSString *)sql params:(NSArray *)params {
    __block BOOL result;
    
    @try {
        [self.dbQueue inDatabase:^(FMDatabase *db) {
            result = [db executeUpdate:sql withArgumentsInArray:params];
        }];
    }
    @catch (NSException *exception) {
        result = NO;
    }
    
    return result;
}

- (BOOL)updateBatch:(NSArray *)sqls params:(NSArray *)paramsArray {
    __block BOOL result;
    @try {
        [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for(int i=0; i < sqls.count; i++){
                NSString *sql = [sqls objectAtIndex:i];
                if (!sql.length) {
                    continue;
                }
                NSArray *params = nil;
                if (paramsArray) {
                    params = [paramsArray objectAtIndex:i];
                }
                result = [db executeUpdate:sql withArgumentsInArray:params];
                if (!result) {
                    *rollback = YES;
                    return;
                }
            }
        }];
    }
    @catch (NSException *exception) {
        result = NO;
    }
    
    return result;
}

- (BOOL)updateBatchExt:(NSString *)sql params:(NSArray *)paramsArray {
    __block BOOL result;
    @try {
        [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
            for(int i = 0; i < paramsArray.count; i++){
                NSArray *params = [paramsArray objectAtIndex:i];
                result = [db executeUpdate:sql withArgumentsInArray:params];
                if (!result) {
                    *rollback = YES;
                    return;
                }
            }
        }];
    }
    @catch (NSException *exception) {
        result = NO;
    }
    
    return result;
}


@end
