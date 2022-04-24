//
//  NewsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 12.04.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news: [News] = []
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        news = allNews
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        
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
                       
        let index = IndexPath(row: sender.tag, section: 0).row
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.news[index].likesCounter += 1
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            print(self.news[index].likesCounter)
        } else {
            print(self.news[index].likesCounter)
            self.news[index].likesCounter -= 1
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
                if self.news[index].likesCounter != 0 {
                    sender.setTitle(String(self.news[index].likesCounter), for: .normal)
        } else {
            sender.setTitle("", for: .normal)
        }
    }

    
    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return news.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell
        let theNews = news[indexPath.row]
        cell?.userNameLabel.text = theNews.autor.name
        cell?.dateLabel.text = theNews.date
        cell?.newsTextLabel.text = theNews.text
        cell?.userImageView.image = UIImage(named: theNews.autor.avatar.name)
        cell?.mainImage.image = theNews.image
      
    
        cell?.likeButton.tag = indexPath.row
        cell?.likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        
        return cell ?? UITableViewCell()
    }
    
}
