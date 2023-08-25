//
//  User.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import Foundation
import RealmSwift

public struct Users: Decodable {
    let results: [User]
    let info: Info?
}

class Info: Decodable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

class User: Object, Decodable {
    private enum CodingKeys: String, CodingKey {
        case gender, name, location, email, dob, registered, phone, cell, picture, nat, login
    }
    
    @Persisted var gender: Gender?
    @Persisted @objc var name: NameClass?
    @Persisted @objc var location: Location?
    @Persisted var email: String?
    @Persisted @objc var dob: Dob?
    @Persisted @objc var registered: Dob?
    @Persisted var phone: String?
    @Persisted var cell: String?
    @Persisted @objc var picture: Picture?
    @Persisted var nat: String?
    @Persisted @objc var login: Login?
    
    @Persisted var isBookmarked = false
    
    var fullName: String {
        return "\(name?.title.rawValue.capitalized ?? "") \(name?.first.capitalized ?? "") \(name?.last.capitalized ?? "")"
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.login?.uuid == rhs.login?.uuid
    }
}

class Login: EmbeddedObject, Decodable {
    @Persisted var uuid: String
}

class Dob: EmbeddedObject, Decodable {
    @Persisted var date: String?
    @Persisted var age: Int?
}

enum Gender: String, PersistableEnum, Decodable {
    case female
    case male
}

class Location: EmbeddedObject, Decodable {
    @Persisted var street: String?
    @Persisted var city: String?
    @Persisted var state: String?
    @Persisted var country: String?
}

class NameClass: EmbeddedObject, Decodable {
    @Persisted var title: Title
    @Persisted var first: String
    @Persisted var last: String
}

enum Title: String, PersistableEnum, Decodable {
    case madame
    case mademoiselle
    case miss
    case monsieur
    case mr
    case mrs
    case ms
}

class Picture: EmbeddedObject, Decodable {
    @Persisted var large: String?
    @Persisted var medium: String?
    @Persisted var thumbnail: String?
}
