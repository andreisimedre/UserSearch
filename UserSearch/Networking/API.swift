//
//  API.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import Foundation
import Alamofire

class API {
    public static let shared = API()
    private let baseURL = "https://randomuser.me/api/1.2/"
    
    public func getUsers(page: Int, _ completionHandler: @escaping (_ data: Users?, _ error: Error?) -> Void) {
        AF.request(baseURL,
                   method: .get,
                   parameters: ["results": 25,
                                "gender": "both",
                                "nat": "",
                                "page": page,
                                "format": "json"],
                   headers: nil)
        .response { (responseData) in
            if let data = responseData.data {
                let users = try? JSONDecoder().decode(Users.self, from: data)
                completionHandler(users, nil)
            }
        }
    }
}
