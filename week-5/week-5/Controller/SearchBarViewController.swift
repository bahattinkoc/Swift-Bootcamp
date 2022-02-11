//
//  SearchBarViewController.swift
//  week-5
//
//  Created by Bahattin Koç on 4.02.2022.
//

import UIKit

class SearchBarViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var users = [User]()
    var filteredUsers = [User]()
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        guard let userURL = URL(string: urlStr) else { return }
        let userList = try? JSONDecoder().decode([User].self, from: Data(contentsOf: userURL))
        guard let users = userList else { return }
        self.users = users
        
        print(users)
        
        tableView.dataSource = self
    }
}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering{
            return filteredUsers.count
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell")
        cell?.textLabel?.text = isFiltering ? filteredUsers[indexPath.row].username : users[indexPath.row].username
        cell?.detailTextLabel?.text = isFiltering ? filteredUsers[indexPath.row].email : users[indexPath.row].email
        return cell!
    }
}


// Extension
extension SearchBarViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredUsers = users.filter({ (user: User) -> Bool in
            return user.username.lowercased().contains(searchText.lowercased())
        })
        
        // isFiltering = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // isFiltering = false
        searchBar.text = ""
        tableView.reloadData()
    }
}
