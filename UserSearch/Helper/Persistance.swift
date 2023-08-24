//
//  Persistance.swift
//  UserSearch
//
//  Created by Andrei Simedre on 25.08.2023.
//

import Foundation

class Persistance {
    static let shared = Persistance()
    
    private(set) var bookmarkedUsers = [User]()
    
    public func addOrRemoveUser(_ user: User) {
        if bookmarkedUsers.contains(where: { $0.login.uuid == user.login.uuid }) {
            bookmarkedUsers.removeAll { $0.login.uuid == user.login.uuid }
        } else {
            bookmarkedUsers.append(user)
        }
    }
    
    public func isUserBookmarked(_ user: User) -> Bool {
        return bookmarkedUsers.contains(where: { $0.login.uuid == user.login.uuid })
    }
}
