

Pod::Spec.new do |spec|

  spec.name         = "TFYMacOSAppKit"

  spec.version      = "1.0.6"

  spec.summary      = "纯代码 macOS 开发基本数据类型封装。最低支持macos 11 控制点语法使用"

  spec.description  = <<-DESC
  纯代码 macOS 开发基本数据类型封装。最低支持macos 11 控制点语法使用
                   DESC

  spec.homepage     = "https://github.com/13662049573/TFYMacOSAppKit_OC"
  
  spec.license      = "MIT"
  
  spec.author       = { "田风有" => "420144542@qq.com" }
  
  spec.osx.deployment_target = "11.0"
  
  spec.source       = { :git => "https://github.com/13662049573/TFYMacOSAppKit_OC.git", :tag => spec.version }

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

  spec.subspec 'macOSchain' do |ss|
    ss.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOSchain/macOSchain.h"

    ss.subspec 'TFYChainBase' do |s|
      s.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOSchain/TFYChainBase/**/*.{h,m}"
    end

    ss.subspec 'TFYCALayer' do |s|
      s.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOSchain/TFYCALayer/**/*.{h,m}"
      s.dependency "TFYMacOSAppKit/macOSchain/TFYChainBase"
    end

    ss.subspec 'TFYNSGesture' do |s|
      s.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOSchain/TFYNSGesture/**/*.{h,m}"
      s.dependency "TFYMacOSAppKit/macOSchain/TFYChainBase"
      s.dependency "TFYMacOSAppKit/macOScategory"
    end

    ss.subspec 'TFYNSView' do |s|
      s.source_files  = "TFYMacOSAppKit_OC/TFYMacOSAppKit/macOSchain/TFYNSView/**/*.{h,m}"
      s.dependency "TFYMacOSAppKit/macOSchain/TFYChainBase"
      s.dependency "TFYMacOSAppKit/macOSchain/TFYNSGesture"
      s.dependency "TFYMacOSAppKit/macOSchain/TFYCALayer"
      s.dependency "TFYMacOSAppKit/macOScontainer"
    end
    
  end

end
