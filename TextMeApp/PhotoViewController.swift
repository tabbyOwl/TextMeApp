//
//  OneImageViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var likeControl: LikeControl!
  
    var animator: UIViewPropertyAnimator?
    
    var photos: [UIImage?] = []
    
    var indexOfCurrentImage: Int?
    
    var nextPhotoView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        self.photoImageView.image = photos[indexOfCurrentImage ?? 0]
        likeControl.addTarget(self, action: #selector(likeControlTapped), for: .touchUpInside)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        self.view.addGestureRecognizer(panGesture)
    }

    @objc func likeControlTapped() {
        likeControl.isSelected = !likeControl.isSelected
    }

    @objc func viewPanned (_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            animator?.stopAnimation(true)
            animator?.finishAnimation(at: .current)
            animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations: {
                if sender.velocity(in: self.photoImageView).x < 0 {
                self.photoImageView.transform = CGAffineTransform(translationX: -self.view.frame.width, y: 0)
                } else {
                    self.photoImageView.transform = CGAffineTransform(translationX: self.view.frame.width, y: 0)
                }
            })
            animator?.pauseAnimation()
            
        case .changed:
            let translationX = sender.translation(in: view).x
            let updateFractionComplete = abs(translationX) / 100
            animator?.fractionComplete = updateFractionComplete
            
        case .ended:
            if animator?.fractionComplete ?? 0 > 0.7 {
                if sender.velocity(in: self.photoImageView).x < 0 && indexOfCurrentImage != photos.count - 1 {
                    self.indexOfCurrentImage! += 1
                } else if sender.velocity(in: self.photoImageView).x > 0 && indexOfCurrentImage != 0{
                    self.indexOfCurrentImage! -= 1
                } else {
                    self.photoImageView.transform = CGAffineTransform.identity
                    return
                }
                animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1)
                self.photoImageView.transform = CGAffineTransform.identity
                self.photoImageView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                self.photoImageView.alpha = 0
                    UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                        self.photoImageView.alpha = 1
                        self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self.photoImageView.transform = CGAffineTransform.identity
                    }, completion: nil)
              viewDidLoad()
                } else {
                animator?.isReversed = true
                    animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1)
            }
        @unknown default:
            break
        }
    }
}
