//
//  LSDUtils.h
//  VideoShake
//
//  Created by LiuLi on 2018/9/17.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 仅在debug模式输出日志
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

// 颜色工具
// 颜色(RGB)
// rgb颜色转换（16进制->10进制）
#define HexColor(rgbValue)      [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define RGBA(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

/** 项目主色  */
#define MainColor HexColor(0x130D14)
/** 分割线的色儿  */
#define kLineColor RGBA(255.0, 255.0, 255.0, 0.2)
#define kBgColor RGBA(0, 0, 0, 0.6)
#define kBlackColorAlph(VALUE) RGBA(0, 0, 0, VALUE)
#define kWhiteColorAlph(VALUE) RGBA(255.0, 255.0, 255.0, VALUE)

// 常用文字的颜色
/** 白色  */
#define MainColor0 HexColor(0xFFFFFF)
/** 红色  */
#define MainColor1 HexColor(0xFF328B)

// 手机别名： 用户定义的名称
#define DeviceName [[UIDevice currentDevice] name]
// 获取当前build号
#define CFBundleBuild  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// 获取当前app的版本Version （例如：1.0.0）
#define CFBundleVersion   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 获取当前设备的版本 （iOS号码）
#define KSystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]
/** 存版本号  */
#define kOldVerson @"oldVerson"

// 手机型号判断
//4s, 5，5s手机
#define IPhone5                (([UIScreen mainScreen].bounds.size.width <= 320.0 && [UIScreen mainScreen].bounds.size.height <= 568.0) ? (YES) : (NO) )
#define Iphone6 (([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==667))
#define Iphone6P (([UIScreen mainScreen].bounds.size.width==414&&[UIScreen mainScreen].bounds.size.height==736))
#define IphoneX  (([UIScreen mainScreen].bounds.size.width==375&&[UIScreen mainScreen].bounds.size.height==812))

//  尺寸相关
#define SCREEN_Frame  [[UIScreen mainScreen] bounds]
#define SCREEN_W  [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H [[UIScreen mainScreen] bounds].size.height
#define kNavHeight (IphoneX==YES ? 88 : 64) // 状态栏+导航栏
#define kTabBarH (IphoneX==YES ? 83 : 49) // 底部tabBar高度

#define Rate UIScreen.mainScreen.bounds.size.width/375   //屏宽比例
#define KLineH 0.5 // 分割线的高

// weakSelf
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF __strong __typeof(self) strongSelf = weakSelf;

//判断字符串是否为空
#define ISEMPTY(_v) (_v == nil || _v.length == 0 || [_v isKindOfClass:[NSNull class]])

@interface LSDUtils : NSObject

/** 生成唯一码/获取uuid（uuid的特性：每次运行都会发生变化）  */
NSString *getUUIDStr(void);

/**
 从KeyChain中读取存储的字符串 没有则自动保存
 */
//NSString *keyChainCheckUUIDString(void);

/** 第一次安装 || 更新版本了  */
BOOL isFirstLaunchOrUploadNew(void);

/** 手机号格式验证  */
BOOL isPhoneNumberStr(NSString *str);
/** 密码格式验证  */
BOOL isPassWordStr(NSString *str);
/** 邮箱号码格式验证  */
BOOL isValidateEmail(NSString *email);
/** 中文格式验证  */
BOOL isChineseChar(NSString *str);
/** 表情格式验证  */
BOOL isEmojiStr(NSString *str);
/** 数字格式验证  */
BOOL isNumberStr(NSString *str);
/** 有效网址格式验证  */
BOOL isValidateUrl(NSString *url);
/** 判断字符串是int类型  */
BOOL isPureInt(NSString *string);
/** 判断字符串是否为浮点形  */
BOOL isPureFloat(NSString *string);
/** 是iPhoneX  */
BOOL isiPhoneX(void);
/** 获取用户id  */
NSString *getUserId(void);
/** 是否登陆了  */
BOOL isLogin(void);
/** 去登陆  */
void toLogin(UIViewController *vc);
/** 获取手机类型iPhone几  */
NSString *isPhoneType(void);

