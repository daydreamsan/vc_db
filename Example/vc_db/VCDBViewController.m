//
//  VCDBViewController.m
//  vc_db
//
//  Created by daydreamsan on 05/28/2019.
//  Copyright (c) 2019 daydreamsan. All rights reserved.
//

#import "VCDBViewController.h"
#import <BaseDAO.h>

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
    
    NSDictionary *obj = [self.dao objectWithSQL:@"select * from fb_word where id=?" params:@[@71] rowMapper:nil];
    NSLog(@"%@", obj);
}

@end
