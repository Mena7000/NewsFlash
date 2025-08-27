//
//  CardView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/27/25.
//

import UIKit

@IBDesignable class CardView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 11
    @IBInspectable var borderWidth: CGFloat = 0
    @IBInspectable var borderColor: UIColor = UIColor.init(hex: "EB1E4E")

    override func didMoveToWindow() {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        do {
            self.layer.borderColor = borderColor.cgColor
        } catch {
            self.layer.borderColor = UIColor.init(hex: "EB1E4E").cgColor
        }
    }
}

@IBDesignable class roundViewWithShadow: UIView {
    override func didMoveToWindow() {
        let cornerRadius = self.layer.frame.height / 2
        self.layer.cornerRadius = cornerRadius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = 0.2
    }
}

@IBDesignable class RoundedCornersView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 8

    override func didMoveToWindow() {
        self.layer.cornerRadius = cornerRadius
    }
}

@IBDesignable class roundedCornersbtn: UIButton {
    override func didMoveToWindow() {
        self.layer.cornerRadius = self.layer.frame.height / 2
    }
}
