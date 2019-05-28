//
//  WCWordModel.h
//  VictorWeici
//
//  Created by qijiangtao on 16/7/30.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>
#import "WCWordInterface.h"

#pragma mark - 版本
@interface WCEdition : JSONModel

@property (nonatomic, assign) NSInteger editionID;
@property (nonatomic, copy  ) NSString  *fullName;
@property (nonatomic, copy  ) NSString  *bookEdition;
@property (nonatomic, assign) NSInteger order;
@property (nonatomic, assign) NSInteger version;

@end

#pragma mark - 书
@interface WCBook : JSONModel

///<图书id
@property (nonatomic, assign) NSInteger bookID;

///<版本ID
@property (nonatomic, assign) NSInteger editionID;

///<书名:七年级、八年级...
@property (nonatomic, copy) NSString<Optional> *book;

///<分册名:冀教版、人教版...
@property (nonatomic, copy) NSString<Optional> *editionName;

///<描述:上册、下册...
@property (nonatomic, copy) NSString<Optional> *desc;

///<版本信息
@property (nonatomic, assign) NSInteger version;

@end

#pragma mark - 单元
@interface WCUnit : JSONModel

///<单元id
@property (nonatomic, assign) NSInteger unitID;

///<版本ID
@property (nonatomic, assign) NSInteger editionID;

///<书的id
@property (nonatomic, assign) NSInteger bookID;

///<单元
@property (nonatomic, copy) NSString *unit;

///<描述
@property (nonatomic, copy) NSString *desc;

///<版本
@property (nonatomic, assign) NSInteger version;

///<简称
@property (nonatomic, copy) NSString<Optional> *simple;

@end

#pragma mark - 单词

/**
 单词模型的基础源是fb_word表与fb_word_sub表的连接,
 因为这两个表中的id列同名，所以将fb_word.id AS 为fb_word_id,
 同时，将fb_word_sub.id AS 为fb_word_sub_id
 */
@interface WCWord : JSONModel <WCWordInterface>

///<针对课程所设置，在gy_course_word中 id<->key, word_id<->wordID.在fb_word中id<->wordID,id<->key
@property (nonatomic, assign) NSInteger key;

///<单词id
@property (nonatomic, assign) NSInteger wordID;

@property (nonatomic, assign) NSInteger unitID;
@property (nonatomic, assign) NSInteger bookID;
@property (nonatomic, assign) NSInteger editionID;
@property (nonatomic, assign) NSInteger sort;

///<单词
@property (nonatomic, copy) NSString<Optional> *word;

///<词性
@property (nonatomic, copy) NSString<Optional> *partOfSpeech;

///<口语级别 [0,1,..., 5]
@property (nonatomic, assign) NSInteger lvSpeak;

///<书写级别 [0,1,..., 5]
@property (nonatomic, assign) NSInteger lvWrite;

///<阅读级别 [0,1,..., 5]
@property (nonatomic, assign) NSInteger lvRead;

///<词频级别 [0,1,..., 5]
@property (nonatomic, assign) NSInteger lvFrequency;

///<重难点词汇, 0-否, 1-是
@property (nonatomic, assign) NSInteger point;

///<课标外词汇, 0-无, 1-课标外词汇, 2-课标派词汇
@property (nonatomic, assign) NSInteger outpoint;

///<汉语释义同义词
@property (nonatomic, copy) NSString<Optional> *extend;

///<单词释义
@property (nonatomic, copy) NSString<Optional> *chinese;

///<跳转参考词
@property (nonatomic, copy) NSString<Optional> *jump;

///<替换词id
@property (nonatomic, strong) NSNumber<Optional> * replaceID;

///<版本号
@property (nonatomic, assign) NSInteger version;

///<搜索时需要参考此字段,0-显示，1-不显示
@property (nonatomic, assign) NSInteger showType;

///<音频、音标
@property (nonatomic, copy) NSString *enFile;
@property (nonatomic, copy) NSString *usaFile;
@property (nonatomic, copy) NSString *enPhoneticSymbols;
@property (nonatomic, copy) NSString *usaPhoneticSymbols;

///<0-单词, 1-固定搭配
@property (nonatomic, assign) NSInteger wordType;

/**
 首字母
 */
@property (nonatomic, copy) NSString<Optional> *initial;

/**
 单词上挂了几个视频
 */
@property (nonatomic, assign) NSInteger numberOfVideo;
@property (nonatomic, copy  ) NSString *imageURLString;

@property (nonatomic, copy  ) NSString<Optional> *example;

@property (nonatomic, assign) NSInteger score;

@property (nonatomic, strong) id<Ignore> obj;

@property (nonatomic, copy) NSString<Optional> *followWord;//跟读测试时送给评测引擎的文本

- (instancetype)initWithDict:(NSDictionary *)dict;

@end

#pragma mark - 单词详情
@interface WCWordDetail : JSONModel

///<单词详情id
@property (nonatomic, assign) NSInteger wordDetailID;

///<单词
@property (nonatomic, copy) NSString *word;

///<词性
@property (nonatomic, copy) NSString *partOfSpeech;

///<详情json
@property (nonatomic, copy) NSString *detailJSON;

///<扩展json
@property (nonatomic, copy) NSString *extendJSON;

///<版本
@property (nonatomic, assign) NSInteger version;

@end

#pragma mark - 话题
@class WCTopicElement;
@interface WCTopic : JSONModel

/**
 话题ID
 */
@property (nonatomic, assign) NSInteger topicID;

/**
 一级目录名称
 */
@property (nonatomic, copy) NSString *name;

/**
 子级JSON
 */
@property (nonatomic, copy) NSString *topics;

- (NSArray<WCTopicElement *> *)childObjects;

@end

#pragma mark - 话题
@interface WCTopicElement : NSObject

@property (nonatomic, assign) NSInteger elementID;
@property (nonatomic, copy  ) NSString *name;

@end

#pragma mark - 单词图片
@interface WCWordImage : JSONModel

@property (nonatomic, assign) NSInteger imageID;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, copy  ) NSString<Ignore> *imageURLString;

@end

#pragma mark - 单词视频
@interface WCWordVideo : JSONModel

@property (nonatomic, assign) NSInteger videoID;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, copy  ) NSString<Ignore> *videoURLString;
@property (nonatomic, copy  ) NSString<Ignore> *imageURLString;
@property (nonatomic, copy  ) NSString *title;
@property (nonatomic, copy  ) NSString *subtitle;
@property (nonatomic, copy  ) NSString *time;
@property (nonatomic, copy  ) NSString<Ignore> *captionURLString;

@end

@interface WCExampleSentence : JSONModel

@property (nonatomic, assign) NSInteger sentenceID;
@property (nonatomic, assign) NSInteger wordID;
@property (nonatomic, copy  ) NSString *english;
@property (nonatomic, copy  ) NSString *chinese;
@property (nonatomic, copy  ) NSString *highlight;
@property (nonatomic, copy  ) NSString *sound;
@property (nonatomic, copy  ) NSString *source;

@end
