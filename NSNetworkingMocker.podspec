
#
# Be sure to run `pod lib lint NSNetworkingMocker.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'NSNetworkingMocker'
s.version          = '0.1.1'
s.summary          = 'A mocker for help writing tests for network code, or to create a mock api'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
NSNetworkingMocker is a simple library to provide an easy way to mock network requests for unit tests, and provide an easy way to mock APIs while early in development.
DESC

s.homepage         = 'https://github.com/netsells/NSNetworkingMocker'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'ABTucanae' => 'tucanae@icloud.com' }
s.source           = { :git => 'https://github.com/netsells/NSNetworkingMocker.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'
s.swift_version = '4.2'

s.source_files = 'Sources/*/**/*'

end
