//
//  MyGroupsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//

import UIKit

class MyGroupsTableViewController: UITableViewController {
    
    var groups = [Group(name: "GroupOne"), Group(name: "GroupTwo"), Group(name: "GroupThree", avatar: UIImage(named: "i-7")), Group(name: "GroupFour")]
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }
    
    var newGroup = Group(name: "New Group", avatar: UIImage(named: "i-2"))
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsTableCell
        let group = groups[indexPath.row]
        cell?.label.text = group.name
        cell?.avatarImageView.image = group.avatar
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "удалить", handler: {[weak self] _, _, block in
            self?.groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            block(true)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
        
}