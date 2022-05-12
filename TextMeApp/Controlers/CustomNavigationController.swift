//
//  CustomNavigationController.swift
//  TextMeApp
//
//  Created by jane on 23.04.2022.
//

import Foundation
import UIKit

class CustomNavigationController: UINavigationController {
    
    var interactiveTransition: CustomInteractiveTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
    }
    
}

extension CustomNavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            interactiveTransition = CustomInteractiveTransition(popingViewController: toVC)
            return TransitionAnimator(isPresenting: true)
        case .pop:
            return TransitionAnimator(isPresenting: false)
        default:
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return (interactiveTransition?.hasStarted ?? false) ? interactiveTransition : nil
    }
    
}

class CustomInteractiveTransition: UIPercentDrivenInteractiveTransition {
    
    let popingViewController: UIViewController
    
    var hasStarted: Bool = false
    var shouldFinish: Bool = false
    
    init(popingViewController: UIViewController) {
        self.popingViewController = popingViewController
        
        super.init()
        
        let recognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(screenDidPan(_:)))
        recognizer.edges = .left
        popingViewController.view.addGestureRecognizer(recognizer)
    }
    
    @objc func screenDidPan(_ sender: UIScreenEdgePanGestureRecognizer) {
        switch sender.state {
        case .began:
            hasStarted = true
            popingViewController.navigationController?.popViewController(animated: true)
            
        case .changed:
            let transition = sender.translation(in: popingViewController.view)
            let relativeTransition = transition.x / popingViewController.view.bounds.width
            let progress = max(0, min(1, relativeTransition))
            shouldFinish = progress > 0.5
            update(progress)
            
        case .cancelled:
            hasStarted = false
            cancel()
            
        case .ended:
            hasStarted = false
            shouldFinish ? finish() : cancel()
            
        default:
            break
        }
    }
    
}
