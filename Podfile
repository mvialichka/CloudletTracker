project 'CloudletTracker.xcodeproj'
platform :ios, '10.0'
use_frameworks!
inhibit_all_warnings!

target 'CloudletTracker' do
  pod 'SnapKit', '~> 4.0'
  pod 'Moya/RxSwift', '~> 11.0'
  pod 'Moya-ObjectMapper' 
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.0'
    end
  end
end
