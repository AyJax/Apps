//
//  ViewController.swift
//  core data v2
//
//  Created by apcs2 on 9/13/17.
//  Copyright © 2017 apcs2. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var saveTableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasks: [Task] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        saveTableView.delegate = self
        saveTableView.dataSource = self
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Entity")
//        do {
//            tasks = try fetchFunction(fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
//            
//            
//}
//   catch
//   {
//    
//        }
//        func fetchFunction(request:NSFetchRequest<NSFetchRequestResult>) throws -> [Any]
//        {
//            var array2 : [Any]! = []
//            let appDelegate = UIApplication.shared.delegate as? AppDelegate
//            let manageContext = appDelegate?.persistentContainer.viewContext
//            do
//            {
//                array2 = try manageContext?.fetch(request)
//            }
//            catch
//            {
//                return array2
//            }
//
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        saveTableView.reloadData()
    }
    
    func getData() {
        do {
            tasks = try context.fetch(Task.fetchRequest())
        } catch {
            print("Fetching Failed")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = tasks[indexPath.row]
        
        if let myName = task.name {
            cell.textLabel?.text = myName
        }
        if let myDetail = task.detail {
            cell.detailTextLabel?.text = myDetail
        }
        cell.detailTextLabel?.textColor = UIColor.purple
        cell.textLabel?.textColor = UIColor.cyan
                return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasks[indexPath.row]
            context.delete(task)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                tasks = try context.fetch(Task.fetchRequest())
            } catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    
//    func save(text: String, decimal: Float)
//    {
//        
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
//    else
//    {
//         return
//        }
//   
//    let manageContext = appDelegate.persistentContainer.viewContext
//        let entity = NSEntityDescription.entity(forEntityName:"Entity", in: manageContext)!
//        let newObject = NSManagedObject(entity: entity, insertInto: manageContext)
//        newObject.setValue(text, forKey: "text")
//        newObject.setValue(decimal, forKey: "decimal")
//    
//        do
//        {
//         try manageContext.save()
//            
//        }
//catch
//{
//    print("Error")
//        }
//    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
    {
return true
        
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
    {
        
    
    }
    @IBAction func editButton(_ sender: UIBarButtonItem)
    {
        if saveTableView.isEditing == true
        {
            saveTableView.setEditing(false, animated: true)
            sender.title = "Edit"
            
        }
        else
        {
            saveTableView.setEditing(true, animated: true)
            sender.style = UIBarButtonItemStyle.done
            sender.title = "Done"
        }

        
    
    }
    
    @IBAction func plusButton(_ sender: UIBarButtonItem)
    {
       
        
        let alert = UIAlertController(title: "Create Your Grocery List", message: "", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.placeholder = "Item"
                textField.textColor = UIColor.cyan
            textField.font = UIFont(name: (textField.font?.fontName)!, size: 24)
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Isle"
            textField.textColor = UIColor.purple
textField.font = UIFont(name: (textField.font?.fontName)!, size: 24)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler : nil); alert.addAction(cancelAction)
        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { [weak alert] (action) -> Void in
            
            let itemTextField = alert!.textFields![0]
            let isleTextField = alert!.textFields![1]

             //let newTask = Task()
            
           
            self.saveTableView.reloadData()
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let task = Task(context: context) // Link Task & Context
            task.detail = isleTextField.text!
            task.name = itemTextField.text!
            // Save the data to coredata
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
             self.tasks.append(task)
            self.saveTableView.reloadData()
            
    
        }))
        self.present(alert, animated: true, completion: nil)
        

    }
}

