#DropDownMenu.podspec
Pod::Spec.new do |s|
  s.name     = 'DropDownMenu'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'An open source DropDownMenu for iOS.'
  s.homepage = 'https://github.com/zhubch/DropDownMenu'
  s.author   = { 'zhubch' => 'cheng4741@gmail.com' }
  s.platform = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source   = { :git => 'https://github.com/zhubch/DropDownMenu.git', :tag => "#{s.version}" }
  s.source_files = 'DropDownMenu/*.swift'
  s.resources = 'DropDownMenu/*.png'
  s.requires_arc = true
  s.xcconfig = { 'CLANG_MODULES_AUTOLINK' => 'YES' }

end
