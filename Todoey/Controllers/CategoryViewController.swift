//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Mark Eve on 23.01.18.
//  Copyright © 2018 Mark Eve. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
   var categoryArray = [Category]()
   let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

   override func viewDidLoad() {
      super.viewDidLoad()
      print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
      
      loadItems()
   }

   //MARK: - Add New Categories

   @IBAction func AddButtonPressed(_ sender: UIBarButtonItem) {
      var textField = UITextField()
      
      let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
      let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
         // What will happen once the user clicks the Add Item button on our UIAlert
         
         let newCategory = Category(context: self.context)
         newCategory.name = textField.text!
         self.categoryArray.append(newCategory)
         self.saveItems()
      }
      
      alert.addTextField { (alertTextField) in
         alertTextField.placeholder = "Create new category"
         textField = alertTextField
      }
      
      alert.addAction(action)
      present(alert, animated: true, completion: nil)
   }
   
   //MARK: - TableView Datasource Methods
   
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return categoryArray.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
      cell.textLabel?.text = categoryArray[indexPath.row].name
      
      return cell
   }
   
   //MARK: - Data Manipulation Methods
   
   func saveItems() {
      do {
         try context.save()
      }
         
      catch {
         print("Error saving context \(error)")
      }
      
      self.tableView.reloadData()
   }
   
   func loadItems(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
      do {
         categoryArray = try context.fetch(request)
      }
         
      catch {
         print("Error fetching data from context \(error)")
      }
      
      tableView.reloadData()
   }

   //MARK: - TableView Delegate Methods
   // i.e. what should happen when we click on one of the cells in the TableView

   override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "goToItems", sender: self)
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      let destinationVC = segue.destination as! TodoListViewController
      if let indexPath = tableView.indexPathForSelectedRow {
         destinationVC.selectedCategory = categoryArray[indexPath.row]
      }
   }
}
