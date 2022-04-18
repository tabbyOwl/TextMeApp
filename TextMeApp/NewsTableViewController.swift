//
//  NewsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 12.04.2022.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    var news: [News] = [
        News(autor: User(name: "Том", avatar: UIImage(named: "user4")) , date: "12.04.2022", text: "Сегодня чудесная погода!", image: UIImage(named: "photo3")),
                News(autor: User(name: "Евгения Петрова", avatar: UIImage(named: "user2")) , date: "12.04.2022", text: "Мой пушок ♥️", image: UIImage(named: "i-10")),
                News(autor: User(name: "Александр Гусев", avatar: UIImage(named: "user5")) , date: "12.04.2022", text: "Выставка бездомных животных пройдет в эти выходные по адресу Красноармейская 89б ТЦ ЛИГА. Питомцы доброжелательно настроены по отношению к людям, здоровы, привиты и готовы стать домашними.", image: UIImage(named: "i-2"))]


    
    override func viewDidLoad() {
        super.viewDidLoad()

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

        cell?.userNameLabel.text = news[indexPath.row].autor.name
        cell?.dateLabel.text = news[indexPath.row].date
        cell?.newsTextLabel.text = news[indexPath.row].text
        cell?.userImageView.image = news[indexPath.row].autor.avatar
        cell?.mainImage.image = news[indexPath.row].image
      
    
        cell?.likeButton.tag = indexPath.row
        cell?.likeButton.addTarget(self, action: #selector(likeButtonAction), for: .touchUpInside)
        
        return cell ?? UITableViewCell()
    }
    
}
