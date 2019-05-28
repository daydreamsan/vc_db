//
//  WCWordModel.m
//  VictorWeici
//
//  Created by qijiangtao on 16/7/30.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "WCWordModel.h"
#import <YYModel/YYModel.h>

@implementation WCEdition : JSONModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"editionID":@"id",
                                                                  @"fullName":@"full_name",
                                                                  @"bookEdition":@"book_version",
                                                                  @"order":@"order_by"
                                                       }];
}

@end

///<图书模型
@implementation WCBook

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"bookID":@"id",
                                                                  @"editionID":@"version_id",
                                                                  @"editionName":@"book_name",
                                                                  @"desc":@"description"
                                                       }];
}

@end

///<图书单元模型
@implementation WCUnit

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"unitID":@"id",
                                                                  @"editionID":@"version_id",
                                                                  @"bookID":@"book_id",
                                                                  @"desc":@"description"
                                                       }];
}

@end

///<单词模型
@implementation WCWord

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.chinese = dict[@"chinese"];
        self.extend = dict[@"extend"];
        _wordID = [dict[@"fb_word_id"] integerValue];
        if (!_wordID) {
            id obj = dict[@"word_id"];
            if (![obj isKindOfClass:[NSNumber class]]) {
                obj = @0;
            }
            _wordID = [obj integerValue];
        }
        if (!_wordID) {
            id obj = dict[@"id"];
            if (![obj isKindOfClass:[NSNumber class]]) {
                obj = @0;
            }
            _wordID = [obj integerValue];
        }
        id obj = [dict objectForKey:@"id"];
        if (![obj isKindOfClass:[NSNumber class]]) {
            obj = @0;
        }
        _key = [obj integerValue];
        id unitID = dict[@"unit_id"];
        if ([unitID isKindOfClass:[NSNumber class]]) {
            _unitID = [unitID integerValue];
        }
        id bookID = dict[@"book_id"];
        if ([bookID isKindOfClass:[NSNumber class]]) {
            _bookID = [bookID integerValue];
        }
        id editionID = dict[@"edition_id"];
        if ([editionID isKindOfClass:[NSNumber class]]) {
            _editionID = [editionID integerValue];
        }
        id sort = dict[@"sort"];
        if ([sort isKindOfClass:[NSNumber class]]) {
            _sort = [sort integerValue];
        }
        self.jump = dict[@"jump"];
        _lvFrequency = [dict[@"lv_frequency"] integerValue];
        _lvRead = [dict[@"lv_read"] integerValue];
        _lvSpeak = [dict[@"lv_speak"] integerValue];
        _lvWrite = [dict[@"lv_write"] integerValue];
        _point = [dict[@"point"] integerValue];
        _outpoint = [dict[@"outpoint"] integerValue];
        self.partOfSpeech = dict[@"part_of_speech"];
        self.replaceID = dict[@"replace_id"];
        _showType = [dict[@"show_type"] integerValue];
        self.word = dict[@"word"];
        _wordType = [dict[@"word_type"] integerValue];
        self.enFile = dict[@"en_file"];
        self.usaFile = dict[@"usa_file"];
        self.enPhoneticSymbols = dict[@"en_phonetic_symbols"];
        self.usaPhoneticSymbols = dict[@"usa_phonetic_symbols"];
        _version = [dict[@"version"] integerValue];
        
        _numberOfVideo = [dict[@"count"] integerValue];
        _initial = [dict[@"initial"] stringValue];
        self.imageURLString = [dict[@"video_image_url"] stringValue];
        self.example = [dict[@"example"] stringValue];
        self.score = [dict[@"score"] integerValue];
        self.followWord = [dict[@"follow_word"] stringValue];
    }
    return self;
}

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
             @"wordID":@[@"id", @"fb_word_id"]
            };
}

@end

///<单词详情模型
@implementation WCWordDetail
+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"wordDetailID":@"id",
                                                                  @"partOfSpeech":@"part_of_speech",
                                                                  @"detailJSON":@"detail_json",
                                                                  @"extendJSON":@"extend_json"
                                                       }];
}

@end

@implementation WCTopic

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"topicID":@"id",
                                                                  }];
}

- (NSArray<WCTopicElement *> *)childObjects {
    if (!self.topics.length) {
        return nil;
    }
    NSData *data = [self.topics dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    NSMutableArray *rets = @[].mutableCopy;
    for (NSDictionary *one in obj) {
        WCTopicElement *ele = [WCTopicElement yy_modelWithDictionary:one];
        if (ele) {
            [rets addObject:ele];
        }
    }
    return rets;
}

@end

@implementation WCTopicElement

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
             @"elementID":@"id"
             };
}

@end

@implementation WCWordImage

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"imageID":@"id",
                                                                  @"wordID":@"word_id",
                                                                  @"imageURLString":@"image_url"
                                                                  }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if (self = [super initWithDictionary:dict error:err]) {
        self.imageURLString = [dict objectForKey:@"image_url"];
    }
    return self;
}

@end

@implementation WCWordVideo

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"videoID":@"id",
                                                                  @"wordID":@"word_id",
                                                                  @"videoURLString":@"video_url",
                                                                  @"imageURLString":@"video_image_url",
                                                                  @"subtitle":@"title_sub",
                                                                  @"captionURLString":@"video_caption_url"
                                                                  }];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    if (self = [super initWithDictionary:dict error:err]) {
        self.captionURLString = [dict objectForKey:@"video_caption_url"];
        self.imageURLString = [dict objectForKey:@"video_image_url"];
        self.videoURLString = [dict objectForKey:@"video_url"];
    }
    return self;
}

@end

@implementation WCExampleSentence

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"sentenceID":@"id",
                                                                  @"wordID":@"word_id"
                                                                  }];
}

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
             @"sentenceID":@"id",
             @"wordID":@"word_id"
             };
}

@end

