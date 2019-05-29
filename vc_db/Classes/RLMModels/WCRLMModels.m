//
//  WCSentenceFavorite.m
//  vci
//
//  Created by 齐江涛 on 2017/11/17.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "WCRLMModels.h"
#import "RLMRealm+WC.h"
@implementation WCSentenceFavorite

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"word"];
}

+ (NSString *)primaryKey {
    return @"sentenceID";
}

@end

@implementation WCNewWord

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"word"];
}

+ (NSString *)primaryKey {
    return @"wordID";
}

@end

@implementation WCAnnotation : RLMObject

+ (NSString *)primaryKey {
    return @"wordID";
}

+ (NSArray<NSString *> *)ignoredProperties {
    return @[@"obj"];
}

- (NSDictionary *)infoOfAnnotation {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:@(self.wordID) forKey:@"word_id"];
    [dict setObject:@(self.wordID) forKey:@"id"];
    [dict setObject:self.note forKey:@"note"];
    [dict setObject:@(self.timestamp) forKey:@"time"];
    [dict setObject:self.extra forKey:@"extra"];
    [dict setObject:@(self.flag) forKey:@"flag"];
    return dict;
}

@end

@implementation WCStudySurvey

+ (NSString *)primaryKey {
    return @"key";
}

+ (instancetype)defaultStudySurvey {
    WCStudySurvey *one = WCStudySurvey.new;
    one.bookID = 0;
    one.unitID = 0;
    one.type = 0;
    one.sourceID = 0;
    return one;
}

+ (void)updateWithBookID:(NSInteger)bid unitID:(NSInteger)uid type:(NSInteger)type sourceID:(NSString *)sid userInfo:(NSDictionary *)info {
    NSString *key = [NSString stringWithFormat:@"%zi-%zi-%zi-%@", bid, uid, type, sid];
    RLMRealm *realm = [RLMRealm studySurveyRealm];
    WCStudySurvey *survey = [self objectInRealm:realm forPrimaryKey:key];
    if (!survey) {
        survey = [WCStudySurvey new];
        survey.bookID = bid;
        survey.unitID = uid;
        survey.type = type;
        survey.sourceID = sid;
        survey.key = key;
    }
    [realm transactionWithBlock:^{
        WCStudySurveySub *sub = [[WCStudySurveySub alloc] init];
        sub.parentKey = key;
        id wobj = [info valueForKey:@"word_id"];
        if ([wobj isKindOfClass:NSNumber.class]) {
            sub.wordID = [wobj integerValue];
        }
        id uans = [info valueForKey:@"answer"];
        if ([uans isKindOfClass:NSString.class]) {
            sub.userAnswer = uans;
        } else {
            sub.userAnswer = @"";
        }
        id durobj = [info valueForKey:@"duration"];
        if ([durobj isKindOfClass:NSNumber.class]) {
            sub.duration = [durobj integerValue];
        }
        id ftobj = [info valueForKey:@"finish_time"];
        if ([ftobj isKindOfClass:NSNumber.class]) {
            sub.finishTime = [ftobj integerValue];
        }
        id resobj = [info valueForKey:@"result"];
        if ([resobj isKindOfClass:NSNumber.class]) {
            sub.correct = [resobj integerValue];
        }
        id tidobj = [info valueForKey:@"test_id"];
        if ([tidobj isKindOfClass:NSNumber.class]) {
            sub.questionID = [tidobj integerValue];
        }
        [survey.datas addObject:sub];
        [WCStudySurvey createOrUpdateInRealm:realm withValue:survey];
    }];
}

- (NSMutableDictionary *)infoOfStudySurvey {
    NSMutableDictionary *dict = @{}.mutableCopy;
    [dict setObject:@"" forKey:@"user_code"];
    [dict setObject:@(0) forKey:@"class_id"];
    [dict setObject:@(0) forKey:@"app_id"];
    [dict setObject:@(self.type) forKey:@"type"];
    [dict setObject:self.sourceID?:@"" forKey:@"source_id"];
    [dict setObject:@(self.bookID) forKey:@"book_id"];
    [dict setObject:@(self.unitID) forKey:@"unit_id"];
    return dict;
}

@end

@implementation WCStudySurveySub

- (NSDictionary *)infoOfStudySurveySub {
    NSInteger ret = self.correct ? 0 : 1;
    NSMutableDictionary *innerDict = @{}.mutableCopy;
    [innerDict setObject:@(self.wordID) forKey:@"word_id"];
    [innerDict setObject:@(self.questionID) forKey:@"test_id"];
    [innerDict setObject:@(self.duration) forKey:@"duration"];
    [innerDict setObject:@(ret) forKey:@"result"];
    [innerDict setObject:self.userAnswer forKey:@"answer"];
    [innerDict setObject:@(self.finishTime) forKey:@"finish_time"];
    return innerDict;
}

@end

@implementation WCWordKingStatus : RLMObject

+ (NSString *)primaryKey {
    return @"key";
}

@end

@implementation WCErrorQuestion : RLMObject

+ (NSString *)primaryKey {
    return @"key";
}

@end

@implementation WCHistoryWord

+ (NSString *)primaryKey {
    return @"wordID";
}

@end

@implementation WCReliveCardHistory

+ (NSString *)primaryKey {
    return @"date";
}

@end

@implementation WCMatchTimestamp

+ (NSString *)primaryKey {
    return @"key";
}

