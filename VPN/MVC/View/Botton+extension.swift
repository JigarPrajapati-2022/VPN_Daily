//
//  Botton+extension.swift
//  ScreenMirroring
//
//  Created by Apple on 13/03/21.
//

import Foundation
import UIKit
extension UIButton {
    
    @IBInspectable var UnderLineColor: UIColor? {
        get {
            return UIColor(cgColor: self.UnderLineColor!.cgColor)
        }
        set {
            let yourAttributes = [NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue,NSAttributedString.Key.underlineColor : newValue ?? .black] as [NSAttributedString.Key : Any]
            
            let attributeString = NSMutableAttributedString(string: self.titleLabel?.text ?? "",
                                                                   attributes: yourAttributes)
            self.setAttributedTitle(attributeString, for: .normal)
        }
    }
    
}
