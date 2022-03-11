//
//  ViewController.swift
//  AssignmentTen
//
//  Created by karma on 3/11/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    // create an instance of the managed obj context (view context)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        tableView.delegate = self
        tableView.dataSource = self
        getAllItems()
        
        // add the left add button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    @objc func didTapAdd(){
        // alert pop up
        let alert = UIAlertController(title: "New Item", message: "Enter a new Task", preferredStyle: .alert)
        // textfield for the alert box
        alert.addTextField(configurationHandler: nil)
        // add submit action button which will save it to the core data
        // weak self to address memory leak
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: {[weak self]_ in
            // validation of the textfield done in the closure
            guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
                return
            }
            // add it to the core data
            self?.createItem(name: text)
            
            
        }))
        
        
        
        present(alert, animated: true)
    }

    // get all the items
    func getAllItems(){
        do{
            tasks = try context.fetch(TaskItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
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
            getAllItems()
        }catch let error{
            print("error creating data: \(error)")
        }
        
        
    }
    
    // update an item
    func updateItem(item: TaskItem,name: String){
        item.name = name
        do{
            try context.save()
            getAllItems()
        }catch let error{
            print("error updating data: \(error)")
        }
        
    }
    
    // delete an item
    func deleteItem(item: TaskItem){
        context.delete(item)
        do{
            try context.save()
            getAllItems()
        }catch let error{
            print("error deleting data: \(error)")
        }
        
    }
}
extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // the task is selected
        tableView.deselectRow(at: indexPath, animated: true)
        
        // get the selected row value
        let item = tasks[indexPath.row]
        
        // alert pop up
        let sheet = UIAlertController(title: "Edit", message: nil, preferredStyle: .actionSheet)
        
        // add submit action button which will save it to the core data
        // weak self to address memory leak
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        sheet.addAction(UIAlertAction(title: "Edit", style: .default, handler: { _ in
            let alert = UIAlertController(title: "Edit your Item", message: "Edit Task", preferredStyle: .alert)
            // textfield for the alert box
            alert.addTextField(configurationHandler: nil)
            // show the name to be edited
            alert.textFields?.first?.text = item.name
            // add submit action button which will save it to the core data
            // weak self to address memory leak
            alert.addAction(UIAlertAction(title: "Save", style: .cancel, handler: {[weak self] _ in
                // validation of the textfield done in the closure
                guard let field = alert.textFields?.first, let newName = field.text, !newName.isEmpty else{
                    return
                }
                // add it to the core data
                self?.updateItem(item: item, name: newName)
            }))
            self.present(alert, animated: true, completion: nil)
        }))
        
        sheet.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { [weak self] _ in
            self?.deleteItem(item: item)
        }))
        present(sheet, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let task = tasks[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell", for: indexPath) as! TodoTableViewCell
        cell.setData(item: task)
        return cell
    }
}

