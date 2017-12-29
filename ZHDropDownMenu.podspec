
Pod::Spec.new do |s|
  s.name             = 'ZHDropDownMenu'
  s.version          = '1.0.0'
  s.summary          = 'An open source dropdown menu for iOS written in swift, it is easy to use in your project'


  s.homepage         = 'https://github.com/zhubinchen/DropDownMenu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'cheng4741@qq.com' => 'cheng4741@qq.com' }
  s.source           = { :git => 'https://github.com/zhubinchen/DropDownMenu.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.platform              = :ios, "8.0"

  s.source_files = 'ZHDropDownMenu/*.swift'
  s.resources = 'ZHDropDownMenu/*.png'
  
  s.requires_arc = true
  s.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES' }



end
