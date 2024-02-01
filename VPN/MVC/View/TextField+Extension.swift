//
//  TextField+Extension.swift
//  ScreenMirroring
//
//  Created by Apple on 13/03/21.
//

import Foundation
import UIKit
class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}


@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var UnderLineColor: UIColor? {
            get {
                return UIColor(cgColor: self.UnderLineColor!.cgColor)
            }
            set {
                let bottomLine = UIView()
                bottomLine.frame = CGRect(x: 0, y: self.frame.height - 1, width:self.bounds.width, height: 1.0)
                bottomLine.backgroundColor = UIColor.white
                self.borderStyle = UITextField.BorderStyle.none
                self.clipsToBounds = true
                self.addSubview(bottomLine)
            }
        }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var PlaceHoldercolor: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var imageWidth: Double  = 30 {
            didSet {
                    updateView()
                }
    }
    
    @IBInspectable var imageHeight: Double  = 30 {
                didSet {
                        updateView()
                    }
        }
    
    func updateView() {
        if let image = leftImage {
            
            let leftImageView = UIView()
            
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 10, y: 4, width: imageWidth, height: imageHeight))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = PlaceHoldercolor
            leftImageView.addSubview(imageView)
            leftImageView.frame = CGRect(x: 0, y: 0, width: imageWidth + 20, height: imageHeight + 8)
            leftView = leftImageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: PlaceHoldercolor])
    }
    
   
}

