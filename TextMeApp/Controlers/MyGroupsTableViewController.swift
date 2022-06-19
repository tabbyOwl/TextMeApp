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

    private var token: NotificationToken?
    private var realmData = RealmData()
    
    private var groups: Results<Group>? {
        try? realmData.restore(Group.self)
    }
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNotificationToken()
        fetchGroups()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as? MyGroupsTableCell
        if let group = groups?[indexPath.row] {
        cell?.configure(with: group)
        }
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .normal, title: "удалить", handler: {[weak self] _, _, block in
            guard let group = self?.groups?[indexPath.row] else {return }
            
            self?.realmData.delete(group)
         
            block(true)
        })
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let globalGroupsVC = segue.destination as? GlobalGroupsTableViewController {
            globalGroupsVC.delegate = self
        }
    }
    
    // MARK: Private methods
    
    private func fetchGroups() {
        
                GroupService().loadGroups { result in
                    switch result {
                    case .success(let group):
                        DispatchQueue.main.async {
                                self.realmData.save(objects: group)
                                self.tableView.reloadData()
                            }
                    case .failure(_):
                        return
                    }
                }
            }
    
   private func createNotificationToken() {

        token = groups?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let groupsData):
                print("DBG token", groupsData.count)
            case .update(_,
                         deletions: let deletions,
                         insertions: let insertions,
                         modifications: let modifications):
                let deletionsIndexPath = deletions.map { IndexPath(row: $0, section: 0) }
                let insertionsIndexPath = insertions.map { IndexPath(row: $0, section: 0) }
                let modificationsIndexPath = modifications.map { IndexPath(row: $0, section: 0) }
                DispatchQueue.main.async {
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletionsIndexPath, with: .automatic)
                    self.tableView.insertRows(at: insertionsIndexPath, with: .automatic)
                    self.tableView.reloadRows(at: modificationsIndexPath, with: .automatic)
                    self.tableView.endUpdates()
                }
            case .error(let error):
                print("DBG token Error", error)
            }
        }
    }
}

extension MyGroupsTableViewController: GlobalGroupsTableViewControllerDelegate {

    func userSubscribe(group: Group) {
        group.isSuscribe = !group.isSuscribe
        realmData.save(objects: [group])
    }

    func userUnsubscribe(group: Group) {
        group.isSuscribe = !group.isSuscribe
        realmData.deleteGroup(group: group)
    }
}
