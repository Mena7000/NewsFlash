//
//  ShadowView.swift
//  NewsFlash
//
//  Created by Mena Maher on 8/26/25.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            layer.shadowColor = shadowColor.cgColor
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.4 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 4) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat = 4 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
    
    private func setupShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
        updateShadowPath()
    }
    
    private func updateShadowPath() {
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
}
