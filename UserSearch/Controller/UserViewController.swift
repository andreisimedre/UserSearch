//
//  UserViewController.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import UIKit

class UserViewController: UIViewController {
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var countryFlagImageView: UIImageView!
    @IBOutlet weak var cityStateLabel: UILabel!
    @IBOutlet weak var streetNumberLabel: UILabel!
    
    var user: User?
    weak var delegate: BookmarkButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setBookmarkButtonImage()
    }
    
    func setup() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        if let profileImageUrl = user?.picture?.large {
            profileImageView.loadImageFromUrl(profileImageUrl)
        }
        
        nameLabel.text = user?.fullName
        emailLabel.text = user?.email
        phoneNumberLabel.text = user?.phone
        
        countryFlagImageView.image = UIImage(named: user?.nat?.lowercased() ?? "")
        
        cityStateLabel.text = "\(user?.location?.city?.capitalized ?? ""), \(user?.location?.state?.capitalized ?? "")"
        streetNumberLabel.text = user?.location?.street?.capitalized
        
        let backBarButton = UIBarButtonItem.init(barButtonSystemItem: .close, target: self, action: #selector(backButtonTapped)) as UIBarButtonItem
        self.navigationItem.setLeftBarButton(backBarButton, animated: true)
    }
    
    @IBAction func bookmarkButtonTapped() {
        guard let user = user else { return }
        Persistance.shared.addOrRemoveUser(user)
        setBookmarkButtonImage()
        delegate?.didTappedBookmarkButton(nil)
    }
    
    func setBookmarkButtonImage() {
        guard let user = user else { return }
        let bookmarkImage = Persistance.shared.isUserBookmarked(user) ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark")
        bookmarkButton.setImage(bookmarkImage, for: .normal)
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
