//
//  UIView+Shimmer.swift
//  CovidTracker
//
//  Created by Trung Vo on 10/14/20.
//  Copyright © 2020 Trung Vo. All rights reserved.
//

import UIKit

extension UIView {
    enum Direction: Int {
        case topToBottom = 0
        case bottomToTop
        case leftToRight
        case rightToLeft
    }
    
    func startShimmeringAnimation(animationSpeed: Float = 1.4,
                                  direction: Direction = .leftToRight,
                                  repeatCount: Float = MAXFLOAT) {
        let lightColor = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 0.1).cgColor
        let blackColor = UIColor.white.cgColor
        
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
        
        gradientLayer.locations =  [0.35, 0.50, 0.65]
        self.layer.mask = gradientLayer
        
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.1, 0.2]
        animation.toValue = [0.8, 0.9, 1.0]
        animation.duration = CFTimeInterval(animationSpeed)
        animation.repeatCount = repeatCount
        CATransaction.setCompletionBlock { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.layer.mask = nil
        }
        gradientLayer.add(animation, forKey: "shimmerAnimation")
        CATransaction.commit()
    }
    
    func stopShimmeringAnimation() {
        self.layer.mask = nil
    }
}

extension UIView {
    static let spinner = UIActivityIndicatorView(style: .large)
    
    func showLoadingIndicator() {
        UIView.spinner.translatesAutoresizingMaskIntoConstraints = false
        UIView.spinner.startAnimating()
        addSubview(UIView.spinner)

        UIView.spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        UIView.spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    func hideLoadingIndicator() {
        UIView.spinner.removeFromSuperview()
    }
}
