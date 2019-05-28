#
# Be sure to run `pod lib lint vc_db.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'vc_db'
  s.version          = '0.1.0'
  s.summary          = 'A short description of vc_db.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
维词数据库操作底层封装
                       DESC

  s.homepage         = 'https://github.com/daydreamsan/vc_db'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'daydreamsan' => '1051747376@qq.com' }
  s.source           = { :git => 'https://github.com/daydreamsan/vc_db.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'vc_db/Classes/**/*'
  
  # s.resource_bundles = {
  #   'vc_db' => ['vc_db/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'FMDB', '~> 2.6.2'
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'JSONModel', '~> 1.7.0'
end
