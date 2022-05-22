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
        tableView.delegate = self
        
        NewsData().loadData() { [weak self] (completion) in
            DispatchQueue.main.async {
            self?.news = completion
            self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
// 
//        guard let currentDataType = news[indexPath.row].newsType else {return 0.0}
//        
//        switch currentDataType {
//        case .imageOnly: return 200
//        case .textOnly: return 100
//        case .imageAndText: return 400
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let curentNews = news[indexPath.row]
        
        guard
            let cellIdentifier = curentNews.newsType?.rawValue,
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) else {
            return UITableViewCell()
        }
        
        
        (cell as? NewsCellProtocol)?.set(value: curentNews)
        
        return cell
    }
    
}
