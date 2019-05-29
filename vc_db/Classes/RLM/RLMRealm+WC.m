//
//  RLMRealm+WC.m
//  WCJunior
//
//  Created by 齐江涛 on 2017/4/12.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import "RLMRealm+WC.h"

NSString *RWRealm = @"Realm";

NSString *RWUser                 = @"user.realm";
NSString *RWMediaURLRecord       = @"media_url.realm";
NSString *RWSentenceFavorite     = @"sentence_favorite.realm";
NSString *RWNewWord              = @"newword.realm";
NSString *RWAnnotation           = @"annotation.realm";
NSString *RWStudySurvey          = @"studysurvey.realm";
NSString *RWWordKing             = @"wordKing.realm";
NSString *RWErrorQuestion        = @"errorQuestion.realm";
NSString *RWHistoryWord          = @"historyWord.realm";
NSString *RWAPI                  = @"apilog.realm";
NSString *RWReliveTimer          = @"reliveTimer.realm";
NSString *RWSentenceRecorder     = @"RWSentenceRecorder.realm";
NSString *RWHomeworkRecorder     = @"RWHomeworkRecorder.realm";
NSString *RWReport               = @"report.realm";

/*
static NSString *RWWordSearch   = @"word_search.realm";
static NSString *RWWordnote     = @"wordnote.realm";
*/

@implementation RLMRealm (WC)

+ (instancetype)userRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWUser];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWUser];
    }
}

+ (instancetype)mediaURLRecordRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWMediaURLRecord];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWMediaURLRecord];
    }
}

+ (instancetype)sentenceFavoriteRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWSentenceFavorite];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWSentenceFavorite];
    }
}

+ (instancetype)freshWordRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWNewWord];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWNewWord];
    }
}

+ (instancetype)annotationRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWAnnotation];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWAnnotation];
    }
}

+ (instancetype)studySurveyRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWStudySurvey];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWStudySurvey];
    }
}

+ (instancetype)wordKingRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWWordKing];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWWordKing];
    }
}

+ (instancetype)errorQuestionRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWErrorQuestion];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWErrorQuestion];
    }
}

+ (instancetype)historyWordRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWHistoryWord];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWHistoryWord];
    }
}

+ (instancetype)apiRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWAPI];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWAPI];
    }
}

+ (instancetype)reliveTimerRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWReliveTimer];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWReliveTimer];
    }
}

+ (instancetype)sentenceRecorderRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWSentenceRecorder];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWSentenceRecorder];
    }
}

+ (instancetype)homeworkRecorderRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t oneceToken;
        dispatch_once(&oneceToken, ^{
            realm = [self createRealmWithName:RWHomeworkRecorder];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWHomeworkRecorder];
    }
}

+ (instancetype)reportRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t oneceToken;
        dispatch_once(&oneceToken, ^{
            realm = [self createRealmWithName:RWReport];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWReport];
    }
}

/*
+ (instancetype)wordSearchRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWWordSearch];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWWordSearch];
    }
}

+ (instancetype)wordnoteRealm {
    if ([NSThread isMainThread]) {
        static RLMRealm *realm = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            realm = [self createRealmWithName:RWWordnote];
        });
        return realm;
    } else {
        return [self createRealmWithName:RWWordnote];
    }
}

*/
/* 
 
    add your code here, like this:
+ (instancetype)xxxRealm {
 
 }

 
 */




+ (instancetype)createRealmWithName:(NSString *)name {
    NSURL *fileURL = [self urlWithName:name];
    RLMRealm *realm = [RLMRealm realmWithURL:fileURL];
    return realm;
}

+ (NSURL *)urlWithName:(NSString *)name {
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *realmPath = [cachePath stringByAppendingPathComponent:RWRealm];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:realmPath]) {
        [fileManager createDirectoryAtPath:realmPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    NSString *file = [realmPath stringByAppendingPathComponent:name];
    NSURL *fileURL = [NSURL fileURLWithPath:file];
    return fileURL;
}

@end
