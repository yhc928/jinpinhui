//
//  UMSocialHelper.m
//  doctor
//
//  Created by 陈震 on 15/9/6.
//  Copyright (c) 2015年 chenzhen. All rights reserved.
//

#import "UMSocialHelper.h"

@implementation UMSocialHelper

//初始化友盟分享
+ (void)startUMSocial
{
    [UMSocialData setAppKey:UMSOCIAL_KEY];
    
    //由于苹果审核政策需求，在设置QQ、微信AppID之前调用下面的方法
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToWechatTimeline,
                                                UMShareToWechatSession,
                                                UMShareToQQ]];
    
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WX_APPID appSecret:WX_APPSECRET url:nil];
    
    //设置分享到QQ/Qzone的应用Id，和分享url链接
    [UMSocialQQHandler setQQWithAppId:QQ_APPID appKey:QQ_APPKEY url:nil];
}

//分享的方法
+ (void)shareWithModel:(id)model viewController:(UIViewController *)viewController
{
    if (model) {
        [UMSocialSnsService presentSnsIconSheetView:viewController
                                             appKey:UMSOCIAL_KEY
                                          shareText:@"金品汇改变您的生活"
                                         shareImage:[UIImage imageNamed:@"about_us_icon"]
                                    shareToSnsNames:@[UMShareToWechatTimeline,
                                                      UMShareToWechatSession,
                                                      UMShareToQQ,
                                                      UMShareToSms]
                                           delegate:nil];
        
        //通用设置图片
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:nil];
        NSString *share_url = @"www.baidu.com";
        
        //微信朋友圈
        [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"金品汇";
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = share_url;
        [UMSocialData defaultData].extConfig.wechatTimelineData.wxMessageType = UMSocialWXMessageTypeWeb;
        
        //微信好友
        [UMSocialData defaultData].extConfig.wechatSessionData.title = @"金品汇";
        [UMSocialData defaultData].extConfig.wechatSessionData.url = share_url;
        [UMSocialData defaultData].extConfig.wechatSessionData.wxMessageType = UMSocialWXMessageTypeWeb;
        
        //QQ
        [UMSocialData defaultData].extConfig.qqData.title = @"金品汇";
        [UMSocialData defaultData].extConfig.qqData.url = share_url;
        [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeDefault;
    }
}

//检查微信是否安装
+ (BOOL)isWechatInstalled
{
    return [WXApi isWXAppInstalled];
}

//微信登录
+ (void)wechatLoginWithViewController:(UIViewController *)viewController
{
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    snsPlatform.loginClickHandler(viewController,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response) {
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToWechatSession];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
            //得到的数据在回调Block对象形参respone的data属性
            [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession completion:^(UMSocialResponseEntity *response){
                NSLog(@"SnsInformation is %@",response.data);
            }];
        }
    });
}

@end
