//
//  Bookmark.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import UIKit

class BookmarksViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let emptyView: EmptyView = EmptyView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tableView.reloadData()
    }
    
    func setup() {
        self.title = "Bookmarks"
        
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        
        emptyView.frame = self.view.frame
        emptyView.isHidden = true
        self.view.addSubview(emptyView)
    }
}

extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        emptyView.isHidden = !(Persistance.shared.bookmarkedUsers.count == 0)
        return Persistance.shared.bookmarkedUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell()}
        
        cell.configure(with: Persistance.shared.bookmarkedUsers[indexPath.row], indexPath)
        cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "UserViewController", bundle: nil)
        guard let userViewController = storyboard.instantiateViewController(withIdentifier: "UserViewController") as? UserViewController else { return }
        userViewController.user = Persistance.shared.bookmarkedUsers[indexPath.row]
        userViewController.delegate = self
        
        self.navigationController?.pushViewController(userViewController, animated: true)
    }
}

extension BookmarksViewController: BookmarkButtonDelegate {
    func didTappedBookmarkButton(_ indexPath: IndexPath?) {
        tableView.reloadData()
    }
}
