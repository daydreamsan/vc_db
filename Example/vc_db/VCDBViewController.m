//
//  VCDBViewController.m
//  vc_db
//
//  Created by daydreamsan on 05/28/2019.
//  Copyright (c) 2019 daydreamsan. All rights reserved.
//

#import "VCDBViewController.h"
#import <BaseDAO.h>
#import <WCWordModel.h>

@interface VCDBViewController ()

@property (nonatomic, strong) BaseDAO *dao;

@end

@implementation VCDBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DBConfiguration *config = DBConfiguration.new;
    config.path = [[NSBundle mainBundle] pathForResource:@"weicigz.db" ofType:nil];
    self.dao = [BaseDAO daoWithConfiguration:config];
    
    RowMapper *rowmapper = [RowMapper mapperWithRowMap:^id(FMResultSet *rs) {
        WCWord *w = [[WCWord alloc] initWithDict:rs.resultDictionary];
        return w;
    }];
    NSArray *obj = [self.dao objectsWithSQL:@"SELECT fb_word.id fb_word_id, * from fb_word, fb_word_sub where fb_word.id=fb_word_sub.word_id and fb_word.`delete`=0 and fb_word_sub.unit_id=? order by sort;" params:@[@17] rowMapper:rowmapper];
    NSLog(@"-\n\n\n个数: %ld", obj.count);
}

@end
