//
//  LSDUtils.m
//  VideoShake
//
//  Created by LiuLi on 2018/9/17.
//  Copyright © 2018年 lsd. All rights reserved.
//

#import "LSDUtils.h"
#import <sys/utsname.h>
//#import "LoginViewController.h"
#import <Photos/Photos.h>
//#import "KeychainItemWrapper.h"

@implementation LSDUtils

/** 第一次安装 || 更新版本了  */
BOOL isFirstLaunchOrUploadNew(void) {
    NSString *oldVerson = [[NSUserDefaults standardUserDefaults] objectForKey:kOldVerson];
    if (ISEMPTY(oldVerson)) {
        oldVerson = @"0";
    }
    NSString *currentVersion = CFBundleVersion;
    if ([oldVerson compare:currentVersion options:NSNumericSearch] == NSOrderedSame){
        return NO;
    }else {
        // 说明发生第一次安装 或者 更换版本了
        return YES;
    }
}

/** 手机号格式验证  */
BOOL isPhoneNumberStr(NSString *str) {
    static NSRegularExpression* regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"^1\\d{10}$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    return [regex numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
}

/** 密码格式验证  */
BOOL isPassWordStr(NSString *str) {
    BOOL result = false;
    if ([str length] >= 6){
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{8,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:str];
    }
    return result;
}

/** 邮箱号码格式验证  */
BOOL isValidateEmail(NSString *email) {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRegex];
    return [emailTest evaluateWithObject:email];
}

/** 中文格式验证  */
BOOL isChineseChar(NSString *str) {
    static NSRegularExpression* regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"^[-·a-zA-Z\u4e00-\u9fa5]+$" options:NSRegularExpressionCaseInsensitive error:nil];
    });
    return [regex numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
}

/** 表情格式验证  */
BOOL isEmojiStr(NSString *str) {
    __block BOOL returnValue = NO;
    [str enumerateSubstringsInRange:NSMakeRange(0, [str length])
                            options:NSStringEnumerationByComposedCharacterSequences
                         usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                             const unichar hs = [substring characterAtIndex:0];
                             if (0xd800 <= hs && hs <= 0xdbff) {
                                 if (substring.length > 1) {
                                     const unichar ls = [substring characterAtIndex:1];
                                     const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                     if (0x1d000 <= uc && uc <= 0x1f77f) {
                                         returnValue = YES;
                                     }
                                 }
                             } else if (substring.length > 1) {
                                 const unichar ls = [substring characterAtIndex:1];
                                 if (ls == 0x20e3) {
                                     returnValue = YES;
                                 }
                             } else {
                                 if (0x2100 <= hs && hs <= 0x27ff) {
                                     returnValue = YES;
                                 } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                     returnValue = YES;
                                 } else if (0x2934 <= hs && hs <= 0x2935) {
                                     returnValue = YES;
                                 } else if (0x3297 <= hs && hs <= 0x3299) {
                                     returnValue = YES;
                                 } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                     returnValue = YES;
                                 }
                             }
                         }];
    return returnValue;
}

/** 数字格式验证  */
BOOL isNumberStr(NSString *str) {
    static NSRegularExpression* regex = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"^[0-9]*$"
                                                     options:NSRegularExpressionCaseInsensitive error:nil];
    });
    return [regex numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
}

/** 有效网址格式验证  */
BOOL isValidateUrl(NSString *url) {
    NSString *urlRegex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegex];
    return [urlTest evaluateWithObject:url];
}

/** 判断字符串是int类型  */
BOOL isPureInt(NSString *string) {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(string.length > 0) {
        return NO;
    }
    return YES;
}

