//
//  HomeVC.swift
//  VPN
//
//  Created by Developer on 05/01/22.
//

import UIKit
import NVActivityIndicatorView
import NetworkExtension
import WebKit
import SwiftWebVC
import GoogleMobileAds
import SpeedcheckerSDK
import CoreLocation

class HomeVC: UIViewController, GADFullScreenContentDelegate, SubScriptionProtocol {
    func GoToSubScrption() {
        
    }
    var Count = 0
    private var locationManager = CLLocationManager()
    private var internetTest: InternetSpeedTest?
    var finishDownloadStats = false
    var finishUploadStats = false
    
    @IBOutlet weak var timeManageLbl: UILabel!
    
    @IBOutlet weak var connectLbl: UILabel!
    @IBOutlet weak var selectedServerName: UILabel!
    @IBOutlet weak var selectedServerImg: UIImageView!
    
    @IBOutlet weak var upGradeBtn: UIButton!
    @IBOutlet weak var upgradView: UIView!
    var gradiant:CAGradientLayer!
    
    @IBOutlet weak var switchBgView: UIView!
    @IBOutlet weak var switchOnOffImg: UIImageView!
    @IBOutlet weak var connectionView: NVActivityIndicatorView!
    @IBOutlet weak var ConnectBtn: UIButton!
    @IBOutlet weak var speedViewHeight: NSLayoutConstraint!//60
    @IBOutlet var speedView: UIView!
    @IBOutlet weak var uploadSpeedLbl: UILabel!
    @IBOutlet weak var downloadSpeedLbl: UILabel!
    var isConnected = false

    
    var myticker : Timer?
    var pulseAnimation:Timer?
    
    var manager: NETunnelProviderManager?
    var InisrewardedAd: GADInterstitialAd?

    var timer: Timer?

    override func viewWillAppear(_ animated: Bool) {
        selectedServerImg.image = countriesData[selectedContryIndex].countryImage
        selectedServerName.text = countriesData[selectedContryIndex].name
        VPNStatus()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        internetTest = InternetSpeedTest(delegate: self)

        
        if CLLocationManager.locationServicesEnabled() {
                    locationManager.delegate = self
                    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
                    locationManager.requestWhenInUseAuthorization()
                    locationManager.requestAlwaysAuthorization()
                    locationManager.startUpdatingLocation()
                }
        
//        connectLbl.text = "TAP TO CONNNECT"
        
        upgradView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: 0)
        

