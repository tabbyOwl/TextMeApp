////
////  GlobalGroupsTableViewController.swift
////  TextMeApp
////
////  Created by jane on 30.03.2022.
////

import Foundation
import UIKit
//import RealmSwift

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
        var group = Group(id: 0, name: "", avatar: "", isSuscribe: 0)
        if filteredGroups.count == 0 {
            group = groups[indexPath.row]
        } else {
            group = filteredGroups[indexPath.row]
        }
        cell?.configure(with: group)
        
        if myGroups.contains(where: { $0.id == group.id }) {
            
            cell?.button.setTitle("Отписаться", for: .normal)
            group.isSuscribe = 1
            
        } else {
            cell?.button.setTitle("Подписаться", for: .normal)
        }
        
        cell?.button.tag = indexPath.row
        cell?.button.addTarget(self, action: #selector(subscribeButtonAction), for: .touchUpInside)
        
        return cell ?? UITableViewCell()
    }
    
    //MARK: - IBActions
    
    @IBAction func subscribeButtonAction(_ sender: UIButton) {
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
    
    func fetchGroups(searchText: String) {
        service.loadGroups(searchText: searchText) { result in
            switch result {
            case .success(let group):
                DispatchQueue.main.async {
                    self.groups = group
                    self.tableView.reloadData()
                }

            case .failure(_):
                return
            }
        }
    }
}

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
       fetchGroups(searchText: searchText)
}
}
