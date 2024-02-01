# Uncomment the next line to define a global platform for your project
# platform :ios, '13.0'

target 'VPN' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VPN

  pod 'RevealingSplashView'
  pod 'SwiftyJSON', '~> 4.0'
#  pod 'Alamofire'
  pod 'AppsFlyerFramework'
  pod 'liquid-swipe'
  pod 'BBWebImage'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
#  pod 'JTMaterialSpinner', '~> 3.0'
  pod 'SwiftWebVC'
  pod 'IQKeyboardManager'  #iOS8 and later
  pod 'NVActivityIndicatorView'

  pod 'Google-Mobile-Ads-SDK'



  target 'VPNTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'VPNUITests' do
    # Pods for testing
  end

end

target 'VPNNetworkExtention' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pod 'OpenVPNAdapter', :git => 'https://github.com/ss-abramchuk/OpenVPNAdapter.git', :tag => '0.8.0'

  # Pods for VPNExtention

end
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      xcconfig_path = config.base_configuration_reference.real_path
      xcconfig = File.read(xcconfig_path)
      xcconfig_mod = xcconfig.gsub(/DT_TOOLCHAIN_DIR/, "TOOLCHAIN_DIR")
      File.open(xcconfig_path, "w") { |file| file << xcconfig_mod }
    end
  end
end