/** 判断字符串是否为浮点形  */
BOOL isPureFloat(NSString *string) {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

/** 是iPhoneX  */
BOOL isiPhoneX(void) {
    if ([isPhoneType() isEqualToString:@"iPhone X"]) {
        return YES;
    }else{
        return NO;
    }
}

/** 获取用户id  */
NSString *getUserId(void) {
//    if ([UserInfo sharedInstance].isLogin) {
//        return [UserInfo sharedInstance].userId;
//    }else{
        return @"";
//    }
}

/** 是否登陆了  */
BOOL isLogin(void) {
//    if ([UserInfo sharedInstance].isLogin) {
        return YES;
//    }else{
//        return NO;
//    }
}

/** 去登陆  */
void toLogin(UIViewController *vc) {
//    LoginViewController *login = [[LoginViewController alloc] init];
//    UINavigationController *nav = [UINavigationController rootVC:login translationScale:NO];
//    [vc presentViewController:nav animated:YES completion:nil];
}

/** 获取手机类型iPhone几  */
NSString *isPhoneType(void) {
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]){
        return @"iPhone 2G";
    }
    
    if([platform isEqualToString:@"iPhone1,2"]){
        return @"iPhone 3G";
    };
    
    if([platform isEqualToString:@"iPhone2,1"]){
        return @"iPhone 3GS";
    }
    
    if([platform isEqualToString:@"iPhone3,1"] || [platform isEqualToString:@"iPhone3,2"] || [platform isEqualToString:@"iPhone3,3"]){
        return @"iPhone 4";
    }
    
    if([platform isEqualToString:@"iPhone4,1"]){
        return @"iPhone 4S";
    }
    
    if([platform isEqualToString:@"iPhone5,1"] || [platform isEqualToString:@"iPhone5,2"]){
        return@"iPhone 5";
    }
    
    if([platform isEqualToString:@"iPhone5,3"] || [platform isEqualToString:@"iPhone5,4"]){
        return @"iPhone 5c";
    }
    
    if([platform isEqualToString:@"iPhone6,1"] || [platform isEqualToString:@"iPhone6,2"]){
        return@"iPhone 5s";
    }
    
    if([platform isEqualToString:@"iPhone7,1"]){
        return @"iPhone 6 Plus";
    }
    
    if([platform isEqualToString:@"iPhone7,2"]){
        return @"iPhone 6";
    }
    
    if([platform isEqualToString:@"iPhone8,1"]){
        return @"iPhone 6s";
    }
    
    if([platform isEqualToString:@"iPhone8,2"]){
        return @"iPhone 6s Plus";
    }
    
    if([platform isEqualToString:@"iPhone8,4"]){
        return @"iPhone SE";
    }
    
    if([platform isEqualToString:@"iPhone9,1"]){
        return @"iPhone 7";
    }
    
    if([platform isEqualToString:@"iPhone9,2"]){
        return @"iPhone 7 Plus";
    }
    
    if([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"]){
        return @"iPhone 8";
    }
    
    if([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"]){
        return @"iPhone 8 Plus";
    }
    
    if([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"]){
        return @"iPhone X";
    }
    
    if([platform isEqualToString:@"iPod1,1"]){
        return @"iPod Touch 1G";
    }
    
    if([platform isEqualToString:@"iPod2,1"]){
        return @"iPod Touch 2G";
    }
    
    if([platform isEqualToString:@"iPod3,1"]){
        return @"iPod Touch 3G";
    }
    
    if([platform isEqualToString:@"iPod4,1"]){
        return @"iPod Touch 4G";
    }
    
    if([platform isEqualToString:@"iPod5,1"]){
        return @"iPod Touch 5G";
    }
    
    if([platform isEqualToString:@"iPad1,1"]){
        return @"iPad 1G";
    }
    
    if([platform isEqualToString:@"iPad2,1"] || [platform isEqualToString:@"iPad2,2"] || [platform isEqualToString:@"iPad2,3"] || [platform isEqualToString:@"iPad2,4"]){
        return @"iPad 2";
    }
    
    if([platform isEqualToString:@"iPad2,5"] || [platform isEqualToString:@"iPad2,6"] || [platform isEqualToString:@"iPad2,7"]){
        return @"iPad Mini 1G";
    }
    
    if([platform isEqualToString:@"iPad3,1"] || [platform isEqualToString:@"iPad3,2"] || [platform isEqualToString:@"iPad3,3"]){
        return @"iPad 3";
    }
    
    if([platform isEqualToString:@"iPad3,4"] || [platform isEqualToString:@"iPad3,5"] ||
       [platform isEqualToString:@"iPad3,6"]){
        return @"iPad 4";
    }
    
    if([platform isEqualToString:@"iPad4,1"] || [platform isEqualToString:@"iPad4,2"] || [platform isEqualToString:@"iPad4,3"]){
        return @"iPad Air";
    }
    
    if([platform isEqualToString:@"iPad4,4"] || [platform isEqualToString:@"iPad4,5"] ||
       [platform isEqualToString:@"iPad4,6"]){
        return @"iPad Mini 2G";
    }
    
    if([platform isEqualToString:@"iPad4,7"] || [platform isEqualToString:@"iPad4,8"] || [platform isEqualToString:@"iPad4,9"]){
        return @"iPad Mini 3";
    }
    
    if([platform isEqualToString:@"iPad5,1"] || [platform isEqualToString:@"iPad5,2"]){
        return @"iPad Mini 4";
    }
    
    if([platform isEqualToString:@"iPad5,3"] || [platform isEqualToString:@"iPad5,4"]){
        return @"iPad Air 2";
    }
    
    if([platform isEqualToString:@"iPad6,3"] || [platform isEqualToString:@"iPad6,4"]){
        return @"iPad Pro 9.7";
    }
    
    if([platform isEqualToString:@"iPad6,7"] || [platform isEqualToString:@"iPad6,8"]){
        return @"iPad Pro 12.9";
    }
    
    if([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"]){
        return @"iPhone Simulator";
    }
    
    return platform;
}

/** 获取格式化时间字符串  */
NSString* getTimeStringWithDate(NSDate *date, NSString *style) {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:style];
    return [df stringFromDate:date];
}

/** 获取格式化时间  doubleDateStr：double */
NSString *getTimeFromDoubleDateStr(NSString *doubleDateStr, NSString *style) {
    NSTimeInterval _interval = [doubleDateStr doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:style];
    [formatter setTimeZone:timeZone];
    NSString *timeString = [formatter stringFromDate:date];
    return timeString;
}

#define ONE_SECOND_AGO  @"秒前"
#define ONE_MINUTE_AGO  @"分钟前"
#define ONE_HOUR_AGO @"小时前"
#define ONE_DAY_AGO  @"天前"
#define ONE_MONTH_AGO  @"月前"
#define ONE_YEAR_AGO  @"年前"

#define ONE_MINUTE  60
#define ONE_HOUR  3600
#define ONE_DAY  86400
#define ONE_WEEK  604800

/** 获取与当前时间的间隔  doubleDateStr：double */
NSString *getTimeIntervalSinceDate(NSString *doubleDateStr) {
    NSDate *date = [NSDate date]; // 系统时间
    NSTimeZone *timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8*3600];
    NSInteger interval = [timeZone secondsFromGMTForDate: date];// local时间距离GMT的秒数
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *dt2 = [[NSDate alloc] init];
    dt2 = [df dateFromString:getTimeFromDoubleDateStr(doubleDateStr, @"yyyy-MM-dd HH:mm:ss")];
    NSTimeInterval delta = [localeDate timeIntervalSinceDate:dt2]; // 多少秒
    if (delta < 1 * ONE_MINUTE) {
        int seconds = delta;
        return [NSString stringWithFormat:@"%@%@", @(seconds <= 0 ? 1 : seconds), ONE_SECOND_AGO];
    } else if (delta < 45 * ONE_MINUTE) {
        int minutes = delta/ONE_MINUTE;
        return [NSString stringWithFormat:@"%@%@", @(minutes <= 0 ? 1 : minutes), ONE_MINUTE_AGO];
    } else if (delta < 24 * ONE_HOUR) {
        int hours = delta/ONE_HOUR;
        return [NSString stringWithFormat:@"%@%@", @(hours <= 0 ? 1 : hours), ONE_HOUR_AGO];
    } else if (delta < 48 * ONE_HOUR) {
        return @"昨天";
    } else if (delta < 30 * ONE_DAY) {
        int days = delta/ONE_DAY;
        return [NSString stringWithFormat:@"%@%@", @(days <= 0 ? 1 : days), ONE_DAY_AGO];
    } else if (delta < 12*30 * ONE_DAY) {
        int months = delta/(30 * ONE_DAY);
        return [NSString stringWithFormat:@"%@%@", @(months <= 0 ? 1 : months), ONE_MONTH_AGO];
    } else {
        int years = delta/(365 * ONE_DAY);
        return [NSString stringWithFormat:@"%@%@", @(years <= 0 ? 1 : years), ONE_YEAR_AGO];
    }
}
/** 比较两个时间早晚  */
int compareDate(NSDate *startDate, NSDate *endDate) {
    int comparisonResult;
    NSComparisonResult result = [startDate compare:endDate];
    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            break;
    }
    return comparisonResult;
}

