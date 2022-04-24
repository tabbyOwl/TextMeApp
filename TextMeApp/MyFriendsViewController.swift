//
//  MyFriendsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit

struct SectionUsers {
    
    let character: Character
    var users: [User]
}

class MyFriendsViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var users : [User] = []
    var sectionUsers: [SectionUsers] {
        var result = [SectionUsers]()
        
        for user in users {
            guard let character = user.name.first else {
                continue
            }
            if let groupedIndex = result.firstIndex(where: {$0.character == character }) {
                result[groupedIndex].users.append(user)
            } else {
                    let friend = SectionUsers(character: character, users: [user])
                    result.append(friend)
                }
            }
        return result
    }
    
    var filteredUsers:[User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        users = allUsers
        searchBar.delegate = self
    }
    
    let transitionAnimator = TransitionAnimator(isPresenting: false)
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.count == 0 {
         return sectionUsers[section].users.count
        } else {
            return filteredUsers.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if filteredUsers.count == 0 {
            return sectionUsers.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if filteredUsers.count == 0 {
        return String(sectionUsers[section].character)
        } else {
            return ""
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsTableCell
        var user = User(name: "", avatar: Photo(name: "default"))
        if filteredUsers.count == 0 {
            let sectionUser = sectionUsers[indexPath.section]
            user = sectionUser.users[indexPath.row]
        } else {
            user = filteredUsers[indexPath.row]
        }
        cell?.friendName.text = user.name
        cell?.friendImageView.image = UIImage(named: user.avatar.name)
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
//        let PhotosCollectionVC = segue.destination as UIViewController
//        PhotosCollectionVC.transitioningDelegate = transitionAnimator

       guard
            let cell = sender as? MyFriendsTableCell,
            let indexPath = tableView.indexPath(for: cell),
            let photosVC = segue.destination as? PhotosCollectionViewController
        else {
            return
        }
        if filteredUsers.count == 0 {
            let sectionUser = sectionUsers[indexPath.section]
            let user = sectionUser.users[indexPath.row]
            if let userIndex = allUsers.firstIndex(where: { $0.id == user.id }) {
                photosVC.userIndex = userIndex
            }
        } else {
            let user = filteredUsers[indexPath.row]
            if let userIndex = allUsers.firstIndex(where: { $0.id == user.id }) {
                photosVC.userIndex = userIndex
        }
    }
}
}


extension MyFriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
     
        if !searchText.isEmpty {
            filteredUsers = users.filter({$0.name.lowercased().contains(searchText.lowercased())})
        tableView.reloadData()
    }
        else {
            filteredUsers.removeAll()
            tableView.reloadData()
        }
    }
}



