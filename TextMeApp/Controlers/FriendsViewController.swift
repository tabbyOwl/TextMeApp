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
    private var service = UserService()
    private var usersSortedByCharacter: [Character:[User]] {
        var dict = [Character:[User]]()
        
        for user in users {
            guard let character = user.firstName.first else {return [:]}
            if dict.keys.contains(character) {
                dict[character]?.append(user)
                dict[character] = dict[character]?.sorted{ ($0.firstName + $0.lastName) < ($1.firstName + $1.lastName) }
            } else {
                dict[character] = [user]
            }
        }
        return dict
    }
    
    private var usersNameCharacters: [Character] {
     
        return Array(usersSortedByCharacter.keys).sorted{ $0 > $1 }
       
    }
    
    private var filteredBySearchUsers: [User] = []
    private let transitionAnimator = TransitionAnimator(isPresenting: false)
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        self.fetchFriends()
        print(self.users.count)
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
                photosVC.userId = user.id
            }
        }
    
    
    func fetchFriends() {
        UserService().loadFriends { result in
            switch result {
            case .success(let user):
                print(result)
                DispatchQueue.main.async {
                    self.users = user
                    self.tableView.reloadData()
                }

            case .failure(_):
                return
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
