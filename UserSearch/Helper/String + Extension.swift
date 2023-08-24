//
//  String + Extension.swift
//  UserSearch
//
//  Created by Andrei Simedre on 24.08.2023.
//

import Foundation

extension String {
    func contains(find: String) -> Bool{
        return self.lowercased().range(of: find.lowercased()) != nil
    }
}
