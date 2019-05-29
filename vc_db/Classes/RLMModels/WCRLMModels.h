//
//  WCSentenceFavorite.h
//  vci
//
//  Created by 齐江涛 on 2017/11/17.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Realm/Realm.h>
#import "WCSentenceFavoriteInterface.h"
#import "WCNewWordInterface.h"

@interface WCSentenceFavorite : RLMObject<WCSentenceFavoriteInterface>

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
@property (nonatomic, copy  ) NSString *extra;

/**
 ignore
 */
@property (nonatomic, copy  ) NSString *word;

@end

@interface WCNewWord : RLMObject<WCNewWordInterface>

@property (nonatomic, assign) NSInteger edition;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, copy  ) NSString *userCode;
@property (nonatomic, assign) NSTimeInterval timestamp;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, copy  ) NSString *extra;

/**
 ignore
 */
@property (nonatomic, copy  ) NSString *word;

@end

/**
 单词笔记Model
 */
@interface WCAnnotation : RLMObject

@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, copy  ) NSString *note;
@property (nonatomic, copy  ) NSString *userCode;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, copy  ) NSString *extra;
@property (nonatomic, strong) id obj;

- (NSDictionary *)infoOfAnnotation;

@end

RLM_ARRAY_TYPE(WCStudySurveySub)
@interface WCStudySurveySub : RLMObject

@property (nonatomic, copy  ) NSString *parentKey;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, assign) NSInteger questionID;
@property (nonatomic, copy  ) NSString *userAnswer;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger correct;
@property (nonatomic, assign) NSInteger finishTime;

- (NSDictionary *)infoOfStudySurveySub;

@end

@interface WCStudySurvey : RLMObject

@property (nonatomic, copy  ) NSString *key;
@property (nonatomic, assign) NSInteger bookID;
@property (nonatomic, assign) NSInteger unitID;

/**
 1 - 计划, 2 - 作业, 3 - 竞技, 4 - 万词王, 5 - 单元检测, 6 - 单元闯关, 7 - 活动, 8 - 巩固, 9 - 错题, 10 - 遗忘曲线, 11 - 核心词汇检测, 12-生词本, 13-计划闯关, 14-课程, 15-学霸养成记
 */
@property (nonatomic, assign) NSInteger type;

/**
 type==1 -> 计划ID, type==2 -> 作业ID , 其它 -> 0
 */
@property (nonatomic, copy  ) NSString *sourceID;

/**
 JSON格式:{"word_id":23, "test_id":12, "answer":"A. take", "duration":239382943, "result":0, "finish_time":894839384}
 */
@property (nonatomic, strong) RLMArray<WCStudySurveySub *><WCStudySurveySub> *datas;
@property (nonatomic, assign) NSInteger teamID;
@property (nonatomic, copy  ) NSString *userCode;

+ (instancetype)defaultStudySurvey;
+ (void)updateWithBookID:(NSInteger)bid unitID:(NSInteger)uid type:(NSInteger)type sourceID:(NSString *)sid userInfo:(NSDictionary *)info;

- (NSMutableDictionary *)infoOfStudySurvey;

@end

@interface WCWordKingStatus : RLMObject

@property (nonatomic, copy) NSString *key;
@property (nonatomic, copy) NSString *userCode;
@property (nonatomic, assign) NSInteger teamID;
@property (nonatomic, assign) NSInteger finishTime;
@property (nonatomic, assign) NSInteger numberOfPass;
@property (nonatomic, assign) NSInteger appID;

@end

@interface WCErrorQuestion : RLMObject

@property (nonatomic, copy  ) NSString *key;    //构造联合主键, `questionID-from`组成, eg: 19832-1, 表示来自于课程的id为19832的题
@property (nonatomic, assign) NSInteger questionID;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, assign) NSInteger flag;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, copy  ) NSString *userAnswer;
@property (nonatomic, copy  ) NSString *json;   //题的JSON数据, 当本地库中没有题时, 会将此题加到这里
@property (nonatomic, assign) NSInteger from;   //来源: 0-本地, 1-课程, 2-闯关赛
@property (nonatomic, assign) NSInteger type;   //题型:1-基础题型; 2-听力; 3-阅读; 4-完形
@property (nonatomic, copy  ) NSString *extra;    //扩展字段

@end

@interface WCHistoryWord : RLMObject

@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, assign) NSInteger timestamp;

@end

@interface WCReliveCardHistory : RLMObject

/**
 日期
 */
@property (nonatomic, strong) NSString *date;

/**
 倒计时用时
 */
@property (nonatomic, assign) NSInteger duration;

/**
 是否领取了复活卡
 */
@property (nonatomic, assign) BOOL isGet;

@end

/**
 用于记录学霸养成记中相关的时间戳
 */
@interface WCMatchTimestamp : RLMObject

@property (nonatomic, copy  ) NSString *key;
@property (nonatomic, assign) NSInteger mid;
@property (nonatomic, assign) NSInteger pass;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, assign) NSInteger type;   //0-学霸养成记, 1-金句
@property (nonatomic, copy  ) NSString *JSON;

@end

@interface WCValidSentenceCache : RLMObject

/**
 主键, 格式为: edition-dataID-day-sentenceID
 */
@property (nonatomic, copy  ) NSString *key;
@property (nonatomic, assign) NSInteger edition;
@property (nonatomic, assign) NSInteger dataID;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger sentenceID;
@property (nonatomic, copy  ) NSString *userAnswer;
@property (nonatomic, assign) NSInteger currentPassFlag;    //是否为当前关

+ (BOOL)hasRecorderWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day;
+ (void)cleanRecorderWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day;
+ (RLMResults *)recorderWithWithEdition:(NSInteger)edition dataID:(NSInteger)dataID day:(NSInteger)day;

@end

/**
 金句学习记录
 */
@interface WCSentenceRecorderItem : RLMObject

@property (nonatomic, assign) NSInteger category;   //1-按单元学习; 2-按阶段学习
@property (nonatomic, assign) NSInteger type;       //1-初高中; 2-正常教材; 3-高考话题
@property (nonatomic, assign) NSInteger bookID;
@property (nonatomic, assign) NSInteger unitID;
@property (nonatomic, assign) NSInteger topicID;
@property (nonatomic, assign) NSInteger edition;

/**
 更新记录。

 @param item 新生成的item, 不可为查询出的item。
 */
+ (void)updateItem:(WCSentenceRecorderItem *)item;
+ (void)deleteItem:(WCSentenceRecorderItem *)item;
+ (WCSentenceRecorderItem *)itemWithCategory:(NSInteger)category type:(NSInteger)type bookID:(NSInteger)bid edition:(NSInteger)edition;
+ (WCSentenceRecorderItem *)itemForUnitCategory;
+ (WCSentenceRecorderItem *)itemForPhaseWithBookID:(NSInteger)bid type:(NSInteger)type edition:(NSInteger)edition;

@end

@interface WCHomeworkRecord : RLMObject

@property (nonatomic, copy  ) NSString *workID;     //作业缓存主键：homeworkID-day组成用来标识唯一性
@property (nonatomic, assign) NSInteger homeworkID;
@property (nonatomic, assign) NSInteger day;
@property (nonatomic, copy  ) NSString *content;
@property (nonatomic, assign) NSInteger round;
@property (nonatomic, assign) NSInteger isRevising;

@end