/** 数组转成json字符串  */
NSString *arrayToJSONString(NSArray *array) {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

/** json字符串转成数组 */
NSArray *stringToArray(NSString *jsonArray) {
    NSError *error = nil;
    NSData *jsonData = [jsonArray dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                          options:NSJSONReadingAllowFragments
                                                            error:nil];
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return @[];
    }
}

/** 字符串宽度 */
CGFloat getStringWidth(NSString *str , CGFloat font) {
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:font]};
    CGSize size = [str sizeWithAttributes:attrs];
    return size.width;
}

/** 字符串宽度(固定宽) */
CGFloat getStringWidthWithMaxW(NSString *str , CGFloat font, CGFloat maxW) {
    CGFloat height = [str boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size.height;
    CGFloat contenH = (height < 30*Rate ? 30*Rate : height+10);
    return contenH;
}

/** 弹出系统AlertView  */
void showSystemAlertView(NSString *title, NSString *message, NSString *sure, NSString *cancel, UIViewController *vc, SureAction sureActionBlock, CancelAction cancelActionBlock) {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (ISEMPTY(sure) == NO) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sure style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureActionBlock) {
                sureActionBlock();
            }
        }];
        [alertVc addAction:sureAction];
    }
    if (ISEMPTY(cancel) == NO) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelActionBlock) {
                cancelActionBlock();
            }
        }];
        [alertVc addAction:cancelAction];
        [vc presentViewController:alertVc animated:YES completion:nil];
    }
}

