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
        cell?.mainImage.image = UIImage(named: theNews.image.name)
        cell?.likeControl.isSelected = theNews.image.isLiked
        cell?.photoDidLiked = { isSelected in
            allNews[indexPath.row].image.isLiked = isSelected
        }
       
        return cell ?? UITableViewCell()
    }
    
}
