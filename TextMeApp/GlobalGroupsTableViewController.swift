//
//  GlobalGroupsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 30.03.2022.
//

import UIKit

class GlobalGroupsTableViewController: UITableViewController {

    var groups = [Group(name: "NewGroupOne", avatar: UIImage(named: "i-3")), Group(name: "NewGroupTwo"), Group(name: "NewGroupThree", avatar: UIImage(named: "i-7")), Group(name: "NewGroupFour")]
                        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GlobalGroupCell", for: indexPath) as? GlobalGroupsTableViewCell
        let group = groups[indexPath.row]
        cell?.avatarImageView.image = group.avatar
        cell?.label.text = group.name

        return cell ?? UITableViewCell()
    }
    
}
    
     

    
  