        uploadSpeedLbl.text = "- "
        downloadSpeedLbl.text = "- "
        
        
        VPNStatus()
        if !(UserDefaultsManager().purchaseStatus ?? false) {
                    GADInterstitialAd.load(
                        withAdUnitID: InisgoogleAdMobKey, request: GADRequest()
                    ) { (ad, error) in
                        if let error = error {
                            print("Rewarded ad failed to load with error: \(error.localizedDescription)")
                            
                                      let initialVC = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
//                                      initialVC.modalPresentationStyle = .popover
                                      initialVC.delegate = self
                                      self.present(initialVC, animated: true) {
                                          print("done ")
                                      }
                            return
                        }
                        print("Loading Succeeded")
                        self.InisrewardedAd = ad
                        self.InisrewardedAd?.fullScreenContentDelegate = self
                        self.InisrewardedAd?.present(fromRootViewController: self)
                    }
                }
        NotificationCenter.default.addObserver(self, selector: #selector(self.VPNStatusDidChange(_:)), name: NSNotification.Name.NEVPNStatusDidChange, object: nil)
        // Do any additional setup after loading the view.
    }
    func VPNStatus() {
        
        if isVPNConnected() {
           
            
            CheckSpeed()
            
            timeManageLbl.isHidden = false
            StopLoading()
            stopPluseAnimation()
            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            UserDefaultsManager().isConnectedToVPN = true

            
            
            self.connectLbl.text = "CONNECTED"
            speedView.isHidden = false
            
            switchOnOffImg.image = #imageLiteral(resourceName: "switch-on")
            if gradiant != nil  {
                gradiant.removeFromSuperlayer()
            }
            gradiant = switchBgView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: switchBgView.frame.height / 2)
        } else {
            
            self.Count = 0
            self.timeManageLbl.text = "00:00:00"
            
            timeManageLbl.isHidden = true
            StopLoading()
            startPulseAnimation()
            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.connectLbl.text = "TAP TO CONNECT"
            if gradiant != nil  {
                gradiant.removeFromSuperlayer()
            }
            connectionView.stopAnimating()
            switchOnOffImg.image = #imageLiteral(resourceName: "switch-off")
            switchBgView.cornerRadius = Double(switchBgView.frame.width / 2)
            UserDefaultsManager().isConnectedToVPN = false
            switchBgView.backgroundColor = AppColors.backGroundBlack
            switchBgView.borderWidth = 2
            switchBgView.borderColor = AppColors.PinkAppColor
//            switchOnOffImg.image = #imageLiteral(resourceName: "switch-off")
//            switchBgView.cornerRadius = Double(switchBgView.frame.height / 2)
//            switchBgView.backgroundColor = AppColors.backGroundBlack
//            switchBgView.borderWidth = 2
//            switchBgView.borderColor = AppColors.PinkAppColor
//
//            UserDefaultsManager().isConnectedToVPN = false
           
        }
    }
    @IBAction func ConnectBtnTap(_ sender: UIButton) {
        
        if self.isVPNConnected() || connectLbl.text?.lowercased() == "connected".lowercased()  {
            self.ConnectNetwork()
        } else {
            self.ConnectNetwork()
        }
        
        
//        if gradiant != nil  {
//            gradiant.removeFromSuperlayer()
//        }
//
//        if UserDefaultsManager().isConnectedToVPN ?? true {
//            speedView.isHidden = false
////            connectionView.stopAnimating()
//            switchOnOffImg.image = #imageLiteral(resourceName: "switch-off")
//            switchBgView.cornerRadius = Double(switchBgView.frame.height / 2)
//            UserDefaultsManager().isConnectedToVPN = false
//            switchBgView.backgroundColor = AppColors.backGroundBlack
//            switchBgView.borderWidth = 2
//            switchBgView.borderColor = AppColors.PinkAppColor
//        } else {
////            connectionView.startAnimating()
//            switchOnOffImg.image = #imageLiteral(resourceName: "switch-on")
//            UserDefaultsManager().isConnectedToVPN = true
//            gradiant = switchBgView.applyGradient(colours: [AppColors.GradiantFirst,AppColors.GradiantSecond], locations: [0.0,0.5,1.0], corner: switchBgView.frame.height / 2)
//        }
    }
    
    
    @IBAction func upgradeBtnTap(_ sender: UIButton) {
        let subScriptionVC = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
        subScriptionVC.isWhereToCome = "list"

      self.navigationController?.pushViewController(subScriptionVC, animated: true)
    }
    
    @IBAction func severListBtnTap(_ sender: UIButton) {
        let severList = self.storyboard?.instantiateViewController(withIdentifier: "ServerListVC") as! ServerListVC
      self.navigationController?.pushViewController(severList, animated: true)
    }
    
    
    @IBAction func settingBtnTap(_ sender: UIButton) {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingVC
      self.navigationController?.pushViewController(settingVC, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// All functions
extension HomeVC {
    
    func setupUI() {
        
        startPulseAnimation()
        if !(UserDefaultsManager().purchaseStatus ?? false) {
                       if let ad = InisrewardedAd {
       //
                           ad.present(fromRootViewController: self)
                       }
                   }
    }
    
    func startPulseAnimation() {
        print("pulse start")
        guard pulseAnimation == nil else { return }
        
        pulseAnimation = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(PulseAnimation), userInfo: nil, repeats: true)
    }
    
    @objc func PulseAnimation() {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction,.autoreverse], animations: {
            self.ConnectBtn.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { (_) in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [.allowUserInteraction], animations: {
                self.ConnectBtn.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
    
    func stopPluseAnimation() {
        print("pulse stop")
        pulseAnimation?.invalidate()
        pulseAnimation = nil
        //        self.connectBtn.transform = CGAffineTransform.identity
        
    }
    
    
    func StopLoading()  {
        myticker?.invalidate()
        myticker = nil
        connectLbl.text = "TAP TO CONNECT"
    }
    
    func LabelAnimating() {
        guard myticker == nil else { return }
        
        myticker  = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(showLoading), userInfo: nil, repeats: true)
    }
    
    @objc func showLoading() {
        if UserDefaultsManager().isConnectedToVPN ?? false {
            connectLbl.textColor = AppColors.PinkAppColor
            if connectLbl.text == "Disconnecting." {
                connectLbl.text = "Disconnecting.."
            } else if connectLbl.text == "Disconnecting.." {
                connectLbl.text = "Disconnecting..."
            } else if connectLbl.text == "Disconnecting..." {
                connectLbl.text = "Disconnecting...."
            }  else if connectLbl.text == "Disconnecting...." {
                connectLbl.text = "Disconnecting."
            } else {
                connectLbl.text = "Disconnecting."
            }
        } else {
            connectLbl.textColor = AppColors.PinkAppColor
            if connectLbl.text == "Connecting." {
                connectLbl.text = "Connecting.."
            } else if connectLbl.text == "Connecting.." {
                connectLbl.text = "Connecting..."
            } else if connectLbl.text == "Connecting..." {
                connectLbl.text = "Connecting...."
            }  else if connectLbl.text == "Connecting...." {
                connectLbl.text = "Connecting."
            } else {
                connectLbl.text = "Connecting."
            }
        }
    }
    
    
    @objc func updateTimer() {
        
        Count += 1
        self.timeManageLbl.text = CalltimeFormatted(Count, hourFormate: false) // will show timer
        
    }
}


// VPN Handler
extension  HomeVC {
    
    // check vpn is connected or not
    func isVPNConnected() -> Bool {
        let cfDict = CFNetworkCopySystemProxySettings()
        let nsDict = cfDict!.takeRetainedValue() as NSDictionary
        
        if nsDict.allKeys.count > 0 {
            let keys = nsDict["__SCOPED__"] as! NSDictionary
            for key: String in keys.allKeys as! [String] {
                if (key == "tap" || key == "utun2" || key == "tun" || key == "ppp" || key == "ipsec" || key == "ipsec0" || key.contains("utun")) {
                    return true
                }
            }
        } else {
            return false
        }
        
        return false
    }
    
    
    
    // connect to network
    func ConnectNetwork() {
        self.view.isUserInteractionEnabled = false
        //        selectedContryIndex = centerFlowLayout.currentCenteredPage ?? 0
        serverAddress = countriesData[selectedContryIndex].serverAddressArr
        ovpnFile = countriesData[selectedContryIndex].serverName
        username = countriesData[selectedContryIndex].serverUser
        pass = countriesData[selectedContryIndex].serverPass
        
        UserDefaultsManager().serverName = countriesData[selectedContryIndex].name
        UserDefaultsManager().serverAddress = serverAddress
        UserDefaultsManager().serverVPNFile = ovpnFile
        UserDefaultsManager().serverUser = username
        UserDefaultsManager().serverPassword = pass
        
        print("Go!")
        
        if UserDefaultsManager().purchaseStatus ?? false {
            let callback = { (error: Error?) -> Void in
                self.manager?.loadFromPreferences(completionHandler: { (error) in
                    guard error == nil else {
                        print("\(error!.localizedDescription)")
                        return
                    }
                    
                    let options: [String : NSObject] = [
                        "username": username as NSString,
                        "password": pass as NSString
                    ]
                    print("options \(options)")
                    if (self.connectLbl.text != "Connected".uppercased()) && !self.isVPNConnected()  {
                        
                        do {
                            try self.manager?.connection.startVPNTunnel()
                        } catch {
                            self.view.isUserInteractionEnabled = true
                            UserDefaultsManager().isConnectedToVPN = false
//                            self.StopLoading()
//                            self.stopPluseAnimation()
//                            self.connectionView.stopAnimating()
//                            self.ConnectBtn.setImage(#imageLiteral(resourceName: "switch-off"), for: .normal)
                            self.connectLbl.text = "TAP TO CONNECT"
                            self.VPNStatus()

                            
                        }
                    }else{
                        
                        self.manager?.connection.stopVPNTunnel()
                    }
                })
            }
            
            configureVPN(callback: callback)
        }
        else{
            self.view.isUserInteractionEnabled = true
            UserDefaultsManager().isConnectedToVPN = false
            
            let subscriptionVc = self.storyboard?.instantiateViewController(withIdentifier: "subScriptionVC") as! subScriptionVC
            subscriptionVc.isWhereToCome = "list"

            self.navigationController?.pushViewController(subscriptionVc, animated: true)
        }
    }
    
    
    // configure VPN in setting
    
    
    func configureVPN(callback: @escaping (Error?) -> Void) {
        guard
            let configurationFile = Bundle.main.url(forResource: ovpnFile, withExtension: "ovpn"),
            let configurationContent = try? Data(contentsOf: configurationFile)
        else {
            
            
            
            
            
            UserDefaultsManager().isConnectedToVPN = false
            print("Disconnected...")
            
            fatalError()
        }
        
        
        NETunnelProviderManager.loadAllFromPreferences { (managers, error) in
            guard error == nil else {
                
                UserDefaultsManager().isConnectedToVPN = false
                callback(error)
                return
            }
            
            self.manager = managers?.first ?? NETunnelProviderManager()
            self.manager?.loadFromPreferences(completionHandler: { (error) in
                guard error == nil else {
                    
                    
                    
                    UserDefaultsManager().isConnectedToVPN = false
                    print("Disconnected...")
                    
                    callback(error)
                    return
                }
                
                let tunnelProtocol = NETunnelProviderProtocol()
                
                if #available(iOS 14.0, *) {
                    tunnelProtocol.includeAllNetworks = true
                } else {
                    // Fallback on earlier versions
                }
                tunnelProtocol.serverAddress = ""
                tunnelProtocol.providerBundleIdentifier = targetBundleId
                tunnelProtocol.providerConfiguration = ["ovpn":configurationContent]
                
                self.manager?.protocolConfiguration = tunnelProtocol
                self.manager?.localizedDescription = "VPN Daily"
                self.manager?.isEnabled = true
                
                
                self.manager?.saveToPreferences(completionHandler: { (error) in
                    guard error == nil else {
                        print("\(error!.localizedDescription)")
                        
                        
                        
                        UserDefaultsManager().isConnectedToVPN = false
                        print("Disconnected...")
                        callback(error)
                        return
                    }
                    callback(nil)
                })
            })
            
        }
    }
    
    func CheckSpeed() {
        print("in speed checker")
        if isVPNConnected() {
            print("in if  speed checker")
            internetTest = InternetSpeedTest(delegate: self)
            
                    internetTest?.startTest() { (error) in
                        
                    }
            
        } else {
            print("in else  speed checker")
            showAlet(message: "Turn on vpn first", Title: "Warnning!", controller: self) { status in
                
            }
            
        }
    }
    
    // check VPN is connected or not via notificaton
    @objc func VPNStatusDidChange(_ notification: Notification?) {
        
        print("VPN Status changed:")
        let status = self.manager?.connection.status
        switch status {
        case .connecting:
            self.view.isUserInteractionEnabled = false
            
            
            stopPluseAnimation()
            connectionView.startAnimating()
            
            LabelAnimating()
            break
        case .connected:
//            StopLoading()
//            stopPluseAnimation()
//            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            UserDefaultsManager().isConnectedToVPN = true
//            connectBtn.setImage(#imageLiteral(resourceName: "connectIcon"), for: .normal)
//
//            print("Connected...")
//
//            self.connectLbl.text = "CONNECTED"
//            self.connectLbl.textColor = AppColors.AppColor
            
            VPNStatus()
            Count = 0
            self.timeManageLbl.text = "00:00:00"
            self.timeManageLbl.isHidden = false
            if timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            if !(UserDefaultsManager().purchaseStatus ?? false)  {
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
                            self.InisrewardedAd?.present(fromRootViewController: self)
                        }
                    }
            
            break
        case .disconnecting:
            connectionView.startAnimating()
            LabelAnimating()
            Count = 0
            self.timeManageLbl.text = "00:00:00"
            self.timeManageLbl.isHidden = false
            if timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }
            self.view.isUserInteractionEnabled = false
            print("Disconnecting...")
            break
        case .disconnected:
            self.timeManageLbl.text = "00:00:00"
            self.timeManageLbl.isHidden = false
            if timer != nil {
                self.timer?.invalidate()
                self.timer = nil
            }
            
            uploadSpeedLbl.text = "- "
            downloadSpeedLbl.text = "- "
            
//            StopLoading()
//            startPulseAnimation()
//            connectionView.stopAnimating()
//            print("Disconnected.")
//            self.view.isUserInteractionEnabled = true
//            self.connectLbl.text = "TAP TO CONNECT"
//            self.connectLbl.textColor = AppColors.PinkAppColor
//            ConnectBtn.setImage(#imageLiteral(resourceName: "disconnectIcon"), for: .normal)
            
            VPNStatus()

            if !(UserDefaultsManager().purchaseStatus ?? false) {
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
                            self.InisrewardedAd?.present(fromRootViewController: self)
                        }
                    }
            break
        case .invalid:
            StopLoading()
            startPulseAnimation()
            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.connectLbl.text = "TAP TO CONNECT"
            self.connectLbl.textColor = AppColors.PinkAppColor
            VPNStatus()
            
            break
        case .reasserting:
            StopLoading()
            startPulseAnimation()
            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.connectLbl.text = "TAP TO CONNECT"
            VPNStatus()
            print("Reasserting...")
            break
        case .none:
            StopLoading()
            startPulseAnimation()
            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            self.connectLbl.text = "TAP TO CONNECT"
            self.connectLbl.textColor = AppColors.PinkAppColor
            VPNStatus()
        case .some(_):
            StopLoading()
            startPulseAnimation()
            connectionView.stopAnimating()
            self.view.isUserInteractionEnabled = true
            VPNStatus()
        }
    }
    
}


