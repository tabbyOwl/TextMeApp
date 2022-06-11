//
//  MyFriendsCell.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit

class MyFriendsTableCell: UITableViewCell {

    //MARK: - @IBOutlets
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImageView: UIImageView!
    
    //MARK: - Override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
     
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowOffset = CGSize(width: 10, height: 10)
        shadowView.layer.backgroundColor = UIColor.clear.cgColor
        friendImageView.layer.cornerRadius = 25
        friendImageView.layer.masksToBounds = true
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector( animateTapImage(recognizer: )))
        friendImageView.isUserInteractionEnabled = true
        friendImageView.addGestureRecognizer(tap)
     
}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //MARK: - Public methods
    
    func configure(with model: User) {
        friendName.text = "\(model.firstName) \(model.lastName)"
        if let url = URL(string: model.avatar) {
        friendImageView.load(url: url)
    }
}
    //MARK: - Private methods
    @objc private func animateTapImage (recognizer: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.1,
                       delay: 0,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 0.3,
                       options: [],
                       animations: {
            self.friendImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8) },
                       completion: {_ in
            UIView.animate(withDuration: 0.5) {
            self.friendImageView.transform = CGAffineTransform.identity }
        })
    }
}