// 进度条展示和隐藏
static NSMutableDictionary* loadingMap = nil;
void showLoadingWithContentAndView(NSString* content, UIView* view) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadingMap = [[NSMutableDictionary alloc] initWithCapacity:64];
    });
    NSString* key = [NSString stringWithFormat:@"%p", view];
    if (!loadingMap[key]) {
        MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.label.textColor = MainColor0;
        hud.label.font = [UIFont systemFontOfSize:14*Rate];
        hud.label.text = content;
        hud.center = CGPointMake(hud.center.x, hud.center.y - 64);
        [hud setActivityIndicatorColor:MainColor1];
        hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
        hud.bezelView.backgroundColor = RGBA(255.0, 255.0, 255.0, 0.2);
        [view addSubview:hud];
        [hud showAnimated:YES];
        loadingMap[key] = hud;
    }
}

void hideLoadingWithView(UIView* view) {
    NSString* key = [NSString stringWithFormat:@"%p", view];
    if (loadingMap[key]) {
        MBProgressHUD* hud = loadingMap[key];
        [hud removeFromSuperview];
        [loadingMap removeObjectForKey:key];
    }
}

/** 菊花 + 半透明背景  添加到window */
void showHud(void) {
    showLoadingWithContentAndView(@"", [UIApplication sharedApplication].keyWindow);
}
/** 菊花 + 文字 + 半透明背景 添加到window */
void showHudWithText(NSString *text) {
    showLoadingWithContentAndView(text, [UIApplication sharedApplication].keyWindow);
}

void hideHud(void) {
    hideLoadingWithView([UIApplication sharedApplication].keyWindow);
}

/** 菊花 + 半透明背景  */
void showHudWithView(UIView *view) {
    showLoadingWithContentAndView(@"", view);
}
/** 菊花 + 文字 + 半透明背景 */
void showHudWithTextInView(NSString *text, UIView *view) {
    showLoadingWithContentAndView(text, view);
}

void hideHudWithView(UIView *view) {
    hideLoadingWithView(view);
}

/** 菊花 + 半透明背景  自动延时消失*/
void showHudAutomatic(CGFloat delay){
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.center = CGPointMake(hud.center.x, hud.center.y - 64);
    [hud setActivityIndicatorColor:MainColor1];
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = RGBA(255.0, 255.0, 255.0, 0.2);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:1];
}

void showTextHudAlert(NSString *text, CGFloat delay) {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode=MBProgressHUDModeText;
    hud.label.textColor = MainColor0;
    hud.label.font = [UIFont systemFontOfSize:14*Rate];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.label.lineBreakMode = NSLineBreakByWordWrapping;
    hud.bezelView.color = [UIColor blackColor];
    hud.label.textColor = MainColor1;
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.bezelView.backgroundColor = RGBA(255.0, 255.0, 255.0, 0.8);
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:delay];
}

/** 相册权限  */
void requestAblumAuthorityWithCompletionHandler(RequestAblumAuthority handler) {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    
    if (PHAuthorizationStatusAuthorized == status)
    {
        if (handler) {
            handler(nil);
        }
    }
    else
    {
        if (PHAuthorizationStatusRestricted == status || PHAuthorizationStatusDenied == status)
        {
            NSString *errMsg = @"此应用需要访问相册，请设置";
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            if (handler) {
                handler(error);
            }
        }
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized)
            {
                if (handler) {
                    handler(nil);
                }
            }
            else
            {
                NSString *errMsg = @"此应用需要访问相册，请设置";
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                if (handler) {
                    handler(error);
                }
            }
        }];
    }
}

