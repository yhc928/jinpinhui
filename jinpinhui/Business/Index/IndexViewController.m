//
//  IndexViewController.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "IndexViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TitleCollectionView *titleCollectionView = [[TitleCollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 33)];
    [self.view addSubview:titleCollectionView];
    
    //数据
    titleCollectionView.dataArray = @[@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划",@"精选推荐",@"阳光私募",@"信托产品",@"资管计划"];
    
    [titleCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
                                      animated:YES
                                scrollPosition:UICollectionViewScrollPositionNone];
    
    UIScrollView *bgScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 33, SCREEN_WIDTH, SCREEN_HEIGHT-64-33)];
    bgScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*titleCollectionView.dataArray.count, 0);
    bgScrollView.pagingEnabled = YES;
    [self.view addSubview:bgScrollView];
    
    CGRect frame = bgScrollView.bounds;
    
    for (int i = 0; i < titleCollectionView.dataArray.count; i++) {
        frame.origin.x = i*SCREEN_WIDTH;
        if (i == 0) {
            FirstViewController *firstVC = [[FirstViewController alloc] init];
            [self addChildViewController:firstVC];
            firstVC.view.frame = frame;
            [bgScrollView addSubview:firstVC.view];
        } else {
            SecondViewController *secondVC = [[SecondViewController alloc] init];
            [self addChildViewController:secondVC];
            secondVC.view.frame = frame;
            [bgScrollView addSubview:secondVC.view];
            
            if (i % 2 == 0) {
                secondVC.view.backgroundColor = [UIColor greenColor];
            } else {
                secondVC.view.backgroundColor = [UIColor redColor];
            }
        }
        
        
    }
    
//    [self requestUserAction];
    
}

#pragma mark - CZRequestHelperDelegate
- (void)czRequestForResultDic:(NSDictionary *)resultDic code:(NSInteger)code object:(id)obj
{
    NSLog(@"resultDic = %@",resultDic);
}

/**
 *  request
 */
- (void)requestBin_cmd
{
    NSDictionary *parameters = @{@"username":@"123",
                                 @"password":@"a234",
                                 @"cmd":@"reg",
                                 @"date":@"2015-06-28 16:36:20",
                                 @"md5":@"deda6cfcf3c03080"};
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getBin_cmdWithParameters:parameters];
    [self jsonWithRequest:request delegate:self code:111 object:nil];
}

- (void)requestUserAction
{
    NSDictionary *parameters = @{@"connector":@"homeRedPort",
                                 @"account":@"13141215988"};
    
    CZRequestModel *request = [[CZRequestMaker sharedClient] getUserActionWithParameters:parameters];
    [self jsonWithRequest:request delegate:self code:112 object:nil];
}

@end
