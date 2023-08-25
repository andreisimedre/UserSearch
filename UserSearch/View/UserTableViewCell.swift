//
//  UserTableViewCell.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import UIKit

protocol BookmarkButtonDelegate: AnyObject {
    func didTappedBookmarkButton(_ indexPath: IndexPath?)
}

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var wrappView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var user: User?
    var indexPath: IndexPath?
    
    weak var delegate: BookmarkButtonDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        wrappView.layer.cornerRadius = 5
        wrappView.layer.masksToBounds = true
        
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func configure(with user: User, _ indexPath: IndexPath) {
        self.user = user
        self.indexPath = indexPath
        avatarImageView.loadImageFromUrl(user.picture?.large ?? "")
        firstNameLabel.text = user.name?.first.capitalized
        lastNameLabel.text = user.name?.last.capitalized
        emailLabel.text = user.email
        
        let bookmarkImage = user.isBookmarked ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        bookmarkButton.setImage(bookmarkImage, for: .normal)
    }
    
    @IBAction func bookmarkButtonTapped() {
        guard let user = user else { return }
        Persistance.shared.addOrRemoveUser(user)
        delegate?.didTappedBookmarkButton(indexPath)
    }
}
