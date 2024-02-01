//
//  VPNHelper.swift
//  VPN
//
//  Created by Developer on 04/01/22.
//

import Foundation
import UIKit
var countriesData = [(name: String, flag: UIImage,countryImage:UIImage,serverAddressArr:String,serverUser:String,serverPass:String,serverName:String)]()
var selectedContryIndex = 0

let targetBundleId = "com.VPN-Daily-Vault.VPNNetworkExtention"
var serverAddress = ""
var ovpnFile = ""
var username = ""
var pass = ""
var serverImage = UIImage()
func getCountryNames() {
    
    
    countriesData.append((name: "Singapore", flag: #imageLiteral(resourceName: "3-pink"),countryImage:#imageLiteral(resourceName: "singapore"), serverAddressArr: "128.199.119.80", serverUser: "", serverPass: "", serverName: "Singapore"))
    
    countriesData.append((name: "Netherlands - Amsterdam", flag: #imageLiteral(resourceName: "3-white"),countryImage:#imageLiteral(resourceName: "netherlands"), serverAddressArr: "178.62.201.248", serverUser: "", serverPass: "", serverName: "Amsterdam"))
        
    countriesData.append((name: "US - New York", flag: #imageLiteral(resourceName: "3-pink"),countryImage:#imageLiteral(resourceName: "US"), serverAddressArr: "157.230.54.233", serverUser: "", serverPass: "", serverName: "NewYork"))
        
    
    countriesData.append((name: "India - Bangalore", flag: #imageLiteral(resourceName: "3-pink"),countryImage:#imageLiteral(resourceName: "India"), serverAddressArr: "139.59.59.90", serverUser: "", serverPass: "", serverName: "Bangalore"))
    
    
    countriesData.append((name: "California - San Francisco", flag: #imageLiteral(resourceName: "3-white"),countryImage:#imageLiteral(resourceName: "US"), serverAddressArr: "164.90.145.158", serverUser: "", serverPass: "", serverName: "San Francisco"))
    
    
    countriesData.append((name: "Germany - Frankfurt", flag: #imageLiteral(resourceName: "3-white"),countryImage:#imageLiteral(resourceName: "Germany"), serverAddressArr: "165.22.84.232", serverUser: "", serverPass: "", serverName: "Frankfurt"))
    
    
    countriesData.append((name: "Canada - Toronto", flag: #imageLiteral(resourceName: "3-white"),countryImage:#imageLiteral(resourceName: "canada"), serverAddressArr: "165.227.44.130", serverUser: "", serverPass: "", serverName: "Toronto"))
    
    
    countriesData.append((name: "UK - London", flag: #imageLiteral(resourceName: "3-white"),countryImage:#imageLiteral(resourceName: "UK"), serverAddressArr: "159.65.28.168", serverUser: "", serverPass: "", serverName: "London"))
    
    
    
    serverAddress = countriesData[selectedContryIndex].serverAddressArr
    ovpnFile = countriesData[selectedContryIndex].serverName
    username = countriesData[selectedContryIndex].serverUser
    pass = countriesData[selectedContryIndex].serverPass
    serverImage = countriesData[selectedContryIndex].countryImage
    
    UserDefaultsManager().serverName = countriesData[selectedContryIndex].name
    UserDefaultsManager().serverAddress = serverAddress
    UserDefaultsManager().serverVPNFile = ovpnFile
    UserDefaultsManager().serverUser = username
    UserDefaultsManager().serverPassword = pass
    
    
}
