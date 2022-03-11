//
//  ViewController.swift
//  AssignmentTen
//
//  Created by karma on 3/11/22.
//

import UIKit

class ViewController: UIViewController {

    // create an instance of the managed obj context (view context)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    // get all the items
    func getAllItems(){
        do{
            let item = try context.fetch(TaskItem.fetchRequest())
            
            tasks = item
        }catch let error{
            print("error fetching data: \(error)")
        }
        
    }
    
    // create an item
    func createItem(name: String){
        let newItem = TaskItem(context: context)
        newItem.name = name
        newItem.createdAt = Date()
        do{
            try context.save()
        }catch let error{
            print("error creating data: \(error)")
        }
        
        
    }
    
    // update an item
    func updateItem(item: TaskItem,name: String){
        item.name = name
        do{
            try context.save()
        }catch let error{
            print("error updating data: \(error)")
        }
        
    }
    
    // delete an item
    func deleteItem(item: TaskItem){
        context.delete(item)
        do{
            try context.save()
        }catch let error{
            print("error deleting data: \(error)")
        }
        
    }
}

