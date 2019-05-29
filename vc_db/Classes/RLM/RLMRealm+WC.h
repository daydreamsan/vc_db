//
//  RLMRealm+WC.h
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/12.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Realm/Realm.h>

extern NSString *RWUser;
extern NSString *RWMediaURLRecord;
extern NSString *RWSentenceFavorite;
extern NSString *RWNewWord;
extern NSString *RWAnnotation;
extern NSString *RWStudySurvey;
extern NSString *RWWordKing;
extern NSString *RWErrorQuestion;
extern NSString *RWHistoryWord;
extern NSString *RWAPI;
extern NSString *RWReliveTimer;

@interface RLMRealm (WC)

+ (instancetype)userRealm;
+ (instancetype)mediaURLRecordRealm;
+ (instancetype)sentenceFavoriteRealm;
+ (instancetype)freshWordRealm;
+ (instancetype)annotationRealm;
+ (instancetype)studySurveyRealm;
+ (instancetype)wordKingRealm;
+ (instancetype)errorQuestionRealm;
+ (instancetype)historyWordRealm;
+ (instancetype)reliveTimerRealm;
+ (instancetype)sentenceRecorderRealm;
+ (instancetype)homeworkRecorderRealm;
+ (instancetype)reportRealm;

+ (NSURL *)urlWithName:(NSString *)name;

#pragma mark - DEBUG
+ (instancetype)apiRealm;

@end
