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
    
    //MARK: - Private properties
    
    private var groups: [Group] = []
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as? GlobalGroupsTableViewCell
        
        let group = groups[indexPath.row]
        if group.isSuscribe {
            cell?.subscribeImage.image = UIImage(systemName: "minus.circle")
        } else {
            cell?.subscribeImage.image = UIImage(systemName: "plus.circle")
        }
        
        cell?.configure(with: group)
        
        return cell ?? UITableViewCell()
    }
    
    //MARK: - Public methods
    func subscribe(_ sender: UIImageView) {
        
        guard let indexPath = tableView.indexPathForView(sender) else {return}
        let group = groups[indexPath.row]
        
        if group.isSuscribe {
            self.delegate?.userUnsubscribe(group: group)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        } else {
            self.delegate?.userSubscribe(group: group)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    //MARK: - Private methods
    
    private func fetchGroups(searchText: String) {
        
        GroupSearchService().loadGroups(searchText: searchText) { result in
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

    // MARK: -Extensions

extension GlobalGroupsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        fetchGroups(searchText: searchText)
    }
}
