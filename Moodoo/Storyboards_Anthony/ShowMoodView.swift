//
//  ShowMoodView.swift
//  Moodoo2
//
//  Created by Natascha Brauchle on 4/17/18.
//  Copyright © 2018 Natascha Brauchle. All rights reserved.
//

import UIKit
import CoreData

class ShowMoodView: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    @IBOutlet weak var excitedLabel: UILabel!
    @IBOutlet weak var angryLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var reasonsMessageLabel: UILabel!
    @IBOutlet weak var reasonsLabel: UILabel!
    
    var mood: UserMood?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateLabel.text = "On \(mood!.date), you were:"
        
         // sad/joyful
         if mood!.sad == "1.0"{
             self.sadLabel.text = "very sad"
         }
         else if mood!.sad == "2.0"{
            self.sadLabel.text = "a little sad"
         }
         else if mood!.sad == "3.0"{
            self.sadLabel.text = "a little joyful"
         }
         else if mood!.sad == "4.0"{
            self.sadLabel.text = "very joyful"
         }
         
         // angry/peaceful
         if mood!.angry == "1.0"{
            self.angryLabel.text = "very angry"
         }
         else if mood!.angry == "2.0"{
            self.angryLabel.text = "a little angry"
         }
         else if mood!.angry == "3.0"{
            self.angryLabel.text = "a little peaceful"
         }
         else if mood!.angry == "4.0"{
            self.angryLabel.text = "very peaceful"
         }
         
         // anxious/confident
         if mood!.happy == "1.0"{
            self.happyLabel.text = "very anxious"
         }
         if mood!.happy == "2.0"{
            self.happyLabel.text = "a little anxious"
         }
         if mood!.happy == "3.0"{
            self.happyLabel.text = "a little confident"
         }
         if mood!.happy == "4.0"{
            self.happyLabel.text = "very confident"
         }
         
         // tired/energetic
         if mood!.excited == "1.0"{
            self.excitedLabel.text = "very tired"
         }
         if mood!.excited == "2.0"{
            self.excitedLabel.text = "a little tired"
         }
         if mood!.excited == "3.0"{
            self.excitedLabel.text = "a little energetic"
         }
         if mood!.excited == "4.0"{
            self.excitedLabel.text = "very energetic"
         }
        
        if mood!.sleep == "HIDE" {
            self.sleepLabel.text = ""
        }
        else {
            var s:String = ""
            if Int(mood!.sleep)! > 1 {
                s = "s"
            }
            
            self.sleepLabel.text = "You were on \(mood!.sleep) hour\(s) of sleep"
        }
        
        if mood!.reasons == "HIDE" {
            self.reasonsMessageLabel.text = ""
            self.reasonsLabel.text = ""
        }
        else {
            self.reasonsLabel.text = mood!.reasons
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
