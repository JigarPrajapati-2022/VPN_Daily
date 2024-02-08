//
//  View+Extenstion.swift
//  myvpn
//
//  Created by RMV on 01/03/21.
//  Copyright © 2021 TechnoWaves. All rights reserved.
//

import Foundation
import UIKit
//import Alamofire
//import BBWebImage

//let partyAnimation = BBAnimatedImageView()
let noDataView = UIView()
extension UIView {

    
    @discardableResult
           func applyGradient(colours: [UIColor]) -> CAGradientLayer {
            return self.applyGradient(colours: colours, locations: nil, corner: 0)
           }

           @discardableResult
    func applyGradient(colours: [UIColor], locations: [NSNumber]?,corner:CGFloat) -> CAGradientLayer {
               let gradient: CAGradientLayer = CAGradientLayer()
               gradient.frame = self.bounds
               gradient.colors = colours.map { $0.cgColor }
               gradient.locations = locations
            gradient.cornerRadius = corner
               self.layer.insertSublayer(gradient, at: 0)
               return gradient
           }
    func removeGradientLayer() {
        if let gradientLayer = self.layer.sublayers?.first(where: { $0 is CAGradientLayer }) {
            gradientLayer.removeFromSuperlayer()
        }
    }
    // ->1
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                  direction: Direction = .leftToRight,
                                  repeatCount: Float = MAXFLOAT,
                                  lightColor: CGColor,
                                  darkColor:CGColor) {
        self.stopShimmeringAnimation()
        // Create color  ->2
        let lightColor = lightColor
        let blackColor = darkColor
        
        // Create a CAGradientLayer  ->3
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [blackColor, lightColor, blackColor]
        gradientLayer.frame = CGRect(x: -self.bounds.size.width, y: -self.bounds.size.height, width: 3 * self.bounds.size.width, height: 3 * self.bounds.size.height)
        
        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
            
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
            
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }
        
        gradientLayer.locations =  [0.35, 0.50, 0.65] //[0.4, 0.6]
        self.layer.mask = gradientLayer
        
        // Add animation over gradient Layer  ->4
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount

        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }
    
    
    
    func stopShimmeringAnimation() {
        
        self.layer.mask = nil
        self.layer.mask?.removeFromSuperlayer()
        self.layer.removeAnimation(forKey: "shimmerAnimation")
        self.layer.removeAllAnimations()
    }
    
    @IBInspectable var cornerRadius: Double {
        get {
            return self.cornerRadius
        }set {
            self.layer.cornerRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.shadowOpacity
        }
        set {
            
//            self.layer.shadowOffset = CGSize(width: 0.0, height: 20.5)
            self.layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowRadius: Float {
        get {
            return self.shadowRadius
        }
        set {
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    @IBInspectable var shadowOffsetWidth: Float {
        get {
            return self.shadowOffsetWidth
        }
        set {
            
            self.layer.shadowOffset.width = CGFloat(newValue)
            
        }
    }
    
    @IBInspectable var shadowOffsetHeight: Float {
        get {
            return self.shadowOffsetHeight
        }
        set {
            self.layer.shadowOffset.height = CGFloat(newValue)
        }
    }
    
    
}



class TwoShadowView:UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addTopDropShadow()
        addBottomDropShadow()
    }
    
    func addTopDropShadow()
        {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        topView.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 243/255, alpha: 1)
        topView.cornerRadius = 10
        topView.shadowColor  = .white
        topView.shadowOpacity = 8
        topView.shadowRadius = 5
        topView.shadowOffsetWidth = -6
        topView.shadowOffsetHeight = -6
        self.insertSubview(topView, at: 0)
        }
    func addBottomDropShadow()
        {
        let BottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        BottomView.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 243/255, alpha: 1)
        BottomView.cornerRadius = 10
        BottomView.shadowColor  = #colorLiteral(red: 0.8348616362, green: 0.847012341, blue: 0.8552559018, alpha: 1)
        BottomView.shadowOpacity = 8
        BottomView.shadowRadius = 5
        BottomView.shadowOffsetWidth = 5
        BottomView.shadowOffsetHeight = 5
//        self.addSubview(BottomView)
        self.insertSubview(BottomView, at: 0)
        }
    
}

class TwoRoundShadowView:UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addTopDropShadow()
        addBottomDropShadow()
    }
    
    func addTopDropShadow()
        {
        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        topView.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 243/255, alpha: 1)
        topView.cornerRadius = Double(self.frame.height / 2)
        topView.shadowColor  = .white
        topView.shadowOpacity = 30
        topView.shadowRadius = 5
        topView.shadowOffsetWidth = -4
        topView.shadowOffsetHeight = -4
        self.insertSubview(topView, at: 0)
        }
    func addBottomDropShadow()
        {
        let BottomView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height))
        BottomView.backgroundColor = UIColor(red: 237/255, green: 241/255, blue: 243/255, alpha: 1)
        BottomView.cornerRadius = Double(self.frame.height / 2)
        BottomView.shadowColor  = #colorLiteral(red: 0.6642268896, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
        BottomView.shadowOpacity = 15
        BottomView.shadowRadius = 4
        BottomView.shadowOffsetWidth = 5
        BottomView.shadowOffsetHeight = 5
//        self.addSubview(BottomView)
        self.insertSubview(BottomView, at: 0)
        }
    
}


//extension UIImageView {
//    public func imageFromUrl(message:String,urlString: String,cellFream:CGRect,successBlock:@escaping (_ response: Bool )->Void) {
//        let indicator = UIActivityIndicatorView()
//        indicator.backgroundColor = .black
//        indicator.alpha  = 0.5
//        if #available(iOS 13.0, *) {
//            indicator.style = .white
//        } else {
//            indicator.style = .white
//            // Fallback on earlier versions
//        }
//        indicator.tintColor = AppColors.AppColor
//        indicator.frame = cellFream
////        indicator.center = self.center
//        indicator.hidesWhenStopped = true
//        self.addSubview(indicator)
//        indicator.startAnimating()
//        let url = URL(string: urlString)!
//        self.bb_setImage(with: url,options: .progressiveDownload) { data, count, image in
//            print("count \(count)")
//        } completion: { image, Data, Error, caches in
//            indicator.stopAnimating()
//            self.image = image
//            successBlock(true)
//        }
//
//        
//    }
//}
extension UIColor {
    
        func getHexaColor(hexString: String, alpha: CGFloat = 1.0) -> UIColor {
            let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            let scanner = Scanner(string: hexString)
            if (hexString.hasPrefix("#")) {
                scanner.scanLocation = 1
            }
            var color: UInt32 = 0
            scanner.scanHexInt32(&color)
            let mask = 0x000000FF
            let r = Int(color >> 16) & mask
            let g = Int(color >> 8) & mask
            let b = Int(color) & mask
            let red   = CGFloat(r) / 255.0
            let green = CGFloat(g) / 255.0
            let blue  = CGFloat(b) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: alpha)
        }
        
    
}
