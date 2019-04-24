//
//  RoomType.swift
//  System_View_Controllers
//
//  Created by Миронов Влад on 20/04/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import Foundation

struct RoomType {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all = [
        RoomType(id: 0, name: "Two Queens", shortName: "2Q", price: 249),
        RoomType(id: 1, name: "One King", shortName: "OK", price: 349),
        RoomType(id: 2, name: "Penthouse Suite", shortName: "PHS", price: 499),
    ]
}


// MARK: - Equatable RoomType
extension RoomType: Equatable {
    static func == (left: RoomType, right: RoomType) -> Bool {
        return left.id == right.id
    }
}
