//
//  MyGroupsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 29.03.2022.
//



import UIKit
import RealmSwift

class MyGroupsTableViewController: UITableViewController {
    
    //MARK: - Private properties
    
    private var groups: [Group] = []
    private let service = GroupService()
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchGroups()
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
            self?.groups.remove(at: indexPath.row)
           
            block(true)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let globalGroupsVC = segue.destination as? GlobalGroupsTableViewController {
            globalGroupsVC.delegate = self
            globalGroupsVC.myGroups = groups
        }
    }
    
    // MARK: Private methods
    private func fetchGroups() {
        do {
            let realm = try Realm()
            let restoredGroups = realm.objects(GroupRealm.self)
            if restoredGroups.isEmpty {
                GroupService().loadGroups { result in
                    switch result {
                    case .success(let group):
                        DispatchQueue.main.async {
                            RealmData().save(objects: group)
                        }
                    case .failure(_):
                        return
                    }
                }
                self.groups = try RealmData().restore()
              
            } else {
                self.groups = try RealmData().restore()
                self.tableView.reloadData()
            }
            
        } catch {
            print(error)
        }
    }
}




extension MyGroupsTableViewController: GlobalGroupsTableViewControllerDelegate {
    
    func userSubscribe(group: Group) {
        groups.append(group)
        tableView.reloadData()
    }
    
    func userUnsubscribe(group: Group) {
        groups.removeAll(where: {$0.id == group.id})
        tableView.reloadData()
    }
}
