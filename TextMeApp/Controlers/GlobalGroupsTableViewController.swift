////
////  GlobalGroupsTableViewController.swift
////  TextMeApp
////
////  Created by jane on 30.03.2022.
////

import Foundation
import UIKit
import RealmSwift

protocol GlobalGroupsTableViewControllerDelegate {
    
    func userUnsubscribe(group: Group)
    func userSubscribe(group: Group)
}

class GlobalGroupsTableViewController: UITableViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Public properties
    
    var delegate: GlobalGroupsTableViewControllerDelegate?
    
    var myGroups: [Group] = []
    
    //MARK: - Private properties
    
    private var groups: [Group] = []
    private var filteredGroups: [Group] = []
    private let service = GroupSearchService()
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       fetchGroups(searchText: "а")
        searchBar.delegate = self
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredGroups.count == 0 {
            return groups.count
        } else {
            return filteredGroups.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as? GlobalGroupsTableViewCell
        var group: Group
        if filteredGroups.count == 0 {
            group = groups[indexPath.row]
        } else {
            group = filteredGroups[indexPath.row]
        }
        
        if myGroups.contains(where: { $0.id == group.id }) {
            
            cell?.subscribeImage.image = UIImage(systemName: "minus.circle")
            
        } else {
            cell?.subscribeImage.image = UIImage(systemName: "plus.circle")
        }
        
        cell?.configure(with: group)
        
        return cell ?? UITableViewCell()
    }
    
    
     func subscribe(_ sender: UIImageView) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let group = groups[indexPath.row]
        if myGroups.contains(where: { $0.id == group.id }) {
            self.delegate?.userUnsubscribe(group: group)
            self.tableView.reloadData()
        } else {
            self.delegate?.userSubscribe(group: group)
            self.tableView.reloadData()
        }
    }
    
    private func fetchGroups(searchText: String) {
        do {
            let realm = try Realm()
            let restoredGroups = realm.objects(GroupRealm.self)
            if restoredGroups.isEmpty {
                GroupSearchService().loadGroups(searchText: searchText) { result in
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

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        fetchGroups(searchText: searchText)
    }
}
