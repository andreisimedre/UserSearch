//
//  UserListViewController.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import UIKit

class UserListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var users = [User]()
    var usersToFilter = [User]()
    var currentPage = 1
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        loadUsers()
    }
    
    func setup() {
        self.title = "Users"
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        users.removeAll()
        tableView.reloadData()
        loadUsers()
    }
    
    func loadUsers() {
        activityIndicator.startAnimating()
        API.shared.getUsers(page: currentPage) { [self] data, error in
            guard let data = data else { return }
            self.users.append(contentsOf: data.results)
            self.usersToFilter.append(contentsOf: data.results)
            self.tableView.reloadData()
            
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
            refreshControl.endRefreshing()
        }
    }
}

extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell()}
        
        cell.configure(with: users[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == currentPage * 24 {
            currentPage += 1
            loadUsers()
        }
    }
}

extension UserListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            users = usersToFilter
            tableView.reloadData()
            return
        }
        
        users = usersToFilter.filter { user in
            for textToSearchInto in [user.name?.first, user.name?.last, user.email, user.location?.city, user.location?.state, user.location?.street] {
                if textToSearchInto?.contains(find: searchText) ?? false {
                    return true
                } else {
                    return false
                }
            }
            return false
        }
        tableView.reloadData()
    }
}
