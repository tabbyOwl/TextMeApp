//
//  OneImageViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class PhotoViewController: UIViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var likeControl: LikeControl!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    //MARK: - Public properties
    
    var userIndex: Int = 0
    var photos: [Photo] = []
    var indexOfCurrentImage: Int = 0
    
    //MARK: - Private properties
    
    private var animator: UIViewPropertyAnimator?
    private var nextPhotoView: UIImageView?
    
    private var currentPhoto: Photo {
        photos[indexOfCurrentImage]
    }
    
    private var isLiked: Bool {
        if currentPhoto.likes.user_likes == 0 {
            return false
        } else {
            return true
        }
    }
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        likeControl.likeLabel = self.likeLabel
        likeControl.imageView = self.likeImage
        
        // likeControl.addTarget(self, action: #selector(likeControlTapped), for: .touchUpInside)
        
        self.likeControl.isSelected = self.isLiked
        
        if let url = URL(string: currentPhoto.urls.last?.url ?? "") {
            photoImageView.load(url: url)
        }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        self.view.addGestureRecognizer(panGesture)
        
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.layer.opacity = 0.5
        navigationController?.navigationBar.barTintColor = .white
        
    }
    
    //    @objc func likeControlTapped() {
    //        likeControl.isSelected = !likeControl.isSelected
    //        allUsers[userIndex].photos[self.indexOfCurrentImage].isLiked = self.likeControl.isSelected
    //    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.animator?.stopAnimation(true)
        if let animator = animator, animator.state != .inactive {
            animator.finishAnimation(at: .current)
        }
    }
    
    //MARK: - Private methods
    
    @objc private func viewPanned (_ sender: UIPanGestureRecognizer) {
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
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: { [self] in
                    self.photoImageView.alpha = 1
                    self.photoImageView.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self.photoImageView.transform = CGAffineTransform.identity
                    
                    // self.likeControl.isSelected = photos[self.indexOfCurrentImage].isLiked
                },
                               completion: nil)
                DispatchQueue.main.async { [self] in
                    if let url = URL(string: currentPhoto.urls.last?.url ?? "") {
                        photoImageView.load(url: url)
                    }
                }
            } else {
                animator?.isReversed = true
                animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1)
            }
        @unknown default:
            break
        }
    }
}
