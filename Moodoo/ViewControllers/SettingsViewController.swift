//
//  SettingsViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 4/10/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit
import CoreData


class SettingsViewController: UIViewController {

    private var alertController:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Settings"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func btnDeleteData(_ sender:Any) {
        self.alertController = UIAlertController(title: "Are you sure?", message: "This action cannot be undone", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated:true, completion:nil)
        func deleteAllData(entity: String)
        {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            fetchRequest.returnsObjectsAsFaults = false
            do
            {
                let results = try managedContext.fetch(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    managedContext.delete(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
            }
        }
        
        deleteAllData(entity: "Mood")
    }
    
    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