extension HomeVC:InternetSpeedTestDelegate,CLLocationManagerDelegate {
    func internetTestError(error: SpeedTestError) {
        print("")
    }
    
    func internetTestFinish(result: SpeedTestResult) {
        print("")
    }
    
    func internetTestReceived(servers: [SpeedTestServer]) {
        print("")

    }
    
    func internetTestSelected(server: SpeedTestServer, latency: Int, jitter: Int) {
        print(latency)
    }
    
    func internetTest(finish error: SpeedTestError) {
           print(error)
       }
       
       func internetTest(finish result: SpeedTestResult) {
        DispatchQueue.main.async {
            
//            AppDelegate.sharedAppDelegate.hideActivity()
            self.uploadSpeedLbl.text = "\(result.uploadSpeed.mbps.rounded())"
            self.downloadSpeedLbl.text = "\(result.downloadSpeed.mbps.rounded())"
           }
        
           print(result.downloadSpeed.mbps)
           print(result.uploadSpeed.mbps)
           print(result.latencyInMs)
           
       }
    
    func internetTest(received servers: [SpeedTestServer]) {
        
    }
    
    func internetTest(selected server: SpeedTestServer, latency: Int) {
        
    }
    
    func internetTestDownloadStart() {
//        DispatchQueue.main.async {
//            self.downloadIcon.startShimmeringAnimation(animationSpeed: 1.5, direction: .topToBottom, repeatCount: MAXFLOAT,lightColor: UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor,darkColor: UIColor.black.cgColor)
//        }
        print("start download")
        
    }
    
    func internetTestDownloadFinish() {
        print("finsh download")
//        downloadIcon.stopShimmeringAnimation()
        finishDownloadStats = true
    }
    
    func internetTestDownload(progress: Double, speed: SpeedTestSpeed) {
        
        
            DispatchQueue.main.async {
                let speedCheck = speed.mbps.rounded()
                self.downloadSpeedLbl.text = "\(speedCheck ?? 0)"
               }
        
    }
    
    func internetTestUploadStart() {
        
        print("start upload")
    }
    
    func internetTestUploadFinish() {
        print("finsh upload")
        
        finishUploadStats = true
    }
    
    func internetTestUpload(progress: Double, speed: SpeedTestSpeed) {
        if !finishUploadStats {
            DispatchQueue.main.async {
                let speedCheck = speed.mbps.rounded()
                self.uploadSpeedLbl.text = "\(speedCheck ?? 0)"
               }
        }
    }
    
}
