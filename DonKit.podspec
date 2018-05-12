#
# Be sure to run `pod lib lint DonKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DonKit'
  s.version          = '0.1.0'
  s.summary          = 'A short description of DonKit.'
  s.description      = <<-DESC
iOS 🛠🔧
                       DESC

  s.homepage         = 'https://github.com/donholly/DonKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Don Holly' => 'don.holly@gmail.com' }
  s.source           = { :git => 'https://github.com/donholly/DonKit.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/donholly'

  s.ios.deployment_target = '9.0'

  s.source_files = 'DonKit/Classes/**/*'
end
