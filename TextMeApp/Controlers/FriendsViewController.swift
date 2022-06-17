//
//  MyFriendsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit
import RealmSwift

class FriendsViewController: UITableViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Private properties
    private var token: NotificationToken?
    private var filteredBySearchUsers: [User] = []
    private let transitionAnimator = TransitionAnimator(isPresenting: false)
    
    private var users : Results<User>? {
        try? RealmData().restore(User.self)
    }
    
    private var usersSortedByCharacter: [Character:[User]] {
        var dict = [Character:[User]]()
        if let users = users {
        for user in users {
            guard let character = user.firstName.first else {return [:]}
            if dict.keys.contains(character) {
                dict[character]?.append(user)
                dict[character] = dict[character]?.sorted{ ($0.firstName + $0.lastName) < ($1.firstName + $1.lastName) }
            } else {
                dict[character] = [user]
            }
        }
        }
        return dict
    }
    
    private var usersNameCharacters: [Character] {
     
        return Array(usersSortedByCharacter.keys).sorted{ $0 > $1 }
    }
    
   
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        createNotificationToken()
        self.fetchFriends()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if filteredBySearchUsers.count == 0 {
            let character = usersNameCharacters[section]
            guard let users = usersSortedByCharacter[character] else { return 0 }
            return users.count
        } else {
            return filteredBySearchUsers.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if filteredBySearchUsers.count == 0  {
            return usersNameCharacters.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if filteredBySearchUsers.count == 0  {
            return String(usersNameCharacters[section])
        } else {
            return ""
        }
    }
        
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsTableCell
  
        if filteredBySearchUsers.count == 0  {
            let character = usersNameCharacters[indexPath.section]
            if let users = usersSortedByCharacter[character] {
                
                cell?.configure(with: users[indexPath.row])
            }
        } else {
            cell?.configure(with: filteredBySearchUsers[indexPath.row])
        }
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let cell = sender as? MyFriendsTableCell,
            let indexPath = tableView.indexPath(for: cell),
            let photosVC = segue.destination as? PhotosCollectionViewController
        else {
            return
        }

        if filteredBySearchUsers.count == 0  {
            let character = usersNameCharacters[indexPath.section]
            if let users = usersSortedByCharacter[character] {
                let user = users[indexPath.row]
                photosVC.user = user
            }
        } else {
            let user = filteredBySearchUsers[indexPath.row]
                photosVC.user = user
            }
        }
    
    
    private func fetchFriends() {
        
        if let users = users {
            print("🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀🦀")
            print(users.count)
            if users.isEmpty {
                UserService().loadFriends { result in
                    switch result {
                    case .success(let user):
                        DispatchQueue.main.async {
                            RealmData().save(objects: user)
                            self.tableView.reloadData()
                        }
                case .failure(_):
                    return
                }
            }
        }
    }
}
    
    func createNotificationToken() {
        token = users?.observe { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .initial(let usersData):
                print("DBG token", usersData.count)
            case .update(let users,
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
                print("token Error", error)
            }
        }
    }
}


        
extension FriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if !searchText.isEmpty {
            if let users = users {
            filteredBySearchUsers = users.filter({$0.firstName.lowercased().contains(searchText.lowercased())})
            tableView.reloadData()
        }
        else {
            filteredBySearchUsers.removeAll()
            tableView.reloadData()
        }
    }
}
}
