////
////  GlobalGroupsTableViewController.swift
////  TextMeApp
////
////  Created by jane on 30.03.2022.
////

import UIKit

protocol GlobalGroupsTableViewControllerDelegate {
    
    func userUnsubscribe(group: Group)
    func userSubscribe(group: Group)
}

class GlobalGroupsTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var groups: [Group] = []
    var filteredGroups: [Group] = []
    
    var delegate: GlobalGroupsTableViewControllerDelegate?
    var myGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GroupSearchingData().loadData(searchText: "") { [weak self] (completion) in
            DispatchQueue.main.async {
                self?.groups = completion
                self?.tableView.reloadData()
            }
        }
        searchBar.delegate = self
        
    }
    
    @IBAction func subscribeButtonAction(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let group = groups[indexPath.row]
        
        if group.isSuscribe == 1 {
            self.delegate?.userUnsubscribe(group: group)
            self.tableView.reloadData()
        } else if group.isSuscribe == 0 {
            self.delegate?.userSubscribe(group: group)
            self.tableView.reloadData()
        }
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
        var group = Group(id: 0, name: "", avatar: "", isSuscribe: 1)
        group = groups[indexPath.row]
        cell?.configure(with: group)
        
        if group.isSuscribe == 1 {
            cell?.button.setTitle("Отписаться", for: .normal)
            
            group.isSuscribe = 0
        } else if group.isSuscribe == 0 {
            cell?.button.setTitle("Подписаться", for: .normal)
            group.isSuscribe = 1
        }
        
        cell?.button.tag = indexPath.row
        cell?.button.addTarget(self, action: #selector(subscribeButtonAction), for: .touchUpInside)
        
        return cell ?? UITableViewCell()
    }
}

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        GroupSearchingData().loadData(searchText: searchText) { [weak self] (completion) in
            DispatchQueue.main.async {
                self?.groups = completion
                self?.tableView.reloadData()
            }
        }
    }
}