/** 获取格式化时间字符串  */
NSString* getTimeStringWithDate(NSDate *date, NSString *style);
/** 获取格式化时间  doubleDateStr：double */
NSString *getTimeFromDoubleDateStr(NSString *doubleDateStr, NSString *style);
/** 获取与当前时间的间隔  doubleDateStr：double */
NSString *getTimeIntervalSinceDate(NSString *doubleDateStr);
/** 比较两个时间早晚  */
int compareDate(NSDate *startDate, NSDate *endDate);
/** 数组转成字符串  */
NSString *arrayToJSONString(NSArray *array);
/** 字符串转成数组 */
NSArray *stringToArray(NSString *jsonArray);
/** 字符串宽度(不限) */
CGFloat getStringWidth(NSString *str , CGFloat font);
/** 字符串宽度(固定宽) */
CGFloat getStringWidthWithMaxW(NSString *str , CGFloat font, CGFloat maxW);

typedef void(^SureAction)(void);
typedef void(^CancelAction)(void);
/** 弹出系统AlertView  */
void showSystemAlertView(NSString *title, NSString *message, NSString *sure, NSString *cancel, UIViewController *vc, SureAction sureActionBlock, CancelAction cancelActionBlock);

// 进度条处理
/** 菊花 + 半透明背景 添加到window
 移除调用：hideHud
 */
void showHud(void);
/** 菊花 + 文字 + 半透明背景 添加到window
 移除调用：hideHud
 */
void showHudWithText(NSString *text);
void hideHud(void);

/** 菊花 + 半透明背景 添加到指定view
    移除调用：hideHudWithView
 */
void showHudWithView(UIView *view);
/** 菊花 + 文字 + 半透明背景 添加到指定view
 移除调用：hideHudWithView
 */
void showHudWithTextInView(NSString *text, UIView *view);
void hideHudWithView(UIView *view);

/** 菊花 + 半透明背景  自动延时消失*/
void showHudAutomatic(CGFloat delay);

/** 弹出纯文本  自动延时消失*/
void showTextHudAlert(NSString *text, CGFloat delay);

typedef void (^RequestAblumAuthority)(NSError *error);
/** 相册权限  */
void requestAblumAuthorityWithCompletionHandler(RequestAblumAuthority handler);

typedef void (^RequestMediaAuthority)(NSError *);
/** 照相机\麦克风权限  */
void requestMediaCapturerAccessWithHandler(RequestMediaAuthority handler);

/** 是否开启允许推送的权限  */
BOOL isUserNotificationEnable(void);

/** 进入app的系统设置页面  */
void goToAppSystemSetting(void);

/*  切圆角     */

/** 不推荐的做法，当一个页面只有少量圆角图片时才推荐使用(4角全切)  */
void cornerByLayer(UIView *view, CGFloat radiusValue);

/** 贝塞尔曲线切割圆角(4角全切)（不推荐，掉帧严重）  */
void cornerByBezierShapeLayer(UIView *view, CGFloat radiusValue);

/**
 且部分圆角
 
 @param view view
 @param corners 圆角位置
 @param radiusValue 半径
 
 圆角位置类型共有以下几种:
 
 * UIRectCornerTopLeft
 
 * UIRectCornerTopRight
 
 * UIRectCornerBottomLeft
 
 * UIRectCornerBottomRight
 
 * UIRectCornerAllCorners
 */
void cornerSubCorner(UIView *view, UIRectCorner corners, CGFloat radiusValue);

/** 判断字符串是否为空  */
BOOL isEmptyString(NSString *string);
/** 包含给定的字符串, 忽略大小写  */
BOOL isContainsString(NSString *string, NSString *subStr);


@end
