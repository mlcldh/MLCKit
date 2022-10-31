# MLCKit
MLCKit封装一些常用的iOS方法。

分成Cache、Category、Color、Document、Font、LocalFolder、Location、Macro、Photos、Proxy、Scan、TableView、UI、Utility等子pods。

Swift版本是[LCSKit](https://github.com/mlcldh/LCSKit)，功能基本相同。

## Cache

缓存管理类，基于YYCache。

提供了两个单例分别保存在Documents、Library文件夹，另外提供实例来设置自定义路径。

支持对缓存数据的同步/异步读取、设置。

```objc
/**单例，存放在Documents文件夹内，app设置里面清理缓存不可以删除的缓存*/
+ (instancetype)coreCache;

/**单例，存放在Library文件夹内，app设置里面清理缓存可以删除的缓存*/
+ (instancetype)simpleCache;

/**非单例，普通实例，自定义缓存路径，当path路径和coreCache、simpleCache重复时，返回nil*/
+ (instancetype)cacheWithPath:(NSString *)path;
```

`pod 'MLCKit/Cache'`

## Category

Category里面是常用类目，有URL编解码、UIView的点击回调、UIControl的点击block回调等。

### NSObject

使用归档、反归档进行序列化、反序列化的话，可以下面的方法：

```objc
@interface NSObject (MLCKit)

/**反序列化*/
- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder;
/**序列化*/
- (void)mlc_encodeWithCoder:(NSCoder *)aCoder;
/**转换成json字符串*/
- (NSString *)mlc_JSONString;

@end
```

### NSArray

```objc
@interface NSArray (MLCKit)

/**将数组的view根据先后顺序，根据相同间距连接起来*/
- (void)mlc_combineViewsWithAxis:(UILayoutConstraintAxis)axis withFixedSpacing:(CGFloat)fixedSpacing;
/**将数组的view根据先后顺序，根据数组fixedSpacings的间距连接起来*/
- (void)mlc_combineViewsWithAxis:(UILayoutConstraintAxis)axis withFixedSpacings:(NSArray <NSNumber *>*)fixedSpacings;
/**将数组的view根据先后顺序，数组的view的中心位置等间距*/
- (void)mlc_distributeViewsEqualCenterSpacingWithAxis:(UILayoutConstraintAxis)axis leadCenterSpacing:(CGFloat)leadCenterSpacing tailCenterSpacing:(CGFloat)tailCenterSpacing;

@end
```

### NSDate

```objc
@interface NSDate (MLCKit)

/**当前日期在当前日历的年*/
- (NSInteger)mlc_year;
/**当前日期在当前日历的月*/
- (NSInteger)mlc_month;
/**当前日期在当前日历的日*/
- (NSInteger)mlc_day;
/**当前日期在当前日历的组成成份，成份有年、月、日、时、分、秒、星期等等*/
- (NSDateComponents *)mlc_components:(NSCalendarUnit)unitFlags;
/**当前日期在农立的组成成份，成份有年、月、日、时、分、秒、星期等等*/
- (NSDateComponents *)mlc_chineseComponents:(NSCalendarUnit)unitFlags;
/**是否是今天*/
- (BOOL)mlc_isToday;
/**是否是昨天*/
- (BOOL)mlc_isYesterday;
/**和日期date是否是同一年*/
- (BOOL)mlc_isSameYearWithDate:(NSDate *)date;
/**当前日期的基础上，增加天数，天数可以是负数*/
- (NSDate *)mlc_dateByAddingDays:(NSInteger)days;
/**当前日期的基础上，增加月数，月数可以是负数*/
- (NSDate *)mlc_dateByAddingMonths:(NSInteger)months;
/**当前日期的基础上，增加年数，年数可以是负数*/
- (NSDate *)mlc_dateByAddingYears:(NSInteger)years;
/**格式化后的字符串*/
- (NSString *)mlc_stringWithFormat:(NSString *)format;

@end
```

### NSString

使用URL编解码的话，可以使用下面的方法：

```objc
@interface NSString (MLCKit)

/**URL编码*/
- (NSString *)mlc_urlEncode;
/**URL解码*/
- (NSString *)mlc_urlDecode;
/**使用SHA1计算hash*/
- (NSString *)mlc_sha1String;
/**将json字符串转换成字典或数组等*/
- (id)mlc_JSONObject;

@end
```

### UIControl

通过block获取UIControl及其子类的事件回调。UIControl的子类有UIButton、UISwitch、UISlider、UISegmentedControl、UIPageControl、UITextField、UIDatePicker等。

```objc
@interface UIControl (MLCKit)

/**点击回调*/
@property (nonatomic, copy) void(^mlc_touchUpInsideBlock)(void);
/**添加事件*/
- (void)mlc_addActionForControlEvents:(UIControlEvents)controlEvents handler:(void(^)(id sender))handler;
/**移除某些类型的所有事件*/
- (void)mlc_removeAllActionsForControlEvents:(UIControlEvents)controlEvents;
/**移除所有事件*/
- (void)mlc_removeAllActions;

@end
```

### UIView

通过block获取UIView及其子类的手势回调；移除某一些约束。

```objc
/**手势类型枚举 */
typedef NS_ENUM(NSInteger, MLCGestureRecognizerType) {
    MLCGestureRecognizerTypeTap = 0,//
    MLCGestureRecognizerTypeLongPress = 1,//
    MLCGestureRecognizerTypePan = 2,//
    MLCGestureRecognizerTypeSwipe = 3,//
    MLCGestureRecognizerTypeRotation = 4,//
    MLCGestureRecognizerTypePinch = 5,//
};

@interface UIView (MLCKit)

/**添加手势及其回调*/
- (UIGestureRecognizer *)mlc_addGestureRecognizerWithType:(MLCGestureRecognizerType)type handler:(void(^)(UIGestureRecognizer *recognizer))handler;
/**移除某些类型手势及其回调*/
- (void)mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerType)type;
/**移除所有手势及其回调*/
- (void)mlc_removeAllGestureRecognizers;
/**移除自己的某一些约束*/
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute;
/**移除firstItem是自己的某一些约束*/
- (void)mlc_removeConstraintsWithFirstAttribute:(NSLayoutAttribute)firstAttribute secondItem:(id)secondItem;
/**添加约束*/
- (void)mlc_addConstraintWithFirstAttribute:(NSLayoutAttribute)firstAttribute relation:(NSLayoutRelation)relation secondItem:(id)secondItem secondAttribute:(NSLayoutAttribute)secondAttribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant;
/**返回离两个view最近的父视图*/
- (instancetype)mlc_closestCommonSuperview:(UIView *)view;
/**加部分圆角*/
- (void)mlc_becomeRoundedbyRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius;
- (void)mlc_becomeRoundedbyRoundingCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius size:(CGSize)size;

@end
```

### UIViewController

```objc
@interface UIViewController (MLCKit)

/**弹出alert*/
- (void)mlc_showAlertWithTitle:(NSString *)title message:(NSString *)message actionTitle:(NSString *)actionTitle handler:(void (^)(void))handler;
/**弹出confirm，一个选项*/
- (void)mlc_showConfirmWithTitle:(NSString *)title message:(NSString *)message confirmTitle:(NSString *)confirmTitle confirmHandler:(void (^)(void))confirmHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;
/**弹出confirm，多个选项*/
- (void)mlc_showConfirmWithTitle:(NSString *)title message:(NSString *)message optionTitles:(NSArray<NSString *> *)optionTitles optionsHandler:(void (^)(NSInteger index))optionsHandler cancelTitle:(NSString *)cancelTitle cancelHandler:(void (^)(void))cancelHandler;
/**弹出prompt，一个输入框*/
- (void)mlc_showPromptWithTitle:(NSString *)title message:(NSString *)message configurationHandler:(void (^)(UITextField *textField))configurationHandler resultHandler:(void (^)(BOOL isCancel, NSString *result))resultHandler;
/**弹出prompt，多个输入框*/
- (void)mlc_showPromptWithTitle:(NSString *)title message:(NSString *)message textFieldCount:(NSInteger)textFieldCount configurationHandler:(void (^)(UITextField *textField, NSInteger index))configurationHandler resultHandler:(void (^)(BOOL isCancel, NSArray<NSString *> *results))resultHandler;

@end
```

`pod 'MLCKit/Category'`

## Color

颜色相关。

```objc
/**将UIColorPickerViewController协议方法通过block回调出来*/
API_AVAILABLE(ios(14.0))
@interface MLCColorPickerViewControllerManager : NSObject<UIColorPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) UIColorPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didSelectColorHandler)(void);
/**完成回调*/
@property (nonatomic, copy) void(^didFinishHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIColorPickerViewController *)pickerViewController;

@end
```

`pod 'MLCKit/Color'`

## Document

文件相关。

```objc
/**将UIDocumentPickerViewController协议方法通过block回调出来*/
@interface MLCDocumentPickerViewControllerManager : NSObject<UIDocumentPickerDelegate>

/***/
@property (nonatomic, weak, readonly) UIDocumentPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didPickDocumentsHandler)(NSArray<NSURL *> *urls);
/**取消回调*/
@property (nonatomic, copy) void(^wasCancelledHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIDocumentPickerViewController *)pickerViewController;

@end
```

`pod 'MLCKit/Document'`

## Font

字体相关。

```objc
/**将UIFontPickerViewController协议方法通过block回调出来*/
API_AVAILABLE(ios(13.0))
@interface MLCFontPickerViewControllerManager : NSObject<UIFontPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) UIFontPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didPickFontHandler)(void);
/**取消回调*/
@property (nonatomic, copy) void(^didCancelHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIFontPickerViewController *)pickerViewController;

@end
```

`pod 'MLCKit/Font'`

## LocalFolder

LocalFolder里面有查看app沙盒文件的视图控制器，支持对文件、文件夹进行打开、重命名、查看文件信息等功能，同时支持自定义文件打开操作。

```objc
/// 本地文件查看
@interface MLCLocalFolderViewController : UIViewController

/// 初始化文件夹
@property (nonatomic, copy, readonly) NSString *folderPath;
/// 是否能够打开文件的回调
@property (nonatomic, copy) BOOL(^canOpenFileHandler)(NSString *filePath);

/// 初始化方法
/// - Parameter folderPath: 文件夹路径
- (instancetype)initWithFolderPath:(NSString *)folderPath;

@end
```

如果想查看整个app沙盒文件，可以如下调用：

```objc
NSString *folderPath = NSHomeDirectory();
MLCLocalFolderViewController *localFolderVC = [[MLCLocalFolderViewController alloc]initWithFolderPath:folderPath];
[self.navigationController pushViewController:localFolderVC animated:YES];
```

`pod 'MLCKit/LocalFolder'`

## Location

```objc
/**定位管理*/
@interface MLCLocationManager : NSObject

/**单例*/
+ (instancetype)sharedInstance;
/**更新位置回调*/
@property (nonatomic, copy) BOOL(^didUpdateLocationsHandler)(NSArray<CLLocation *> *locations);
/**失败回调*/
@property (nonatomic, copy) void(^didFailHandler)(NSError *error);

/**开始更新位置*/
- (void)startUpdatingLocation;
/**停止更新位置*/
- (void)stopUpdatingLocation;

@end
```

`pod 'MLCKit/Location'`

## Macro

Macro里有只在Debug环境下打印NSLog，还有weakify、strongify。

`pod 'MLCKit/Macro'`

## Photos

相册、相机相关。

### 权限

#### 相册权限

判断相册权限，可以如下调用：

```objc
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) sourceTypeUnavailableHandler:^{
            NSLog(@"当前设备没有相册功能");
        } isNotDeterminedHandler:^{
            NSLog(@"相册权限之前还未处理");
        } handler:^(BOOL success, BOOL isLimited) {
            if (success) {
                NSLog(@"已经获得相册权限");
                if (isLimited) {
                    NSLog(@"读取相册受限");
                }
            } else {
                NSLog(@"相册权限被拒绝");
            }
        }];
```

判断相册权限，并且在权限被拒绝时弹出alert提醒，可以如下调用：

```objc
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) handler:^(BOOL isLimited) {
            NSLog(@"已经获得相册权限");
            if (isLimited) {
                NSLog(@"读取相册受限");
            }
        } fromViewController:self];
```

#### 相机权限

判断相机权限，可以如下调用：

```objc
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) sourceTypeUnavailableHandler:^{
            NSLog(@"当前设备没有相机功能");
        } isNotDeterminedHandler:^{
            NSLog(@"相机权限之前还未处理");
        } handler:^(BOOL success, BOOL isLimited) {
            if (success) {
                NSLog(@"已经获得相机权限");
                if (isLimited) {
                    NSLog(@"读取受限");
                }
            } else {
                NSLog(@"相机权限被拒绝");
            }
        }];
```

判断相机权限，并且在权限被拒绝时弹出alert提醒，可以如下调用：

```objc
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) handler:^(BOOL isLimited) {
            NSLog(@"已经获得相机权限");
        } fromViewController:self];
```

### PHPickerViewController

MLCPHPickerViewControllerManager将PHPickerViewController的协议方法回调改成了block回调：

```objc
/**将PHPickerViewController协议方法通过block回调出来*/
API_AVAILABLE(ios(14))
@interface MLCPHPickerViewControllerManager : NSObject<PHPickerViewControllerDelegate>

/***/
@property (nonatomic, weak, readonly) PHPickerViewController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didFinishPickingHandler)(NSArray<PHPickerResult *> *results);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(PHPickerViewController *)pickerViewController;

@end
```

### UIImagePickerController

MLCImagePickerControllerManager将UIImagePickerController的协议方法回调改成了block回调：

```objc
/**
 * 将UIImagePickerController部分协议方法通过block回调出来
 * 想扩展到更多部分协议方法的话，可以继承该类
 */
@interface MLCImagePickerControllerManager : NSObject<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/***/
@property (nonatomic, weak, readonly) UIImagePickerController *pickerViewController;
/**选取回调*/
@property (nonatomic, copy) void(^didFinishPickingMediaHandler)(NSDictionary<UIImagePickerControllerInfoKey,id> *info);
/**点击回调*/
@property (nonatomic, copy) void(^didCancelHandler)(void);

/**初始化方法*/
- (instancetype)initWithPickerViewController:(UIImagePickerController *)pickerViewController;
/**
 *将自己从pickerViewController上移除
 *继承时使用
 */
- (void)clearSelfFromPickerViewController;

@end
```

`pod 'MLCKit/Photos'`

## Proxy

通过使用代理对象，解决循环引用问题。

比如在UIViewController中，使用NSTimer指定target为UIViewController时，使用WKUserContentController的addScriptMessageHandler方法指定target为UIViewController时，容易出现循环引用问题。一些开发者在viewWillAppear、viewWillDisappear或viewDidAppear、viewDidDisappear进行操作，但这种操作较为麻烦。

使用MLCProxy的话，可以如下调用：

```objc
_timer = [NSTimer timerWithTimeInterval:interval target:[MLCProxy proxyWithTarget:self] selector:@selector(pollLastNotice) userInfo:nil repeats:YES];
```

```objc
[configuration.userContentController addScriptMessageHandler:(id <WKScriptMessageHandler>)[MLCProxy proxyWithTarget:self] name:@"log"];
```

`pod 'MLCKit/Proxy'`

## Scan

Scan里面有扫码二维码视图控制器MLCScanQRCodeViewController，还有识别二维码的方法。

## TableView

里面封装了UITableView下拉刷新、加载更多等的处理，将UITableView的代理回调改成使用block回调。

## UI

UI里面是UI控件。

### MLCGradientLayerView

layerClass是CAGradientLayer的。

### MLCLabelView

在UILabel外面包一层。

`pod 'MLCKit/UI'`

## Utility

Utility里面是工具类。

### MLCDeviceUtility

MLCDeviceUtility封装获取设备信息的方法。

```objc
/**设备相关工具类*/
@interface MLCDeviceUtility : NSObject

/**app版本号*/
+ (NSString *)appVersion;
/**app构建版本号*/
+ (NSString *)appBuildVersion;
/**app名字*/
+ (NSString *)appName;
/**app的bundle ID*/
+ (NSString *)bundleIdentifier;
/**IDFA，广告标示符*/
+ (NSString *)idfa;
/**广告跟踪是否开启*/
+ (BOOL)advertisingTrackingEnabled;
/**IDFV*/
+ (NSString *)identifierForVendor;
/**IDFA或IDFV，IDFA能获取到就返回IDFA*/
+ (NSString *)idfaOrIdfv;
/***/
+ (NSString *)machine;
/**是否越狱*/
+ (BOOL)isJailbroken;

/**运营商名字*/
+ (NSString *)carrierName;
/**蜂窝网络类型*/
+ (NSString *)currentRadioAccessTechnology;
/**电池状态*/
+ (UIDeviceBatteryState)batteryStauts;

/**电池电量*/
+ (float)batteryLevel;
/**总内存大小*/
+ (unsigned long long)totalMemorySize;

/**当前可用内存大小*/
+ (unsigned long long)availableMemorySize;
/**已使用内存大小*/
+ (unsigned long long)usedMemory;
/**总磁盘容量*/
+ (unsigned long long)totalDiskSize;
/**可用磁盘容量*/
+ (unsigned long long)availableDiskSize;

/**IP地址*/
+ (NSString *)deviceIPAdress;
/**连接的WIFI名称(SSID)*/
+ (NSString *)wifiName;
/**状态栏高度*/
+ (CGFloat)statusBarHeight;
/**安全区域，iOS 11以下的返回UIEdgeInsetsMake(20, 0, 0, 0)*/
+ (UIEdgeInsets)safeAreaInsets;

@end
```

### MLCFileUtility

```objc
/**文件相关工具类*/
@interface MLCFileUtility : NSObject

/**获取Document文件目录*/
+ (NSString*)documentDirectoryPath;
/**获取Temp文件目录*/
+ (NSString*)temporaryDirectoryPath;
/**获取Home文件目录*/
+ (NSString*)homeDirectoryPath;
/**获取Cache文件目录*/
+ (NSString*)cachesDirectoryPath;
/**创建目录*/
+ (BOOL)creatDirectoryWithPath:(NSString *)path;
/**删除目录或文件*/
+ (BOOL)removeItemAtPath:(NSString *)path;
/**移动文件*/
+ (BOOL)moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
/**拷贝文件*/
+ (BOOL)copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;
/** 获取文件或者文件夹大小(单位：B) */
+ (unsigned long long)sizeAtPath:(NSString *)path;

@end
```

### MLCNotificationUtility

```objc
/**通知工具类*/
@interface MLCNotificationUtility : NSObject

/**
 注册通知
 
 @param delegate UNUserNotificationCenterDelegate
 **/
+ (void)registerNotificationWithDelegate:(id)delegate;

/**远程推送设备token字符串*/
+ (NSString *)remoteNotificationDeviceTokenStringWithDeviceToken:(NSData *)deviceToken;

@end
```

### MLCOpenUtility

```objc
/**打开相关工具类*/
@interface MLCOpenUtility : NSObject

/**让UIApplication打开链接*/
+ (void)openURL:(NSURL*)url completionHandler:(void (^)(BOOL success))completion;
/**打电话*/
+ (void)callWithTelephoneNumber:(NSString*)telephoneNumber;
/**发邮件*/
+ (void)sendEmail:(NSString*)email;
/**发短信*/
+ (void)sendShortMessage:(NSString*)shortMessage;
/**跳转到app设置页面*/
+ (void)openSettings;

@end
```

`pod 'MLCKit/Utility'`

# 安装

### CocoaPods

1. 需要MLCKit所有功能的，在 Podfile 中添加 `pod 'MLCKit'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 相应头文件。

# 系统要求

该项目最低支持 `iOS 8.0`。

