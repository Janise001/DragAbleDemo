source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
#Framework

install! 'cocoapods', :deterministic_uuids => false

abstract_target 'MobileRobotDemo' do
    
   pod 'SnapKit'
   pod 'IQKeyboardManagerSwift'
   pod 'RxSwift'
    
    target:'MobileRobotDemo' do
        target 'MobileRobotDemoUITests' do
            inherit! :search_paths
        end
        target 'MobileRobotDemoTests' do
            inherit! :search_paths
        end
    end
end

