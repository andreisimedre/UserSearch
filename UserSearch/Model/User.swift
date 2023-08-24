//
//  User.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import Foundation

public struct Users: Codable {
    let results: [User]
    let info: Info?
}

struct Info: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

struct User: Codable {
    let gender: Gender?
    let name: NameClass?
    let location: Location?
    let email: String?
    let dob: Dob?
    let registered: Dob?
    let phone: String?
    let cell: String?
    let id: ID?
    let picture: Picture?
    let nat: String?
}

struct Dob: Codable {
    let date: String?
    let age: Int?
}

enum Gender: String, Codable {
    case female
    case male
}

struct ID: Codable {
    let name: NameEnum?
    let value: String?
}

enum NameEnum: String, Codable {
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

struct Location: Codable {
    let street: String?
    let city: String?
    let state: String?
}

struct NameClass: Codable {
    let title: Title?
    let first: String?
    let last: String?
}

enum Title: String, Codable {
    case madame
    case mademoiselle
    case miss
    case monsieur
    case mr
    case mrs
    case ms
}

struct Picture: Codable {
    let large: String?
    let medium: String?
    let thumbnail: String?
}
