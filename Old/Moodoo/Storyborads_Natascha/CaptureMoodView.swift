//
//  CaptureMoodView.swift
//  Moodoo
//
//  Created by Natascha Brauchle on 4/19/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit
import CoreData
var moods = [NSManagedObject]()

class CaptureMoodView: UIViewController, UITextFieldDelegate{
    var AddMoodDelegate: CaptureMoodView? = nil
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
        func saveMood(anxious:Int, angry:Int, happy:Int, excited:Int, sad: Int, sleepInt: String, reasonsEnter: String, date: String) {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            // Create the entity we want to save
            let entity =  NSEntityDescription.entity(forEntityName: "Mood", in: managedContext)
            
            let mood = NSManagedObject(entity: entity!, insertInto:managedContext)
            
            
            // Set the attribute values
            mood.setValue(anxiousValue.value, forKey: "anxious")
            mood.setValue(angryValue.value, forKey: "angry")
            mood.setValue(happyValue.value, forKey: "happy")
            mood.setValue(sadValue.value, forKey: "sad")
            mood.setValue(excitedValue.value, forKey: "excited")
            mood.setValue(sleep.text, forKey: "sleep")
            mood.setValue(reasons.text, forKey: "reasons")
            mood.setValue(dateStr, forKey: "date")
            
            
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
        saveMood(anxious: Int(anxiousValue.value), angry: Int(angryValue.value), happy: Int(happyValue.value), excited: Int(excitedValue.value), sad: Int(sadValue.value), sleepInt: sleep.text!, reasonsEnter: reasons.text!, date: dateStr)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateVar = NSDate()
        var dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        var date = dateFormatter.string(from: dateVar as Date)
        
        anxiousValue.value = 0
        angryValue.value = 0
        happyValue.value = 0
        sadValue.value = 0
        excitedValue.value = 0
        reasons.text = ""
        sleep.text = ""
        self.navigationItem.title = date
        
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

