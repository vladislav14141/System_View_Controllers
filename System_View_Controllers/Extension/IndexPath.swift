//
//  IndexPath.swift
//  System_View_Controllers
//
//  Created by Миронов Влад on 23/04/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import UIKit

extension IndexPath {
    var prevRow: IndexPath{
        let row = self.row - 1
        let section = self.section
        
        return IndexPath(row: row, section: section)
    }
    
}
