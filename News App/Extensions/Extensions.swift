//
//  Extensions.swift
//  News App
//
//  This file contains extensions
//  for various UI Kit elements
//  like UI View,UI Colour etc.The
//  aim is to add additional functionallity
//  to these elements.
//
//  Created by Naveen Gaur on 22/12/18.
//  Copyright © 2018 Naveen Gaur. All rights reserved.
//

import Foundation
import UIKit

private let imageCache = NSCache<NSURL, UIImage>()

// MARK: - Extension Methods for UIView.
extension UIView {
    
    /// Allows us to add shadow effect on the UI View.
    func addShadowEffect(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
    }
    
    /// To Set Auto Layout Constraints on the View.
    func anchor(top: NSLayoutYAxisAnchor,leading: NSLayoutXAxisAnchor,bottom: NSLayoutYAxisAnchor,trailing: NSLayoutXAxisAnchor,padding: UIEdgeInsets = .zero)
    {
        // Activate Auto Layout.
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
    }
    
    /// Increases the border width and changes the UIView color
    /// to indicate that something has been selected.
    func highlightBorder()  {
        layer.borderWidth = 2.0
        layer.borderColor = UIColor().borderColor().cgColor
        
    }
    
    /// Adds a shadow effect to the view.
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 5
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = false
    }
    
}

// MARK: - Extension Methods for UIColor.
extension UIColor {
    
    /// To get Custom Colors or To convert hex code into rgba.
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
    
    /// Returns a custom border color configured for this project.
    func borderColor() -> UIColor {
        return UIColor.init(netHex: 0xFF2D55)
    }
}

extension UIImageView {
    func load(url: URL) {
        // initally set the image to nil.
        self.image = nil
        
        // check if the image is already in the cache.
        if let imageToCache = imageCache.object(forKey: url as NSURL) {
            self.image = imageToCache
            return
        }
        // Download the image asynchronously if the image is not present in the cache.
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        // cache the image
                        let imageToCache = image
                        imageCache.setObject(imageToCache, forKey: url as NSURL)
                        self?.image = image
                    }
                }
            }
        }
    }
  
}
