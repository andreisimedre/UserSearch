//
//  User.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import Foundation

public struct Users: Decodable {
    let results: [User]
    let info: Info?
}

struct Info: Decodable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

struct User: Decodable {
    let gender: Gender?
    let name: NameClass
    let location: Location?
    let email: String?
    let dob: Dob?
    let registered: Dob?
    let phone: String?
    let cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
    let login: Login
    
    var fullName: String {
        return "\(name.title.rawValue.capitalized) \(name.first.capitalized) \(name.last.capitalized)"
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.login.uuid == rhs.login.uuid
    }
}

struct Login: Decodable {
    let uuid: String
}

struct Dob: Decodable {
    let date: String?
    let age: Int?
}

enum Gender: String, Decodable {
    case female
    case male
}

struct ID: Decodable {
    let name: NameEnum?
    let value: String?
}

enum NameEnum: String, Decodable {
    case avs = "AVS"
    case bsn = "BSN"
    case cpr = "CPR"
    case dni = "DNI"
    case empty = ""
    case fn = "FN"
    case hetu = "HETU"
    case insee = "INSEE"
    case nino = "NINO"
    case pps = "PPS"
    case ssn = "SSN"
    case tfn = "TFN"
}

struct Location: Decodable {
    let street: String?
    let city: String?
    let state: String?
    let country: String?
}

struct NameClass: Decodable {
    let title: Title
    let first: String
    let last: String
}

enum Title: String, Decodable {
    case madame
    case mademoiselle
    case miss
    case monsieur
    case mr
    case mrs
    case ms
}

struct Picture: Decodable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
