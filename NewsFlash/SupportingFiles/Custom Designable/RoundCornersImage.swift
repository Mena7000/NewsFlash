//
//  CorneredImg.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import UIKit

@IBDesignable class RoundCornersImage: UIImageView {
    @IBInspectable var cornerRadius: CGFloat = 8
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.init(hex: "EB1E4E")
    
    override func didMoveToWindow() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
}
