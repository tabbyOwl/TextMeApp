//
//  OneImageViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
  
    @IBOutlet weak var likeButton: UIButton!
    var animator: UIViewPropertyAnimator?
    
    var userIndex: Int = 0
    var indexOfCurrentImage: Int = 0
    var nextPhotoView: UIImageView?
    
    var photos: [Photo] {
        return allUsers[userIndex].photos
    }

    var isLiked: Bool {
        set {
            allUsers[userIndex].photos[indexOfCurrentImage].isLiked = newValue
        }
        get {
            allUsers[userIndex].photos[indexOfCurrentImage].isLiked
        }
    }
    
    var likesCounter: Int {
        set {
            allUsers[userIndex].photos[indexOfCurrentImage].likesCounter = newValue
        }
        get {
            allUsers[userIndex].photos[indexOfCurrentImage].likesCounter
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.photoImageView.image = UIImage(named: photos[indexOfCurrentImage].name)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        self.view.addGestureRecognizer(panGesture)
        
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.layer.opacity = 0.5
        navigationController?.navigationBar.barTintColor = .white
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.animator?.stopAnimation(true)
            if let animator = animator, animator.state != .inactive {
                animator.finishAnimation(at: .current)
            }
    }

    @IBAction func likeButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.2,
                       options: [.curveEaseIn],
                       animations: {
            sender.transform = CGAffineTransform(scaleX: 1.6, y: 1.6) },
                       completion: {_ in
            UIView.animate(withDuration: 0.5) {
            sender.transform = CGAffineTransform.identity
            }
        })
        
        isLiked = !isLiked

        if isLiked {
            likesCounter += 1
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likesCounter -= 1
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }

        if likesCounter != 0 {
            sender.setTitle(String(likesCounter), for: .normal)
        } else {
            sender.setTitle("", for: .normal)
        }
    
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
                    self.indexOfCurrentImage += 1
                } else if sender.velocity(in: self.photoImageView).x > 0 && indexOfCurrentImage != 0 {
                    self.indexOfCurrentImage -= 1
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
                
                self.photoImageView.image = UIImage(named: photos[indexOfCurrentImage].name)
                view.superview?.reloadInputViews()
                view.reloadInputViews()
                } else {
                animator?.isReversed = true
                    animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1)
            }
        @unknown default:
            break
        }
    }
}
