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
    
}


// MARK: - Equatable RoomType
extension RoomType: Equatable {
    static func == (left: RoomType, right: RoomType) -> Bool {
        return left.id == right.id
    }
}
