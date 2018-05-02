
//  ViewController.swift
//  Moodoo2
//
//  Created by Natascha Brauchle on 4/10/18.
//  Copyright © 2018 Natascha Brauchle. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var excitedValue: UISlider!
    
    @IBAction func excitedSlider(_ sender: UISlider) {
        sender.value = roundf(sender.value)
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

    @IBOutlet weak var reasons: UITextField!
    @IBOutlet weak var sleep: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let dateStr = dateFormatter.string(from: NSDate() as Date)
        
        PersistenceService.shared.saveMood(angry: String(roundf(angryValue.value)), happy: String(roundf(happyValue.value)), excited: String(roundf(excitedValue.value)), sad: String(roundf(sadValue.value)), sleep: sleep.text!, reasons: reasons.text!, date: dateStr)
        
        let moodCount = PersistenceService.shared.getMoodCount()
        var s = ""
        if moodCount > 1 {
            s = "s"
        }
        
        let alert = UIAlertController(title: "Congratulations!",
                                          message: "You've logged your mood \(moodCount) time\(s)!",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .`default`){(action: UIAlertAction!) -> Void in}
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        let str = formatter.string(from: Date())
        self.navigationItem.title = str
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
    
}

extension ViewController: UITextFieldDelegate {
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
