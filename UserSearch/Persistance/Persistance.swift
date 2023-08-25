//
//  Persistance.swift
//  UserSearch
//
//  Created by Andrei Simedre on 25.08.2023.
//

import Foundation
import RealmSwift


class Persistance {
    static let shared = Persistance()
    
    private(set) var bookmarkedUsers = [User]()
    let realm = try! Realm()
    
    public func addOrRemoveUser(_ user: User) {
        if bookmarkedUsers.contains(where: { $0.login?.uuid == user.login?.uuid }) {
            updateUserBookmark(user, isBookmarked: false)
            bookmarkedUsers.removeAll { $0.login?.uuid == user.login?.uuid }
        } else {
            bookmarkedUsers.append(user)
            saveUser(user)
        }
    }
    
    private func saveUser(_ user: User) {
        try! realm.write {
            user.isBookmarked = true
            realm.add(user)
        }
    }
    
    private func deleteUser(_ user: User) {
        try! realm.write {
            realm.delete(user)
        }
    }
    
    private func updateUserBookmark(_ user: User, isBookmarked: Bool) {
        guard let index = bookmarkedUsers.firstIndex(where: { $0.login?.uuid == user.login?.uuid }) else { return }
        try! realm.write {
            bookmarkedUsers[index].isBookmarked = isBookmarked
        }
    }
    
    public func loadBookmarkedUsers() {
        var users = realm.objects(User.self)
        users.forEach { user in
            if !user.isBookmarked {
                deleteUser(user)
            }
        }
        bookmarkedUsers.append(contentsOf: users)
    }
    
    public func isUserBookmarked(_ user: User) -> Bool {
        return bookmarkedUsers.contains(where: { $0.login?.uuid == user.login?.uuid })
    }
}
