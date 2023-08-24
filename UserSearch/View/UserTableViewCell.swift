//
//  UserTableViewCell.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var wrappView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bookMarkButton: UIButton!
    
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
    
    func configure(with user: User) {
        avatarImageView.loadImageFromUrl(user.picture?.large ?? "")
        firstNameLabel.text = user.name?.first?.capitalized
        lastNameLabel.text = user.name?.last?.capitalized
        emailLabel.text = user.email
    }
    
    @IBAction func bookMarkButtonTapped() {
        
    }
}
