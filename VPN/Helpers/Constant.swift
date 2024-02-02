//
//  Constant.swift
//  VPN
//
//  Created by Developer on 03/01/22.
//

import Foundation
import UIKit
struct AppColors {
    static var PinkAppColor:UIColor = #colorLiteral(red: 0.2549019608, green: 0.5254901961, blue: 0.9490196078, alpha: 1)
    static var BlackColor:UIColor = UIColor.black
    static var GradiantFirst:UIColor = UIColor(red: 255/255, green: 36/255, blue: 79/255, alpha: 1)
    static var GradiantSecond:UIColor = UIColor(red: 253/255, green: 1/255, blue: 119/255, alpha: 1)
    static var backGroundBlack:UIColor = UIColor(red: 25/255, green: 25/255, blue: 25/255, alpha: 1)
}

struct  AppFlyerKeys {
    let devKey = "pixwSK68ZSrjHiPfrVoADK"
}

let appid = "1572986681"
extension NSNotification.Name{
    static let purchaseNotif = Notification.Name("purchaseNotife")
    static let noRestordData = Notification.Name("noRestordData")
}






//ca-app-pub-5648491240416581/9532800852
var InisgoogleAdMobKey = "ca-app-pub-5648491240416581/2393511580"
var openAppGoogleAdMobKey = "ca-app-pub-5648491240416581/6523494135"
//var InisrewardedAd: GADInterstitialAd?

let appName = "VPN Daily"

var contrySy = ""

var wPrice = ""
var mPrice = ""
var yPrice = ""

var fyPrice = ""
var fMPrice = ""
var fWPrice = ""

var mOfferPrice = ""
var wOfferPrice = ""
var yOfferPrice = ""


var blackView: UIView? = nil
func showActivityWithMessage(message: String, inView view: UIView) {
    if blackView == nil {
        blackView = UIView(frame: UIScreen.main.bounds)
        blackView!.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        var factor: Float = 1.0
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            factor = 2.0
        }
        
        var rect = CGRect.init()
        rect.size.width = CGFloat(factor * Float(200))
        rect.size.height = CGFloat(factor * Float(70))
        rect.origin.y = CGFloat((blackView?.frame.size.height)! - rect.size.height) / CGFloat(2.0)
        rect.origin.x = CGFloat((blackView?.frame.size.width)! - rect.size.width) / CGFloat(2.0)
        
        let waitingView = UIView(frame: rect)
        waitingView.backgroundColor = UIColor.clear
        waitingView.layer.cornerRadius = 8.0
        
        rect = waitingView.bounds;
        rect.size.height = CGFloat(Float(40.0) * factor);
        
        let label = UILabel(frame: rect)
        label.text = message
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: CGFloat(Float(16.0) * factor))//UIFont(name: APP_BOLD_FONT, size: CGFloat(Float(16.0) * factor))
        waitingView.addSubview(label)
        var activityIndicatorView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        } else {
            activityIndicatorView = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.gray)
        }
        activityIndicatorView.color = UIColor.white
        
        rect = activityIndicatorView.frame;
        rect.origin.x = ((waitingView.frame.size.width - rect.size.width)/2.0);
        rect.origin.y = label.frame.size.height + 3.0;
        activityIndicatorView.frame = rect;
        
        waitingView.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
        
        blackView?.tag = 1010
        blackView?.addSubview(waitingView)
        view.addSubview(blackView!)
    }
}
func hideActivity() {
    blackView?.removeFromSuperview()
    blackView = nil
}
func showAlet(message:String,Title:String,controller:UIViewController,finished:@escaping (Bool) -> ()) {
    let alertMessage = UIAlertAction(title: "Ok", style: .default) { (action) in
        finished(true)
    }
    
    let alert = UIAlertController(title: "\(Title)", message: "\(message)", preferredStyle: .alert)
    alert.addAction(alertMessage)
    controller.present(alert, animated: true, completion: nil)
}



func CalltimeFormatted(_ totalSeconds: Int,hourFormate:Bool) -> String {
        let hours = Int(totalSeconds) / 3600

        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d:%02d",hours, minutes, seconds)
        
    }
