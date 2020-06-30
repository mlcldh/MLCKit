# MLCKit
MLCKit封装一些常用的iOS方法。

分成Cache、Category、LocalFolder、Macro、Proxy、UI、Utility、PhotoPermission等子pods。

## Cache

缓存管理类，基于YYCache。

提供了两个单例分别保存在Documents、Library文件夹，另外提供实例来设置自定义路径。

支持对缓存数据的同步/异步读取、设置。

```objective-c
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

使用归档、反归档进行序列化、反序列化的话，可以下面的方法：

```objective-c
@interface NSObject (MLCKit)

/**反序列化*/
- (void)mlc_setValuesWithCoder:(NSCoder *)aDecoder;
/**序列化*/
- (void)mlc_encodeWithCoder:(NSCoder *)aCoder;

@end
```

使用URL编解码的话，可以使用下面的方法：

```objective-c
@interface NSString (MLCKit)

/**URL编码*/
- (NSString *)mlc_urlEncode;
/**URL解码*/
- (NSString *)mlc_urlDecode;

@end
```

通过block获取UIControl及其子类的事件回调。UIControl的子类有UIButton、UISwitch、UISlider、UISegmentedControl、UIPageControl、UITextField、UIDatePicker等。

```objective-c
@interface UIControl (MLCKit)

/**点击回调*/
@property (nonatomic, copy) void(^mlc_touchUpInsideBlock)(void);
/**添加事件*/
- (void)mlc_addActionForControlEvents:(UIControlEvents)controlEvents callback:(void(^)(id sender))callback;
/**移除某些类型的所有事件*/
- (void)mlc_removeAllActionsForControlEvents:(UIControlEvents)controlEvents;
/**移除所有事件*/
- (void)mlc_removeAllActions;

@end
```

通过block获取UIView及其子类的手势回调；移除某一些约束。

```objective-c
/**手势类型枚举*/
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
- (UIGestureRecognizer *)mlc_addGestureRecognizerWithType:(MLCGestureRecognizerType)type callback:(void(^)(UIGestureRecognizer *recognizer))callback;
/**移除某些类型手势及其回调*/
- (void)mlc_removeGestureRecognizersWithType:(MLCGestureRecognizerType)type;
/**移除所有手势及其回调*/
- (void)mlc_removeAllGestureRecognizers;
/**移除某一些约束*/
- (void)mlc_removeConstraintsWithFirstItem:(id)firstItem firstAttribute:(NSLayoutAttribute)firstAttribute;

@end
```



`pod 'MLCKit/Category'`

## LocalFolder

LocalFolder里面有查看app沙盒文件的视图控制器。

如果想查看整个app沙盒文件，可以如下调用：

```objective-c
NSString *folderPath = NSHomeDirectory();
MLCLocalFolderViewController *localFolderVC = [[MLCLocalFolderViewController alloc]initWithFolderPath:folderPath];
[self.navigationController pushViewController:localFolderVC animated:YES];
```

`pod 'MLCKit/LocalFolder'`

## Macro

Macro里有只在Debug环境下打印NSLog，还有weakify、strongify。

`pod 'MLCKit/Macro'`

## Proxy

通过使用代理对象，解决循环引用问题。

比如在UIViewController中，使用NSTimer指定target为UIViewController时，使用WKUserContentController的addScriptMessageHandler方法指定target为UIViewController时，容易出现循环引用问题。一些开发者在viewWillAppear、viewWillDisappear或viewDidAppear、viewDidDisappear进行操作，但这种操作较为麻烦。

使用MLCProxy的话，可以如下调用：

```objective-c
_timer = [NSTimer timerWithTimeInterval:interval target:[MLCProxy proxyWithTarget:self] selector:@selector(pollLastNotice) userInfo:nil repeats:YES];
```

```objective-c
[configuration.userContentController addScriptMessageHandler:(id <WKScriptMessageHandler>)[MLCProxy proxyWithTarget:self] name:@"log"];
```

`pod 'MLCKit/Proxy'`

## UI

UI里面是UI控件。

### MLCGradientView

layerClass是CAGradientLayer的。

### MLCLabelView

在UILabel外面包一层。

`pod 'MLCKit/UI'`

## Utility

Utility里面是工具类，有获取app版本号、app构建版本号、app名字、app的bundle ID、运营商名字、蜂窝网络类型、安全区域、让UIApplication打开链接等功能。

```objective-c
@interface MLCUtility : NSObject

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
/**运营商名字*/
+ (NSString *)carrierName;
/**蜂窝网络类型*/
+ (NSString *)currentRadioAccessTechnology;
/**安全区域，iOS 11以下的返回UIEdgeInsetsMake(20, 0, 0, 0)*/
+ (UIEdgeInsets)safeAreaInsets;
/**让UIApplication打开链接*/
+ (void)openURL:(NSURL*)url;

@end
```

`pod 'MLCKit/Utility'`

## PhotoPermission

相册、相机权限判断。

判断相册权限，可以如下调用：

```objective-c
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) callback:^(BOOL isSourceTypeAvailable, BOOL success, BOOL isNotDetermined) {
                if (!isSourceTypeAvailable) {
                    NSLog(@"当前设备没有相册功能");
                    return;
                }
                if (isNotDetermined) {
                    NSLog(@"相册权限还未处理");
                }
                if (success) {
                    NSLog(@"已经获得相册权限");
                } else {
                    NSLog(@"相册权限被拒绝");
                }
            }];
```

判断相册权限，并且在权限被拒绝时弹出alert提醒，可以如下调用：

```objective-c
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypePhotoLibrary) callback:^{
                NSLog(@"已经获得相册权限");
            } fromViewController:self];
```

判断相机权限，可以如下调用：

```objective-c
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) callback:^(BOOL isSourceTypeAvailable, BOOL success, BOOL isNotDetermined) {
                if (!isSourceTypeAvailable) {
                    NSLog(@"当前设备没有相机功能");
                    return;
                }
                if (isNotDetermined) {
                    NSLog(@"相机权限还未处理");
                }
                if (success) {
                    NSLog(@"已经获得相机权限");
                } else {
                    NSLog(@"相机权限被拒绝");
                }
            }];
```

判断相机权限，并且在权限被拒绝时弹出alert提醒，可以如下调用：

```objective-c
[MLCPhotoPermissionManager requestPermissionWithSourceType:(UIImagePickerControllerSourceTypeCamera) callback:^{
                NSLog(@"已经获得相机权限");
            } fromViewController:self];
```

`pod 'MLCKit/PhotoPermission'`

# 安装

### CocoaPods

1. 需要MLCKit所有功能的，在 Podfile 中添加 `pod 'MLCKit'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 相应头文件。

# 系统要求

该项目最低支持 `iOS 6.0`。

