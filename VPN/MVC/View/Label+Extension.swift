//
//  Label+Extenstion.swift
//  myvpn
//
//  Created by RMV on 01/03/21.
//  Copyright © 2021 TechnoWaves. All rights reserved.
//

import Foundation
import UIKit
extension UILabel {
    func textAttribute(firstColor:UIColor,secondColor:UIColor,firstString:String,secondText:String,firstFont:UIFont,secondFont:UIFont){
        let attrs1 = [NSAttributedString.Key.foregroundColor : firstColor,.font:firstFont]
        
        let attrs2 = [NSAttributedString.Key.foregroundColor : secondColor,.font:secondFont]
        
        let attributedString1 = NSMutableAttributedString(string:firstString, attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:secondText, attributes:attrs2)
        attributedString1.append(attributedString2)
        
        self.attributedText = attributedString1
    }
    
    
}
extension NSMutableAttributedString {
    
    func setColorForText(textForAttribute: String, withColor color: UIColor,font:UIFont) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        
        // Swift 4.2 and above
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        
        // Swift 4.1 and below
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
    
}

extension String {
    static func format(strings: [String],
                       boldFont: UIFont = UIFont.boldSystemFont(ofSize: 14),
                       boldColor: UIColor = UIColor.blue,
                       inString string: String,
                       font: UIFont = UIFont.systemFont(ofSize: 14),
                       color: UIColor = UIColor.black) -> NSAttributedString {
        
        let attributedString =
            NSMutableAttributedString(string: string,
                                      attributes: [
                                        NSAttributedString.Key.font: font,
                                        NSAttributedString.Key.foregroundColor: color])
        let boldFontAttribute = [NSAttributedString.Key.font: boldFont, NSAttributedString.Key.foregroundColor: boldColor]
        for bold in strings {
            attributedString.addAttributes(boldFontAttribute, range: (string as NSString).range(of: bold))
        }
        return attributedString
    }
}
