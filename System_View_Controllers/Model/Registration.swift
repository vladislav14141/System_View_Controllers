//
//  Registration.swift
//  System_View_Controllers
//
//  Created by Миронов Влад on 20/04/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool

}