/** 照相机\麦克风权限  */
void requestMediaCapturerAccessWithHandler(RequestMediaAuthority handler) {
    AVAuthorizationStatus videoAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    AVAuthorizationStatus audioAuthorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    
    if (AVAuthorizationStatusAuthorized == videoAuthorStatus && AVAuthorizationStatusAuthorized == audioAuthorStatus) {
        if (handler) {
            handler(nil);
        }
    }else{
        if (AVAuthorizationStatusRestricted == videoAuthorStatus || AVAuthorizationStatusDenied == videoAuthorStatus) {
            NSString *errMsg = NSLocalizedString(@"此应用需要访问摄像头，请设置", @"此应用需要访问摄像头，请设置");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            if (handler) {
                handler(error);
            }
        }
        if (AVAuthorizationStatusRestricted == audioAuthorStatus || AVAuthorizationStatusDenied == audioAuthorStatus) {
            NSString *errMsg = NSLocalizedString(@"此应用需要访问麦克风，请设置", @"此应用需要访问麦克风，请设置");
            NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
            NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
            if (handler) {
                handler(error);
            }
        }
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                    if (granted) {
                        if (handler) {
                            handler(nil);
                        }
                    }else{
                        NSString *errMsg = NSLocalizedString(@"不允许访问麦克风", @"不允许访问麦克风");
                        NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                        NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                        if (handler) {
                            handler(error);
                        }
                    }
                }];
            }else{
                NSString *errMsg = NSLocalizedString(@"不允许访问摄像头", @"不允许访问摄像头");
                NSDictionary *userInfo = @{NSLocalizedDescriptionKey:errMsg};
                NSError *error = [NSError errorWithDomain:@"访问权限" code:0 userInfo:userInfo];
                if (handler) {
                    handler(error);
                }
            }
        }];
    }
}

NSString *getUUIDStr(void) {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef uuidStr = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)uuidStr;
}

//NSString *keyChainCheckUUIDString(void) {
//     KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"UUID" accessGroup:nil];
//     NSString *UUIDString = [wrapper objectForKey:(__bridge id)kSecValueData];
//    if (![UUIDString isKindOfClass:[NSString class]] || ISEMPTY(UUIDString)) {
//        UUIDString = getUUIDStr();
//        [wrapper setObject:UUIDString forKey:(__bridge id)kSecValueData];
//    }
//    return UUIDString;
//}

BOOL isUserNotificationEnable(void) { // 判断用户是否允许接收通知
    BOOL isEnable = NO;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0f) { // iOS版本 >=8.0 处理逻辑
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        isEnable = (UIUserNotificationTypeNone == setting.types) ? NO : YES;
    } else { // iOS版本 <8.0 处理逻辑
        UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
        isEnable = (UIRemoteNotificationTypeNone == type) ? NO : YES;
    }
    return isEnable;
}

// 如果用户关闭了接收通知功能，该方法可以跳转到APP设置页面进行修改  iOS版本 >=8.0 处理逻辑
void goToAppSystemSetting(void) {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([application canOpenURL:url]) {
        if ([application respondsToSelector:@selector(openURL:options:completionHandler:)]) {
            if (@available(iOS 10.0, *)) {
                [application openURL:url options:@{} completionHandler:nil];
            } else {
                // Fallback on earlier versions
            }
        } else {
            [application openURL:url];
        }
    }
}

void cornerByLayer(UIView *view, CGFloat radiusValue) {
    if (radiusValue > 0) {
        view.layer.cornerRadius = radiusValue;
        view.layer.masksToBounds = YES;
    }
}

void cornerByBezierShapeLayer(UIView *view, CGFloat radiusValue) {
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:radiusValue];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = bezierPath.CGPath;
    view.layer.mask = layer;
}

void cornerSubCorner(UIView *view, UIRectCorner corners, CGFloat radiusValue) {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radiusValue, radiusValue)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

//判断字符串是否为空
BOOL isEmptyString(NSString *string) {
    return (string == nil || string.length == 0 || [string isKindOfClass:[NSNull class]]);
}

BOOL isContainsString(NSString *string, NSString *subStr) {
    return (isEmptyString(string)==NO && isEmptyString(subStr)==NO && ([string length] >= [subStr length]) && ([string rangeOfString:subStr options:NSCaseInsensitiveSearch].location != NSNotFound));
}

@end
