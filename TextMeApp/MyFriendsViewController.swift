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
    
    var users = [User(name: "Том",avatar: UIImage(named: "user5"), photos: [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"),UIImage(named: "i"),UIImage(named: "i-1"),UIImage(named: "i-2"),UIImage(named: "i-3"),UIImage(named: "i-4"),UIImage(named: "i-5"),UIImage(named: "i-6")]), User(name: "Стив", avatar: UIImage(named: "user1"), photos: [ UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"),UIImage(named: "i"),UIImage(named: "i-1"),UIImage(named: "i-2"),UIImage(named: "i-3"),UIImage(named: "i-4"),UIImage(named: "i-5"),UIImage(named: "i-6"),UIImage(named: "i-7"),UIImage(named: "i-8"),UIImage(named: "i-9"),UIImage(named: "i-10"),UIImage(named: "i-11"),UIImage(named: "i-12"),UIImage(named: "i-13"),UIImage(named: "i-14")]), User(name: "Джэк", avatar: UIImage(named: "user3")), User(name: "Линда", avatar: UIImage(named: "user2"), photos: [UIImage(named: "i"),UIImage(named: "i"),UIImage(named: "i"),UIImage(named: "i"),UIImage(named: "i")]),User(name: "Тимофей",avatar: UIImage(named: "user5"), photos: [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"),UIImage(named: "i"),UIImage(named: "i-1"),UIImage(named: "i-2"),UIImage(named: "i-3"),UIImage(named: "i-4"),UIImage(named: "i-5"),UIImage(named: "i-6")]),]
    
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(groupedFriends[section].character)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "FirstLetterHeader", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "firstLetter")
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let friendsSection = groupedFriends[section]
         return friendsSection.users.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        groupedFriends.count
        }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsTableCell
        let groupedFriend = groupedFriends[indexPath.section]
        let friend = groupedFriend.users[indexPath.row]
        cell?.friendName.text = friend.name
        cell?.friendImageView.image = friend.avatar
        return cell ?? UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? MyFriendsTableCell,
              let index = tableView.indexPath(for: cell)?.row,
              let photosVC = segue.destination as? PhotosCollectionViewController else {
                  return
              }
        let user = users[index]
        photosVC.photos = user.photos
    }
}
