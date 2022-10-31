Pod::Spec.new do |s|

  s.name         = "MLCKit"
  s.version      = "0.0.4"
  s.summary      = "LCSKit的Objective-C版本，封装一些常用的iOS方法。"

  s.homepage     = "https://github.com/mlcldh/MLCKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "mlcldh" => "1228225993@qq.com" }

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/mlcldh/MLCKit.git", :tag => s.version.to_s }
#  s.source_files = "MLCKit"
  s.source_files = 'MLCKit/MLCKit.h'
  s.module_name = 'MLCKit'

  s.requires_arc = true
  s.static_framework = true

#  s.xcconfig = {
#    :modular_headers => true
#  }
  
  s.subspec 'Algorithm' do |ss|
    ss.source_files = 'MLCKit/Algorithm/*.{h,m,mm}'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'Cache' do |ss|
    ss.source_files = 'MLCKit/Cache/*.{h,m,mm}'
    ss.dependency 'YYCache'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'Category' do |ss|
    ss.source_files = 'MLCKit/Category/*.{h,m,mm}'
    ss.frameworks = 'UIKit', 'CoreImage'
  end
  
  s.subspec 'Color' do |ss|
    ss.source_files = 'MLCKit/Color/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Document' do |ss|
    ss.source_files = 'MLCKit/Document/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Font' do |ss|
    ss.source_files = 'MLCKit/Font/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'LocalFolder' do |ss|
    ss.source_files = 'MLCKit/LocalFolder/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
    ss.dependency 'MLCKit/Category'
    ss.dependency 'MLCKit/Utility'
  end
  
  s.subspec 'Location' do |ss|
    ss.source_files = 'MLCKit/Location/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Macro' do |ss|
    ss.source_files = 'MLCKit/Macro/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
  end
  
  s.subspec 'Photos' do |ss|
    ss.source_files = 'MLCKit/Photos/*.{h,m,mm}'
    ss.frameworks = 'AVFoundation', 'Photos'
    ss.dependency 'MLCKit/Utility'
  end
  
  s.subspec 'Proxy' do |ss|
    ss.source_files = 'MLCKit/Proxy/*.{h,m,mm}'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'Scan' do |ss|
    ss.source_files = 'MLCKit/Scan/Classes/**/*'
#    ss.resources = 'MLCKit/Scan/Resources/**/*'
    ss.resource_bundles = {
      'MLCKit' => ['MLCKit/Scan/Resources/**/*']
    }
    ss.frameworks = 'AVFoundation', 'Photos'
    ss.dependency 'Masonry'
    ss.dependency 'MLCKit/Category'
    ss.dependency 'MLCKit/Macro'
    ss.dependency 'MLCKit/Photos'
  end
  
  s.subspec 'TableView' do |ss|
    ss.source_files = 'MLCKit/TableView/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
    ss.dependency 'Masonry'
    ss.dependency 'MJRefresh'
    ss.dependency 'MLCKit/Category'
  end
  
  s.subspec 'Timer' do |ss|
    ss.source_files = 'MLCKit/Timer/*.{h,m}'
    ss.frameworks = 'Foundation'
  end
  
  s.subspec 'UI' do |ss|
    ss.source_files = 'MLCKit/UI/*.{h,m,mm}'
    ss.frameworks = 'UIKit'
    ss.dependency 'Masonry'
    ss.dependency 'MLCKit/Proxy'
  end
  
  s.subspec 'Utility' do |ss|
    ss.source_files = 'MLCKit/Utility/*.{h,m}'
    ss.frameworks = 'UIKit', 'AdSupport', 'CoreTelephony'
  end
  
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
