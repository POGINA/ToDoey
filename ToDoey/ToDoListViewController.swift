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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(dataFilePath)
        
        loadItems()
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
        
        saveItems()
        
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
//            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
//            self.defaults.object(forKey: "ToDoListArray")
            self.saveItems()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
            print("now")
        }
        present(alert,animated: true, completion: nil)
        alert.addAction(action)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array \(error)")
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                 itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("ERROR: \(error)" )
            }
        }
    }
    
}

