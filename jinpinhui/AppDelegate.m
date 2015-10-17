//
//  AppDelegate.m
//  jinpinhui
//
//  Created by xiao7 on 15/7/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworkActivityIndicatorManager.h" //AFNetworking状态栏指示器
#import "AFNetworkReachabilityManager.h"      //AFNetworking网络检测
#import "UMSocialHelper.h"

#import "MyDrawerViewController.h"

#import "IndexViewController.h"
#import "LeftSideViewController.h"
#import "RightSideViewController.h"
#import "LoginViewController.h"
#import "AuthenticationViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //打开网络请求状态栏指示器
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    //检测网络状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //-1 未知 0 无连接 1 3G 2 WIFI
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
        }
    }];
    
    //友盟分享
    [UMSocialHelper startUMSocial];
    
    //导航栏通用设置 标题颜色：白色 按钮颜色：白色
    UIImage *navBgImage = nil;
    if (IS_IOS_7) {
        navBgImage = [UIImage imageNamed:@"navbarbackios7"];
        navBgImage = [navBgImage resizableImageWithCapInsets:UIEdgeInsetsZero
                                                resizingMode:UIImageResizingModeStretch];
    } else {
        navBgImage = [UIImage imageNamed:@"navbarbackios6"];
    }
    
    [[UINavigationBar appearance] setBackgroundImage:navBgImage
                                       forBarMetrics:UIBarMetricsDefault];
    
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
    
    //首页
    IndexViewController *indexVC = [IndexViewController sharedClient];
    UINavigationController *indexNav = [[UINavigationController alloc] initWithRootViewController:indexVC];
    
    //左侧边栏
    LeftSideViewController *leftSideVC = [[LeftSideViewController alloc] init];
    leftSideVC.indexNav = indexNav;
    
    //右侧边栏
    RightSideViewController *rightSideVC = [[RightSideViewController alloc] init];
    self.drawerController = [[MyDrawerViewController alloc] initWithCenterViewController:indexNav
                                                                leftDrawerViewController:leftSideVC
                                                               rightDrawerViewController:rightSideVC];
    
    self.drawerController.showsShadow = YES;
    self.drawerController.shouldStretchDrawer = NO;
    self.drawerController.maximumLeftDrawerWidth = SCREEN_WIDTH-55;
    self.drawerController.maximumRightDrawerWidth = SCREEN_WIDTH-55;
    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    
    //直接进入首页、还是主页
    NSString *loginStatus = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:LOGINSTATUS]];
    if (!NULL_STR(loginStatus) && [loginStatus isEqualToString:@"2"]) {
        self.window.rootViewController =  [[UINavigationController alloc] initWithRootViewController:self.drawerController];
    } else {
        self.window.rootViewController =  [[UINavigationController alloc] initWithRootViewController:[LoginViewController new]];
    }
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

//打开第三方app的系统回调
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    //友盟url回调
    return [UMSocialSnsService handleOpenURL:url];
}

//打开第三方app的系统回调
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //友盟url回调
    return [UMSocialSnsService handleOpenURL:url];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