@end

@implementation WCValidSentenceCache

+ (NSString *)primaryKey {
    return @"key";
}

#pragma mark - API
+ (RLMResults *)recorderWithWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day {
    NSPredicate *predicate = [self predicateWithEdition:edition dataID:dataID day:day];
    RLMResults *result = [WCValidSentenceCache objectsWithPredicate:predicate];
    return result;
}

+ (BOOL)hasRecorderWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day {
    return [self recorderWithWithEdition:edition dataID:dataID day:day].count;
}

+ (void)cleanRecorderWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day {
    RLMResults *ret = [self recorderWithWithEdition:edition dataID:dataID day:day];
    [[RLMRealm defaultRealm] transactionWithBlock:^{
        [[RLMRealm defaultRealm] deleteObjects:ret];
    }];
}

+ (NSPredicate *)predicateWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"edition=%d AND dataID=%d AND day=%d", edition, dataID, day];
    return predicate;
}

@end

@implementation WCSentenceRecorderItem

+ (WCSentenceRecorderItem *)itemWithCategory:(NSInteger)category type:(NSInteger)type bookID:(NSInteger)bid edition:(NSInteger)edition {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"category=%@ AND type=%@ AND bookID=%@ AND edition=%@;", @(category), @(type), @(bid), @(edition)];
    RLMResults *results = [WCSentenceRecorderItem objectsInRealm:[RLMRealm sentenceRecorderRealm] withPredicate:predicate];
    WCSentenceRecorderItem *one = results.firstObject;
    return [one clone];
}

+ (void)updateItem:(WCSentenceRecorderItem *)item {
    switch (item.category) {
        case 1: {
            [self unitModeUpdate:item];
        } break;
        case 2: {
            [self phaseModeUpdate:item];
        } break;
        default:
            break;
    }
}

+ (void)unitModeUpdate:(WCSentenceRecorderItem *)item {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"category=%@", @(item.category)];
    RLMResults *r = [WCSentenceRecorderItem objectsInRealm:[RLMRealm sentenceRecorderRealm] withPredicate:p];
    if (r.count) {
        WCSentenceRecorderItem *one = r.firstObject;
        [[RLMRealm sentenceRecorderRealm] transactionWithBlock:^{
            one.unitID = item.unitID;
        }];
    } else {
        [[RLMRealm sentenceRecorderRealm] transactionWithBlock:^{
            [WCSentenceRecorderItem createInRealm:RLMRealm.sentenceRecorderRealm withValue:item];
        }];
    }
}

+ (void)phaseModeUpdate:(WCSentenceRecorderItem *)item {
    NSAssert(item.type != 3 || (item.type == 3 && item.topicID != 0), @"数据错误");
    NSPredicate *p = [NSPredicate predicateWithFormat:@"category=%@ AND edition=%@", @(item.category), @(item.edition)];
    RLMResults *r = [WCSentenceRecorderItem objectsInRealm:[RLMRealm sentenceRecorderRealm] withPredicate:p];
    if (r.count) {
        [[RLMRealm sentenceRecorderRealm] transactionWithBlock:^{
            [[RLMRealm sentenceRecorderRealm] deleteObjects:r];
        }];
    }
    [[RLMRealm sentenceRecorderRealm] transactionWithBlock:^{
        [WCSentenceRecorderItem createInRealm:RLMRealm.sentenceRecorderRealm withValue:item];
    }];
}

+ (void)deleteItem:(WCSentenceRecorderItem *)item {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"category=%@ AND edition=%@", @(item.category), @(item.edition)];
    RLMResults *r = [WCSentenceRecorderItem objectsInRealm:[RLMRealm sentenceRecorderRealm] withPredicate:p];
    if (r.count) {
        [[RLMRealm sentenceRecorderRealm] transactionWithBlock:^{
            [[RLMRealm sentenceRecorderRealm] deleteObjects:r];
        }];
    }
}

+ (WCSentenceRecorderItem *)itemForUnitCategory {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"category=1"];
    RLMResults *r = [WCSentenceRecorderItem objectsInRealm:[RLMRealm sentenceRecorderRealm] withPredicate:p];
    WCSentenceRecorderItem *one = r.firstObject;
    return [one clone];
}

+ (WCSentenceRecorderItem *)itemForPhaseWithBookID:(NSInteger)bid type:(NSInteger)type edition:(NSInteger)edition {
    NSPredicate *p;
    if (bid == 0 && type == 0) {
        p = [NSPredicate predicateWithFormat:@"category=2 AND edition=%@", @(edition)];
    } else {
        p = [NSPredicate predicateWithFormat:@"category=2 AND bookID=%@ AND type=%@ AND edition=%@", @(bid), @(type), @(edition)];
    }
    RLMResults *r = [WCSentenceRecorderItem objectsInRealm:[RLMRealm sentenceRecorderRealm] withPredicate:p];
    WCSentenceRecorderItem *one = r.firstObject;
    return [one clone];
}

- (WCSentenceRecorderItem *)clone {
    WCSentenceRecorderItem *one = WCSentenceRecorderItem.new;
    one.category = self.category;
    one.type = self.type;
    one.bookID = self.bookID;
    one.unitID = self.unitID;
    one.edition = self.edition;
    one.topicID = self.topicID;
    return one;
}

@end

@implementation WCHomeworkRecord

+ (NSString *)primaryKey {
    return @"workID";
}

@end
