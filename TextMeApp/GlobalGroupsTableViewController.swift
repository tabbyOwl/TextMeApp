//
//  GlobalGroupsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 30.03.2022.
//

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
        groups = globalGroups
        searchBar.delegate = self
        
    }
    
    @IBAction func subscribeButtonAction(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let group = groups[indexPath.row]
        
       if myGroups.contains(where: { $0.name == group.name }) {
            
            self.myGroups.removeAll(where: { $0.name == group.name })
            self.delegate?.userUnsubscribe(group: group)
            self.tableView.reloadData()
        } else {
            self.myGroups.append(group)
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
        var group = Group(name: "")
        if filteredGroups.count == 0 {
            group = groups[indexPath.row]
        } else {
            group = filteredGroups[indexPath.row]
        }
        cell?.avatarImageView.image = UIImage(named: group.avatar.name)
        cell?.label.text = group.name
        
        if myGroups.contains(where: { $0.name == group.name }) {
            
            cell?.button.setTitle("Отписаться", for: .normal)
            group.isSuscribe = true
        } else {
            cell?.button.setTitle("Подписаться", for: .normal)
        }
        
        cell?.button.tag = indexPath.row
        cell?.button.addTarget(self, action: #selector(subscribeButtonAction), for: .touchUpInside)
      
        return cell ?? UITableViewCell()
    }
}

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     
        let networkManager = NetworkManager()
        networkManager.loadData(methodParameters: "groups.search",
                                queryItems: [URLQueryItem(name: "q", value: searchText),
                                             URLQueryItem(name: "type", value: "group")])
        
        if !searchText.isEmpty {
            filteredGroups = groups.filter({$0.name.lowercased().contains(searchText.lowercased())})
        tableView.reloadData()
    }
        else {
            filteredGroups.removeAll()
            tableView.reloadData()
        }
    }
}











