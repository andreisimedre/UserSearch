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
    private static var apiVersion = 1.2
    
    public func getUsers(page: Int, _ completionHandler: @escaping (_ data: Users?, _ error: Error?) -> Void) {
            guard let url = createUrl(page: page, results: 25, gender: "both", nationality: "") else { return }
            AF.request(url,
                       method: .get,
                       parameters: [:],
                       encoding: URLEncoding.default,
                       headers: nil)
            .response { (responseData) in
                if let data = responseData.data {
                    let users = try? JSONDecoder().decode(Users.self, from: data)
                    completionHandler(users, nil)
                }
            }
        }
    
    private func createUrl(page: Int, results: Int, gender: String, nationality: String) -> URL? {
        // swiftlint:disable line_length
        return URL(string: "https://randomuser.me/api/\(API.apiVersion)/?format=json&results=\(results)&gender=\(gender)&nat=\(nationality)&page=\(page)")
    }
}
