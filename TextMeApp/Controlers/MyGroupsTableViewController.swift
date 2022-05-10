//
//  MyGroupsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//



import UIKit

class MyGroupsTableViewController: UITableViewController {
    
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GroupData().loadData() { [weak self] (complition) in
            DispatchQueue.main.async {
            self?.groups = complition
            self?.tableView.reloadData()
            }
        }
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsTableCell
        let group = groups[indexPath.row]
        cell?.label.text = group.name
        if let url = URL(string: group.avatar.url) {
            cell?.avatarImageView.load(url: url)
        }
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let globalGroupsVC = segue.destination as? GlobalGroupsTableViewController {
            globalGroupsVC.myGroups = self.groups
            globalGroupsVC.delegate = self
        }
    }
}
    
    extension MyGroupsTableViewController: GlobalGroupsTableViewControllerDelegate {
        
        func userSubscribe(group: Group) {
            groups.append(group)
            tableView.reloadData()
        }
        
        func userUnsubscribe(group: Group) {
            groups.removeAll(where: {$0.name == group.name})
            tableView.reloadData()
        }
    }
        

