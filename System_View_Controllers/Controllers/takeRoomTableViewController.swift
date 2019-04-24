//
//  TableViewController.swift
//  System_View_Controllers
//
//  Created by Миронов Влад on 24/04/2019.
//  Copyright © 2019 Миронов Влад. All rights reserved.
//

import UIKit

class takeRoomTableViewController: UITableViewController {

    let allRooms = RoomType.all
    var takedRoom: RoomType?
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allRooms.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let room = allRooms[indexPath.row]
        cell.textLabel?.text = room.name
        cell.detailTextLabel?.text = "\(room.price)"
        cell.accessoryType = room == takedRoom ? .checkmark : .none

        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let indexPath = tableView.indexPathForSelectedRow else {return}
        takedRoom = allRooms[indexPath.row]
    }
 


}
