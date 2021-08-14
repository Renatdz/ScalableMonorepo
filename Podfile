source 'https://cdn.cocoapods.org/'

platform :ios, '11.0'
use_frameworks!

workspace 'ScalableMonorepo'

def ui_helper_pods
    pod 'lottie-ios', '~> 3.2.3'
    pod 'SnapKit', '~> 5.0.1'
end

target 'ScalableMonorepo' do
    project 'ScalableMonorepo/ScalableMonorepo.project'
  
    ui_helper_pods

    target 'ScalableMonorepoTests' do
        inherit! :search_paths
    end
end

target 'UIHelper' do
    project 'Modules/Helpers/UIHelper/UIHelper.project'
    
    ui_helper_pods
    
    target 'UIHelperTests' do
        inherit! :search_paths
    end

    target 'UIHelperSample' do
        inherit! :complete
        platform :ios, '14.0'
    end
end

target 'LoginFeature' do
    project 'Modules/Features/LoginFeature/LoginFeature.project'
    
    ui_helper_pods
    
    target 'LoginFeatureTests' do
        inherit! :search_paths
    end
    
    target 'LoginFeatureSample' do
        inherit! :complete
        platform :ios, '14.0'
        
        ui_helper_pods
    end
end
