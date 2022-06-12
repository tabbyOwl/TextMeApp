//
//  GlobalGroupsTableViewCell.swift
//  TextMeApp
//
//  Created by jane on 30.03.2022.
//

import UIKit

class GlobalGroupsTableViewCell: UITableViewCell {
    
    //MARK: - @IBOutlets

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
  
    @IBOutlet weak var subscribeImage: UIImageView!
    
    func configure(with model: Group) {
        label.text = model.name
        if let url = URL(string: model.avatar) {
            avatarImageView.load(url: url)
        }
    }
    
    //MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadowView.layer.backgroundColor = UIColor.clear.cgColor
        avatarImageView.layer.cornerRadius = 25
        avatarImageView.layer.masksToBounds = true
        
        let subscribeTap = UITapGestureRecognizer(target: self, action: #selector (subscribe(recognizer: )))
        subscribeImage.isUserInteractionEnabled = true
        subscribeImage.addGestureRecognizer(subscribeTap)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector( animateTapImage(recognizer: )))
        avatarImageView.isUserInteractionEnabled = true
        avatarImageView.addGestureRecognizer(tap)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Private methods

    @objc private func subscribe (recognizer: UITapGestureRecognizer) {
       let vc = self.parentViewController as? GlobalGroupsTableViewController
        vc?.subscribe(subscribeImage)
    }
    
    @objc private func animateTapImage (recognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
            self.avatarImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) },
                       completion: {_ in
            UIView.animate(withDuration: 0.5) {
            self.avatarImageView.transform = CGAffineTransform.identity }
        })
    }
    
  

}

extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
