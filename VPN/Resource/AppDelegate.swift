//
//  AppDelegate.swift
//  VPN
//
//  Created by Developer on 03/01/22.
//

import UIKit
import CoreData
import AppsFlyerLib
import Firebase
import StoreKit
import GoogleMobileAds


var OpenApprewardedAd: GADAppOpenAd?


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,GADFullScreenContentDelegate {

    var window: UIWindow?
    
    var openAd:GADAppOpenAd?
    var loadTime = Date()
    var InisrewardedAd: GADInterstitialAd?

    static let sharedAppDelegate = AppDelegate()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // apps flyer confi.
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = ["a5f762722d710b6c8afb91567cef62e5"]
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        configerAppsFlyerSDK()
        FirebaseApp.configure()
        
        do {
            try FileManager.default.removeItem(atPath: NSHomeDirectory() + "/Library/SplashBoard")
        } catch {
        }
        IPASubScriptionService.shared.getProduct()
        getCountryNames()
        serverAddress = UserDefaultsManager().serverAddress ?? ""
        ovpnFile = UserDefaultsManager().serverVPNFile ?? ""
        username = UserDefaultsManager().serverUser ?? ""
        pass = UserDefaultsManager().serverPassword ?? ""
        
        UserDefaultsManager().purchaseStatus = true
        if  !(UserDefaultsManager().purchaseStatus ?? false) {
            loadAds()
            loadInitAds()
        } else  {
            goToRootView()
        }
        return true
    }
    func loadInitAds() {
        InisrewardedAd = nil
        GADInterstitialAd.load(
            withAdUnitID: InisgoogleAdMobKey, request: GADRequest()
        ) { (ad, error) in
            if let error = error {
                print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                return
            }
            print("Loading Succeeded")
            self.InisrewardedAd = ad
            self.InisrewardedAd?.fullScreenContentDelegate = self
        }
    }
    func loadAds() {
        
        let request = GADRequest()
        GADAppOpenAd.load(withAdUnitID: openAppGoogleAdMobKey,
                            request: request,
                            orientation: UIInterfaceOrientation.portrait,
                            completionHandler: { (appOpenAdIn, error) in
                                if let error = error {
                                    print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                                    self.goToRootView()
                                    return
                                }
                                self.openAd = appOpenAdIn
                                self.openAd?.fullScreenContentDelegate = self
                              self.loadTime = Date()
                                print("open add ready")
                                self.tryToPresentAd()
                            })
    }
    
    func configerAppsFlyerSDK(){
        AppsFlyerLib.shared().appsFlyerDevKey = AppFlyerKeys().devKey
        AppsFlyerLib.shared().appleAppID = appid
        AppsFlyerLib.shared().delegate = self
        AppsFlyerLib.shared().isDebug = false
        AppsFlyerLib.shared().deepLinkDelegate = .none
        AppsFlyerLib.shared().start()
        
    }
    
    func tryToPresentAd() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var homecontroller = UIViewController()

        if !(UserDefaultsManager().isFirstTime ?? false){
            homecontroller = storyboard.instantiateViewController(withIdentifier: "OnBoardingVC") as!  OnBoardingVC
        }
//        } else if !(UserDefaultsManager().isPrivacyAccepted ?? false){
//            homecontroller = storyboard.instantiateViewController(withIdentifier: "PrivacyImportantVC") as! PrivacyImportantVC
//        }
            else {
            homecontroller = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        }


        let homeNavi = UINavigationController(rootViewController: homecontroller)
        homeNavi.navigationBar.isHidden = true
        homeNavi.interactivePopGestureRecognizer?.isEnabled = false
        self.window?.rootViewController = homeNavi
        if let gOpenAd = self.openAd, let rwc = self.window?.rootViewController, wasLoadTimeLessThanNHoursAgo(thresholdN: 4) {
            self.window?.makeKeyAndVisible()
            gOpenAd.present(fromRootViewController: rwc)

        } else {
            loadAds()
        }
    }

    func wasLoadTimeLessThanNHoursAgo(thresholdN: Int) -> Bool {
        let now = Date()
        let timeIntervalBetweenNowAndLoadTime = now.timeIntervalSince(self.loadTime)
        let secondsPerHour = 3600.0
        let intervalInHours = timeIntervalBetweenNowAndLoadTime / secondsPerHour
        return intervalInHours < Double(thresholdN)
    }
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("dismissfull")
        goToRootView()

    }
    func goToRootView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var homecontroller = UIViewController()
        
        if !(UserDefaultsManager().isFirstTime ?? false){
            homecontroller = storyboard.instantiateViewController(withIdentifier: "OnBoardingVC") as! OnBoardingVC
        }
//        else if !(UserDefaultsManager().isPrivacyAccepted ?? false){
//            homecontroller = storyboard.instantiateViewController(withIdentifier: "PrivacyImportantVC") as! PrivacyImportantVC
//        }
        else {
            homecontroller = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        }
        
        
        let homeNavi = UINavigationController(rootViewController: homecontroller)
        homeNavi.navigationBar.isHidden = true
        homeNavi.interactivePopGestureRecognizer?.isEnabled = false
        self.window?.rootViewController = homeNavi
        self.window?.makeKeyAndVisible()
    }
    
    
    
    // Open Deeplinks
    // Open URI-scheme for iOS 8 and below
    private func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
    // Open URI-scheme for iOS 9 and above
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    // Report Push Notification attribution data for re-engagements
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerLib.shared().handleOpen(url, options: options)
        return true
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        AppsFlyerLib.shared().handlePushNotification(userInfo)
    }
    // Reports app open from deep link for iOS 10 or later
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        AppsFlyerLib.shared().continue(userActivity, restorationHandler: nil)
        return true
    }

}

extension AppDelegate:AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable : Any]) {
        print("onConversionDataSuccess data:")
        for (key, value) in conversionInfo {
            print(key, ":", value)
        }
        if let status = conversionInfo["af_status"] as? String {
            if (status == "Non-organic") {
                if let sourceID = conversionInfo["media_source"],
                   let campaign = conversionInfo["campaign"] {
                    print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                }
            } else {
                print("This is an organic install.")
            }
            if let is_first_launch = conversionInfo["is_first_launch"] as? Bool,
               is_first_launch {
                print("First Launch")
            } else {
                print("Not First Launch")
            }
        }
    }
    
    func onConversionDataFail(_ error: Error) {
        print(error)
    }
    //Handle Deep Link
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]) {
        //Handle Deep Link Data
        print("onAppOpenAttribution data:")
        for (key, value) in attributionData {
            print(key, ":",value)
        }
    }
    func onAppOpenAttributionFailure(_ error: Error) {
        print(error)
    }
    
    
}
