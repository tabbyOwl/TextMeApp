//
//  MyFriendsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit

class FriendsViewController: UITableViewController {
    
    //MARK: - @IBOutlets
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Private properties
    
    private var users : [User] = []
    
    private var usersSortedByCharacter: [Character:[User]] {
        var dict = [Character:[User]]()
        
        for user in users {
            guard let character = user.firstName.first else {return [:]}
            if dict.keys.contains(character) {
                dict[character]?.append(user)
            } else {
                dict[character] = [user]
            }
        }
        return dict
    }
    
    private var usersNameCharacters: [Character] {
        return [Character](usersSortedByCharacter.keys).sorted{ $0 < $1 }
    }
    
    private var filteredBySearchUsers: [User] = []
    
    private let transitionAnimator = TransitionAnimator(isPresenting: false)
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        do {
            let restoredUsers: [User] = try RealmData().restore()
            if restoredUsers.isEmpty {
                UserApi().loadData { [weak self] (completion) in
                    DispatchQueue.main.async {
                        self?.users = completion
                        self?.tableView.reloadData()
                        
                    }
                }
            } else {
                self.users = restoredUsers
            }
        } catch {
            print(error)
        }
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
                photosVC.userId = user.id
            }
        } else {
            let user = filteredBySearchUsers[indexPath.row]
            if let userIndex = users.firstIndex(where: { $0.id == user.id }) {
                photosVC.userId = users[userIndex].id
            }
        }
    }
}
        
extension FriendsViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if !searchText.isEmpty {
            filteredBySearchUsers = users.filter({$0.firstName.lowercased().contains(searchText.lowercased())})
            tableView.reloadData()
        }
        else {
            filteredBySearchUsers.removeAll()
            tableView.reloadData()
        }
    }
}
