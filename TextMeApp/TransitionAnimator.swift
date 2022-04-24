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
                
        UIView.animate(withDuration: 4, delay: 0, options: [], animations: {
            
            destination.view.transform = .identity
          
            source.view.transform = source.view.transform.rotated(by: -.pi/2)
           
        }, completion: { isComplete in
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
        
        UIView.animate(withDuration: 1, delay: 0, options: [], animations: {
            
            destination.view.transform = .identity
            destination.view.layer.position = CGPoint(x: 0, y: 0)
            
            source.view.transform = CGAffineTransform(rotationAngle: .pi/2)
            
        }, completion: { isComplete in
            transitionContext.completeTransition(isComplete)
        
        })
    }
}
