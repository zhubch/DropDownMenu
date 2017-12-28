#ZHDropDownMenu.podspec
Pod::Spec.new do |s|
  s.name     = 'ZHDropDownMenu'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'An open source dropdown menu for iOS written in swift, it is easy to use in your project.'
  s.homepage = 'https://github.com/zhubch/ZHDropDownMenu'
  s.author   = { 'zhubch' => 'cheng4741@gmail.com' }
  s.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source   = { :git => 'https://github.com/zhubch/ZHDropDownMenu.git', :tag => "#{s.version}" }
  s.source_files = 'ZHDropDownMenu/*.swift'
  s.resources = 'ZHDropDownMenu/*.png'
  s.requires_arc = true
  s.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES' }

end
