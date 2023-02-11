

Pod::Spec.new do |spec|

  spec.name         = "TFYMacOSAppKit"

  spec.version      = "1.0.0"

  spec.summary      = "macOS 开发基本数据类型封装。最低支持macos 11 "

  spec.description  = <<-DESC
  macOS 开发基本数据类型封装。最低支持macos 11 
                   DESC

  spec.homepage     = "http://EXAMPLE/TFYMacOSAppKit"
  
  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }
  
  spec.osx.deployment_target = "11.0"
  
  spec.source       = { :git => "http://EXAMPLE/TFYMacOSAppKit.git", :tag => spec.version }

  spec.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/TFYMacOSAppKit.h"
  
  spec.subspec 'macOScategory' do |ss|
    ss.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOScategory/**/*.{h,m}"
  end

  spec.subspec 'macOScontainer' do |ss|
    ss.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOScontainer/**/*.{h,m}"
    ss.dependency "TFYMacOSAppKit/macOScategory"
    ss.dependency "TFYMacOSAppKit/macOSfoundation"
  end

  spec.subspec 'macOSfoundation' do |ss|
    ss.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOSfoundation/**/*.{h,m}"
    ss.dependency "TFYMacOSAppKit/macOScategory"
  end


end
