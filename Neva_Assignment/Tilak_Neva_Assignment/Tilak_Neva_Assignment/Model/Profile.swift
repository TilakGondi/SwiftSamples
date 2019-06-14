//
//  Profile.swift
//  Tilak_Neva_Assignment
//
//  Created by Tilakkumar Gondi on 07/06/19.
//  Copyright © 2019 Tilakkumar Gondi. All rights reserved.
//

import Foundation

struct ResponseData: Decodable {
    let code: Int
    let message: String
    let data: [Profile]
}

struct Profile: Decodable,Hashable,Equatable {
    let id: Int?
    let name: String?
    let skills: String?
    let image: String?
}
