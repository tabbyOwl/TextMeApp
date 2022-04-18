//
//  MyFriendsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit

struct GroupedFriends {
    
    let character: Character
    var users: [User]
}

class MyFriendsViewController: UITableViewController {
    
   
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let users = [
        User(id: 1, name: "Ирина Каткова",avatar: UIImage(named: "user5"), photos: [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"),UIImage(named: "i"),UIImage(named: "i-1"),UIImage(named: "i-2"),UIImage(named: "i-3"),UIImage(named: "i-4"),UIImage(named: "i-5"),UIImage(named: "i-6")]),
        User(id: 2,name: "Денис Скороходов", avatar: UIImage(named: "user1"), photos: [ UIImage(named: "i-7"), UIImage(named: "i-8"), UIImage(named: "i-9"),UIImage(named: "i-10"),UIImage(named: "i-11"),UIImage(named: "i-12"),UIImage(named: "i-13"),UIImage(named: "i-14"),UIImage(named: "i-15"),UIImage(named: "i-16"),UIImage(named: "i-17"),UIImage(named: "i-18"),UIImage(named: "i-19")]),
        User(id: 4,name: "Лиза Артемьева", avatar: UIImage(named: "user2"), photos: [UIImage(named: "i-25"),UIImage(named: "i-26"),UIImage(named: "i"),UIImage(named: "i-27")]),
        User(id: 5,name: "Тимофей Иванов",avatar: UIImage(named: "user5"), photos: [UIImage(named: "i-20"),UIImage(named: "i-21"),UIImage(named: "i-22"),UIImage(named: "i-23"),UIImage(named: "i-24")]),
        User(id: 3, name: "Данил Дубровский"),
        User(id: 6, name: "Иван Петров"),
        User(id: 7, name: " Арина Тинькова"),
        User(id: 8, name: "Анастасия Гордон", photos: [UIImage(named: "i-27")]),
        User(id: 9, name: "Павел Яковлев", photos: [UIImage(named: "i-25"), UIImage(named: "i-25")])]
    
    
    var groupedFriends: [GroupedFriends] {
        var result = [GroupedFriends]()
        
        for user in users {
            guard let character = user.name.first else {
                continue
            }
            if let groupedIndex = result.firstIndex(where: {$0.character == character }) {
                result[groupedIndex].users.append(user)
            } else {
                    let friend = GroupedFriends(character: character, users: [user])
                    result.append(friend)
                }
            }
        
        return result.sorted(by: {$0.character < $1.character})
    }
    
    var filteredUsers:[User] = []

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if filteredUsers.count == 0 {
        return String(groupedFriends[section].character)
        } else {
            return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
    }
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredUsers.count == 0 {
        let friendsSection = groupedFriends[section]
         return friendsSection.users.count
        } else {
            return filteredUsers.count
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if filteredUsers.count == 0 {
            return groupedFriends.count
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsTableCell
        var friend = User(id: 0, name: "")
        if filteredUsers.count == 0 {
        let groupedFriend = groupedFriends[indexPath.section]
         friend = groupedFriend.users[indexPath.row]
        } else {
         friend = filteredUsers[indexPath.row]
        }
       
        cell?.friendName.text = friend.name
        cell?.friendImageView.image = friend.avatar
        cell?.friendID = friend.id
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto" {
        let photosVC = segue.destination as! PhotosCollectionViewController
        let cell = sender as! MyFriendsTableCell
        let user = users.first(where: { $0.id == cell.friendID })
        photosVC.photos = user!.photos
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
