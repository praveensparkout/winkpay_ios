#
# Be sure to run `pod lib lint WinkPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'WinkPay'
    s.version          = '0.1.0'
    s.summary          = 'A short description of WinkPay.'
    s.description      = 'The Payment Wallet'
    
    s.homepage         = 'https://github.com/sathishvgs/WinkPay'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'sathishvgs' => 'vgsathish1995@gmail.com' }
    s.source           = { :git => 'https://github.com/sathishvgs/WinkPay.git', :tag => s.version.to_s }
    
    s.swift_version    = '4.0'
    s.ios.deployment_target = '10.0'
    
    s.source_files = 'WinkPay/Classes/**/*.{swift}'
    s.resources = 'AwBusinessLine/Classes/**/*.{xib}'
    s.resource_bundles = {
        'WinkPay' => [
        'WinkPay/Classes/**/*.{storyboard,ttf}',
        'WinkPay/Assets/**/*.{xcassets}']
    }
    s.dependency 'PromiseKit', '~> 6.0'
    s.dependency 'Moya'
    s.dependency 'SwiftyJSON'
    
end
