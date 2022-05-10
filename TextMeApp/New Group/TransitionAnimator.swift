//
//  TransitionAnimator.swift
//  TextMeApp
//
//  Created by jane on 23.04.2022.
//

import Foundation

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    let animationDuration: TimeInterval = 2
    var isPresenting: Bool = false

    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            animateForPresent(using: transitionContext)
        } else {
            animateForDismiss(using: transitionContext)
        }
    }

    func animateForDismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }

        let containerView = transitionContext.containerView

        containerView.addSubview(destination.view)
        
        destination.view.frame = CGRect(x: 0,
                                        y: 0,
                                        width: source.view.frame.height,
                                        height: source.view.frame.width)
        
        source.view.setAnchorPoint(CGPoint(x: 1, y: 0))
        
        UIKit.UIView.animateKeyframes(
            withDuration: animationDuration,
            delay: 0,
            options: [],
            animations: {

                UIKit.UIView.addKeyframe(
                    withRelativeStartTime: 0,
                    relativeDuration: 0.5,
                    animations: {
                        source.view.transform = source.view.transform.rotated(by: -.pi/2)
                    })

                UIKit.UIView.addKeyframe(
                    withRelativeStartTime: 0.20,
                    relativeDuration: 0.5,
                    animations: {
                        destination.view.transform = .identity
                    })

            },
            completion: { isComplete in
                if isComplete {
                    source.removeFromParent()
                }
                transitionContext.completeTransition(isComplete && !transitionContext.transitionWasCancelled)
            })
    }
    
    func animateForPresent(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let source = transitionContext.viewController(forKey: .from),
            let destination = transitionContext.viewController(forKey: .to)
        else {
            return
        }

        let containerView = transitionContext.containerView

        containerView.addSubview(destination.view)
       
        destination.view.frame = CGRect(x: containerView.frame.width,
                                        y: 0,
                                        width: source.view.frame.width,
                                        height: source.view.frame.height)
        
        source.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        source.view.layer.position = CGPoint(x: 0, y: 0)
        
        destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
        destination.view.transform = CGAffineTransform(rotationAngle: -.pi/2)
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [], animations: {
            
            destination.view.transform = .identity
            destination.view.layer.position = CGPoint(x: 0, y: 0)
            
            source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
            
        }, completion: { isComplete in
            transitionContext.completeTransition(isComplete)
        
        })
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);

        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)

        var position = layer.position

        position.x -= oldPoint.x
        position.x += newPoint.x

        position.y -= oldPoint.y
        position.y += newPoint.y

        layer.position = position
        layer.anchorPoint = point
    }
}
