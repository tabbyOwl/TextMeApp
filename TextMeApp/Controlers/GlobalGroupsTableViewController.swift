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
    
    var myGroups: [Group] {
       
        guard let groups: [Group] = try? RealmData().restore() else {return []}
        return groups
        
    }
    
    //MARK: - Private properties
    private var groups: [Group] = []
    private var filteredGroups: [Group] = []
    
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        GroupSearchApi().loadData(searchText: "а") { [weak self] (completion) in
            DispatchQueue.main.async {
            self?.groups = completion
            self?.tableView.reloadData()
            }
        }
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
    
}

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        GroupSearchApi().loadData(searchText: searchText) { [weak self] (complition) in
            DispatchQueue.main.async {
            self?.groups = complition
            self?.tableView.reloadData()
            }
        }
    }
}
