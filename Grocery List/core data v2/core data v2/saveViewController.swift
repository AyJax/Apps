//
//  saveViewController.swift
//  core data v2
//
//  Created by apcs2 on 9/13/17.
//  Copyright © 2017 apcs2. All rights reserved.
//

import UIKit

class saveViewController: UIViewController {

    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var saveTextField: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
    }
    
    @IBAction func addTaskButton(_ sender: UIButton)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let task = Task(context: context) // Link Task & Context
        task.detail = detailTextField.text!
        task.name = saveTextField.text!
               // Save the data to coredata
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        let _ = navigationController?.popViewController(animated: true)
        //This computer has made a change
    }

    
    }
  

