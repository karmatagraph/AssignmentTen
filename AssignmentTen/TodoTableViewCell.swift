//
//  TodoTableViewCell.swift
//  AssignmentTen
//
//  Created by karma on 3/11/22.
//

import UIKit

class TodoTableViewCell: UITableViewCell {

//    @IBOutlet weak var createdLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
   
    func setData(item: TaskItem){
        let date = item.createdAt
        let dateformatter = DateFormatter()
        let str = item.name! + " created on" + DateFormatter().string(from: item.createdAt!)
        nameLbl.text = item.name
        print(dateformatter.string(from: date!))
        
        
    }

}
