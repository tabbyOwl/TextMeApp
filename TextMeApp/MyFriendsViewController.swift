//
//  MyFriendsTableViewController.swift
//  TextMeApp
//
//  Created by jane on 28.03.2022.
//

import UIKit

class MyFriendsViewController: UITableViewController {
    
    
    var users = [User(name: "userOne",photos: [UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"),UIImage(named: "i"),UIImage(named: "i-1"),UIImage(named: "i-2"),UIImage(named: "i-3"),UIImage(named: "i-4"),UIImage(named: "i-5"),UIImage(named: "i-6")]), User(name: "userTwo", avatar: UIImage(named: "girl"), photos: [ UIImage(named: "photo1"), UIImage(named: "photo2"), UIImage(named: "photo3"),UIImage(named: "i"),UIImage(named: "i-1"),UIImage(named: "i-2"),UIImage(named: "i-3"),UIImage(named: "i-4"),UIImage(named: "i-5"),UIImage(named: "i-6"),UIImage(named: "i-7"),UIImage(named: "i-8"),UIImage(named: "i-9"),UIImage(named: "i-10"),UIImage(named: "i-11"),UIImage(named: "i-12"),UIImage(named: "i-13"),UIImage(named: "i-14")]), User(name: "userThree"), User(name: "userFour", avatar: UIImage(named: "i-3"), photos: [UIImage(named: "i"),UIImage(named: "i"),UIImage(named: "i"),UIImage(named: "i"),UIImage(named: "i")])]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as? MyFriendsTableCell
        let friend = users[indexPath.row]
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
