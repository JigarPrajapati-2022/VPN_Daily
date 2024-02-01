//
//  UserdefaultManager.swift
//  VPN
//
//  Created by Developer on 04/01/22.
//

import Foundation
import UIKit
class UserDefaultsManager {
    
    var purchaseStatus = UserDefaults.standard.value(forKey: userdefault().purchaseStatus) as? Bool {
        didSet { UserDefaults.standard.set(self.purchaseStatus ?? "", forKey: userdefault().purchaseStatus) }
    }
    
    var purchasePlan = UserDefaults.standard.value(forKey: userdefault().purchasePlan) as? String {
        didSet { UserDefaults.standard.set(self.purchasePlan ?? "", forKey: userdefault().purchasePlan) }
    }
    
    
    var isFirstTime = UserDefaults.standard.value(forKey: userdefault().isFirstTime) as? Bool {
        didSet { UserDefaults.standard.set(self.isFirstTime ?? "", forKey: userdefault().isFirstTime) }
    }
    
    var isPrivacyAccepted = UserDefaults.standard.value(forKey: userdefault().isPrivacyAccepted) as? Bool {
            didSet { UserDefaults.standard.set(self.isPrivacyAccepted ?? "", forKey: userdefault().isPrivacyAccepted) }
        }
    
    var weeklyPrice = UserDefaults.standard.value(forKey: userdefault.Prices().WeekPrice) as? String {
        didSet { UserDefaults.standard.set(self.weeklyPrice ?? "", forKey: userdefault.Prices().WeekPrice) }
    }
    
    var monthlyPrice = UserDefaults.standard.value(forKey: userdefault.Prices().MonthPrice) as? String {
        didSet { UserDefaults.standard.set(self.monthlyPrice ?? "", forKey: userdefault.Prices().MonthPrice) }
    }
    var yearlyPrice = UserDefaults.standard.value(forKey: userdefault.Prices().YearPrice) as? String {
        didSet { UserDefaults.standard.set(self.yearlyPrice ?? "", forKey: userdefault.Prices().YearPrice) }
    }
    
    
    
    var weeklyOfferPrice = UserDefaults.standard.value(forKey: userdefault.PricesOfferPrice().WeekOfferPrice) as? String {
            didSet { UserDefaults.standard.set(self.weeklyOfferPrice ?? "", forKey: userdefault.PricesOfferPrice().WeekOfferPrice) }
        }
        
        var monthlyOfferPrice = UserDefaults.standard.value(forKey: userdefault.PricesOfferPrice().MonthOfferPrice) as? String {
            didSet { UserDefaults.standard.set(self.monthlyOfferPrice ?? "", forKey: userdefault.PricesOfferPrice().MonthOfferPrice) }
        }
        var yearlyOfferPrice = UserDefaults.standard.value(forKey: userdefault.PricesOfferPrice().YearOfferPrice) as? String {
            didSet { UserDefaults.standard.set(self.yearlyOfferPrice ?? "", forKey: userdefault.PricesOfferPrice().YearOfferPrice) }
        }
    
    
    var serverName = UserDefaults.standard.value(forKey: userdefault.serverKeys().servername) as? String {
           didSet { UserDefaults.standard.set(self.serverName ?? "", forKey: userdefault.serverKeys().servername) }
       }

        var serverAddress = UserDefaults.standard.value(forKey: userdefault.serverKeys().serverAddressArr) as? String {
               didSet { UserDefaults.standard.set(self.serverAddress ?? "", forKey: userdefault.serverKeys().serverAddressArr) }
           }

        var serverVPNFile = UserDefaults.standard.value(forKey: userdefault.serverKeys().ovpnfile) as? String {
               didSet { UserDefaults.standard.set(self.serverVPNFile ?? "", forKey: userdefault.serverKeys().ovpnfile) }
           }

        var serverUser = UserDefaults.standard.value(forKey: userdefault.serverKeys().serverUser) as? String {
               didSet { UserDefaults.standard.set(self.serverUser ?? "", forKey: userdefault.serverKeys().serverUser) }
           }

        var serverPassword = UserDefaults.standard.value(forKey: userdefault.serverKeys().serverPass) as? String {
               didSet { UserDefaults.standard.set(self.serverPassword ?? "", forKey: userdefault.serverKeys().serverPass) }
           }
    
    var serverSelectedIndex = UserDefaults.standard.value(forKey: userdefault.serverKeys().serverSelectedIndex) as? Int {
           didSet { UserDefaults.standard.set(self.serverSelectedIndex ?? "", forKey: userdefault.serverKeys().serverSelectedIndex) }
       }
    
    
        var isConnectedToVPN = UserDefaults.standard.value(forKey: userdefault().isConnectedToVPN) as? Bool {
            didSet { UserDefaults.standard.set(self.isConnectedToVPN ?? "", forKey: userdefault().isConnectedToVPN) }
        }

}
struct userdefault {
    let purchasePlan = "purchasePlan"
    let purchaseStatus = "purchaseStatus"
    let isFirstTime = "ShowBannerFirstTime"
    let isPrivacyAccepted = "isPrivacyAccepted"
    let isConnectedToVPN = "isConnectedToVPN"
    struct Prices {
        let WeekPrice = "weeklyPrice"
        let MonthPrice = "monthlyPrice"
        let YearPrice = "yearlyPrice"
        
    }
    
    struct serverKeys {
        let serverSelectedIndex = "serverSelectedIndex"
                let servername = "serverame"
                let serverAddressArr = "serverame"
                let ovpnfile = "ovpn"
                let serverUser = "serverusername"
                let serverPass = "serveruserpass"
        }
        
    
    struct PricesOfferPrice {
            let WeekOfferPrice = "weeklyOfferPrice"
            let MonthOfferPrice = "monthlyOfferPrice"
            let YearOfferPrice = "yearlyOfferPrice"
            
        }
    
    
}
