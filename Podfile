source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '11.0'
use_frameworks!

### Specify Swift version to 4.0
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |configuration|
      configuration.build_settings['SWIFT_VERSION'] = "4.0"
    end
  end
end

### Pod files
target 'Moodoo' do
    pod 'JTAppleCalendar', '~> 7.0'
    pod 'Firebase/Core'
end
