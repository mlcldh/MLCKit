# MLCKit
MLCKit封装一些常用的iOS方法。

分成Category、LocalFolder、Macro、UI、Utility等子pods。

## Category

Category里面是常用类目，有URL编解码、UIView的点击回调、UIControl的点击block回调等。

pod 'MLCKit/Category', :git => 'https://github.com/mlcldh/MLCKit.git'

## LocalFolder

LocalFolder里面有查看app沙盒文件的视图控制器。

pod 'MLCKit/LocalFolder', :git => 'https://github.com/mlcldh/MLCKit.git'

## Macro

Macro里有只在Debug环境下打印NSLog，还有weakify、strongify。

pod 'MLCKit/Macro', :git => 'https://github.com/mlcldh/MLCKit.git'

## UI

UI里面是UI控件，有layerClass是CAGradientLayer的MLCGradientView，对UILabel外面包一层的MLCLabelView。

pod 'MLCKit/UI', :git => 'https://github.com/mlcldh/MLCKit.git'

## Utility

Utility里面是工具类，有获取app版本号、app构建版本号、app名字、app的bundle ID、运营商名字、蜂窝网络类型、安全区域、让UIApplication打开链接等功能。

pod 'MLCKit/Utility', :git => 'https://github.com/mlcldh/MLCKit.git'

# 安装

### CocoaPods

1. 在 Podfile 中添加 `pod 'MLCKit', :git => 'https://github.com/mlcldh/MLCKit.git'`。
2. 执行 `pod install` 或 `pod update`。
3. 导入 相应头文件。

# 系统要求

该项目最低支持 `iOS 6.0`。

