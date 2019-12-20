Pod::Spec.new do |s|

  s.name         = "MLCKit"
  s.version      = "0.0.1"
  s.summary      = "文本相关的工具类。"

  s.homepage     = "https://github.com/mlcldh/MLCKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "mlcldh" => "1228225993@qq.com" }

  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'

  s.source       = { :git => "https://github.com/mlcldh/MLCKit.git", :tag => s.version.to_s }
#  s.source_files = "MLCKit"
  s.source_files = 'MLCKit/**/*.{h,m}'
  s.frameworks = 'UIKit', 'Foundation'

  s.requires_arc = true
  s.static_framework = true
  

  s.subspec 'Utility' do |ss|
    ss.source_files = 'MLCKit/Utility/*.{h,m}'
    ss.public_header_files = 'MLCKit/Utility/*.h'
  end
  
  s.subspec 'Category' do |ss|
    ss.source_files = 'MLCKit/Category/*.{h,m,mm}'
    ss.public_header_files = 'MLCKit/Category/*.h'
  end
  
  s.subspec 'Log' do |ss|
    ss.source_files = 'MLCKit/Log/*.{h,m,mm}'
    ss.public_header_files = 'MLCKit/Log/*.h'
  end
  
  s.subspec 'UI' do |ss|
    ss.source_files = 'MLCKit/UI/*.{h,m,mm}'
    ss.public_header_files = 'MLCKit/UI/*.h'
  end
  
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
