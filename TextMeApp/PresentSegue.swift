//
//  PresentSegue.swift
//  TextMeApp
//
//  Created by jane on 23.04.2022.
//

//import Foundation
//import UIKit
//
//class PresentSegue: UIStoryboardSegue {
//
//    override func perform() {
//        guard let containerView = source.view.superview else {
//            return
//        }
//        
//     
//        containerView.addSubview(destination.view)
//        
//       
//        destination.view.frame = CGRect(x: source.view.frame.width,
//                                        y: 0,
//                                        width: source.view.frame.width,
//                                        height: source.view.frame.height)
//
//        self.destination.view.layer.anchorPoint = CGPoint(x: 0, y: 0)
//        destination.view.transform = CGAffineTransform(rotationAngle: .pi/2)
//        
//        UIView.animate(withDuration: 3,
//                       delay: 0,
//                       options: [],
//                       animations: {
//            
//            self.destination.view.transform = .identity
//            
//        },
//                       completion: { isComplete in
//            
//            self.source.present(self.destination, animated: false)})
//
//    }
//}
