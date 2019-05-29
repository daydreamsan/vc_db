//
//  WCWordInterface.h
//  vci
//
//  Created by 齐江涛 on 2017/11/8.
//  Copyright © 2017年 daydream. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@protocol WCWordInterface <NSObject, NSCopying>

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

///<首字母
@property (nonatomic, copy) NSString *initial;

@optional
///<json格式字符串, 在课程相关单词中用到
@property (nonatomic, copy) NSString *example;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSString<Optional> *followWord; //用于跟读评测

@end
