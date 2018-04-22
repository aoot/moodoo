
//  ViewController.swift
//  Moodoo2
//
//  Created by Natascha Brauchle on 4/10/18.
//  Copyright © 2018 Natascha Brauchle. All rights reserved.
//

import UIKit
import CoreData
var moods = [NSManagedObject]()

class ViewController: UIViewController, UITextFieldDelegate{
    var AddMoodDelegate: ViewController? = nil
    @IBOutlet weak var excitedLabel: UILabel!
    @IBOutlet weak var excitedValue: UISlider!
    @IBAction func excitedSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
        excitedLabel.text = String(roundf(sender.value))
    }
    
    @IBOutlet weak var happyValue: UISlider!
    @IBAction func happySlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    @IBOutlet weak var sadValue: UISlider!
    @IBAction func sadSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    @IBOutlet weak var angryValue: UISlider!
    @IBAction func angrySlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    @IBOutlet weak var anxiousValue: UISlider!
    @IBAction func anxiousSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
    }
    @IBOutlet weak var reasons: UITextField!
    @IBOutlet weak var sleep: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        let dateVar = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        var dateStr = dateFormatter.string(from: dateVar as Date)
        if moods.count == 0{
            let alert = UIAlertController(title: "Congrats!",
                                          message: "You logged your mood \(moods.count + 1) time!",
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .`default`){(action: UIAlertAction!) -> Void in
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        else{
            let alert = UIAlertController(title: "Congrats!",
                                          message: "You logged your mood \(moods.count + 1) times!",
                preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .`default`){(action: UIAlertAction!) -> Void in
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        func saveMood(anxious:String, angry:String, happy:String, excited:String, sad: String, sleepInt: String, reasonsEnter: String, date: String) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            // Create the entity we want to save
            let entity =  NSEntityDescription.entity(forEntityName: "Mood", in: managedContext)
            
            let mood = NSManagedObject(entity: entity!, insertInto:managedContext)
            
            // Set the attribute values
            mood.setValue(String(roundf(anxiousValue.value)), forKey: "anxious")
            mood.setValue(String(roundf(angryValue.value)), forKey: "angry")
            mood.setValue(String(roundf(happyValue.value)), forKey: "happy")
            mood.setValue(String(roundf(sadValue.value)), forKey: "sad")
            mood.setValue(String(roundf(excitedValue.value)), forKey: "excited")
            mood.setValue(sleep.text!, forKey: "sleep")
            mood.setValue(reasons.text!, forKey: "reasons")
            mood.setValue(date, forKey: "date")
            
            // Commit the changes.
            do {
                try managedContext.save()
            } catch {
                // what to do if an error occurs?
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
            
            // Add the new entity to our array of managed objects
            moods.append(mood)
        }
        
        saveMood(anxious: String(roundf(anxiousValue.value)), angry: String(roundf(angryValue.value)), happy: String(roundf(happyValue.value)), excited: String(roundf(excitedValue.value)), sad: String(roundf(sadValue.value)), sleepInt: sleep.text!, reasonsEnter: reasons.text!, date: dateStr)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let str = formatter.string(from: Date())
        self.navigationItem.title = str
        anxiousValue.value = 0
        angryValue.value = 0
        happyValue.value = 0
        sadValue.value = 0
        excitedValue.value = 0
        reasons.text = ""
        sleep.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 'First Responder' is the same as 'input focus'.
        // We are removing input focus from the text field.
        textField.resignFirstResponder()
        return true
    }
    
    // Called when the user touches on the main view (outside the UITextField).
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // This causes the keyboard to be dismissed.
        self.view.endEditing(true)
    }
    
}
