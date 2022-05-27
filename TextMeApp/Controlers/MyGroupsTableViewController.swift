//
//  MyGroupsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//



import UIKit
import RealmSwift

class MyGroupsTableViewController: UITableViewController {
    
    
    var groups: [Group] = []
    
    let groupData = GroupData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            let restoredGroups = try groupData.restore()
            if restoredGroups.isEmpty {
                groupData.loadData { [weak self] (completion) in
                    DispatchQueue.main.async {
                        self?.groups = completion
                        self?.tableView.reloadData()
                    }
                }
            } else {
                self.groups = restoredGroups
            }
        } catch {
            print(error)
        }
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsTableCell
        let group = groups[indexPath.row]
        cell?.configure(with: group)
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "удалить", handler: {[weak self] _, _, block in
            guard let group = self?.groups[indexPath.row] else {return}
            self?.groupData.delete(group: group)
            self?.groups.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
            block(true)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let globalGroupsVC = segue.destination as? GlobalGroupsTableViewController {
            globalGroupsVC.delegate = self
        }
    }
}

extension MyGroupsTableViewController: GlobalGroupsTableViewControllerDelegate {
    
    func userSubscribe(group: Group) {
        
        groups.append(group)
        groupData.save(group: group)
        tableView.reloadData()
    }
    
    func userUnsubscribe(group: Group) {
        groups.removeAll(where: {$0.id == group.id})
        groupData.delete(group: group)
        tableView.reloadData()
    }
}
