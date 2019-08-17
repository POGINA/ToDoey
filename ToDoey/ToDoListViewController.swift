//
//  ViewController.swift
//  ToDoey
//
//  Created by Nes Ab on 8/15/19.
//  Copyright © 2019 nes. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    

    
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Find Nes"
        itemArray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Find Nes1"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Find Nes2"
        itemArray.append(newItem2)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let items = itemArray[indexPath.row]
        cell.textLabel?.text = items.title
        
        //ternary Operations ==>
        // value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = items.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - TableView Delegate Method
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
        @IBAction func addbuttonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New To Do List", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item ", style: .default) { (action) in
            // What will happen once the user clicks the Add Item button on the UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print("now")
        }
        present(alert,animated: true, completion: nil)
        alert.addAction(action)
    }
    
    
    
}

