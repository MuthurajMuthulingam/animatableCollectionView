//
//  Layer+Animations.swift
//  AnimatableCollectionView
//
//  Created by Muthuraj Muthulingam on 06/12/17.
//  Copyright © 2017 Muthuraj. All rights reserved.
//

import UIKit

extension CALayer {
    /// Add Circle Path Animation
    func addCirclePathAnimation(shouldAdd:Bool,originFrame:CGRect,destinationFrame:CGRect,animationDuration:Double,completion:((_ status:Bool) ->(Void))?) {
        
        let circleMaskPathInitial = UIBezierPath(ovalIn: originFrame)
        let extremePoint = CGPoint(x: (originFrame.maxX*0.5), y: (originFrame.maxY*0.5) - destinationFrame.maxY)
        let radius = sqrt((extremePoint.x*extremePoint.x) + (extremePoint.y*extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: (destinationFrame).insetBy(dx: -radius, dy: -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path =  shouldAdd  ? circleMaskPathFinal.cgPath: circleMaskPathInitial.cgPath
        self.mask = maskLayer
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            // Handle Animation completion
            if let completionBlock = completion {
                completionBlock(true)
            }
        }
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue =  shouldAdd ? circleMaskPathInitial.cgPath:circleMaskPathFinal.cgPath
        maskLayerAnimation.toValue = shouldAdd ? circleMaskPathFinal.cgPath:circleMaskPathInitial.cgPath
        maskLayerAnimation.duration = animationDuration
        maskLayer.add(maskLayerAnimation, forKey: "path")
        CATransaction.commit()
    }
}
