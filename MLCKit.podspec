Pod::Spec.new do |s|

  s.name         = "MLCKit"
  s.version      = "0.0.2"
  s.summary      = "LCSKit的Objective-C版本，封装一些常用的iOS方法。"

  s.homepage     = "https://github.com/mlcldh/MLCKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "mlcldh" => "1228225993@qq.com" }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'

  s.source       = { :git => "https://github.com/mlcldh/MLCKit.git", :tag => s.version.to_s }
#  s.source_files = "MLCKit"
  s.source_files = 'MLCKit/MLCKit.h'

  s.requires_arc = true
  s.static_framework = true
  
  s.subspec 'Cache' do |ss|
    ss.source_files = 'MLCKit/Cache/*.{h,m,mm}'
    ss.dependency 'YYCache'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'Category' do |ss|
    ss.source_files = 'MLCKit/Category/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'LocalFolder' do |ss|
    ss.source_files = 'MLCKit/LocalFolder/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Macro' do |ss|
    ss.source_files = 'MLCKit/Macro/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Proxy' do |ss|
    ss.source_files = 'MLCKit/Proxy/*.{h,m,mm}'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'UI' do |ss|
    ss.source_files = 'MLCKit/UI/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
    ss.dependency 'Masonry'
  end
  
  s.subspec 'Utility' do |ss|
    ss.source_files = 'MLCKit/Utility/*.{h,m}'
    ss.frameworks = 'UIKit', 'AdSupport', 'CoreTelephony'
  end
  
  s.subspec 'PhotoPermission' do |ss|
    ss.source_files = 'MLCKit/PhotoPermission/*.{h,m,mm}'
    ss.frameworks = 'AVFoundation', 'Photos'
    ss.dependency 'MLCKit/Utility'
  end
  
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
