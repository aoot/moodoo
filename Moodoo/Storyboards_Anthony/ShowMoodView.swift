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
    
    @IBOutlet weak var reasonsLabel: UILabel!
    @IBOutlet weak var sleepLabel: UILabel!
    @IBOutlet weak var angryLabel: UILabel!
    @IBOutlet weak var excitedLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    
    var mood: NSManagedObject? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
         // sad/joyful
         if mood!.value(forKey: "sad") as? String  == "1"{
             self.reasonsLabel.text = "very sad"
         }
         if mood!.value(forKey: "sad") as? String  == "2"{
            self.reasonsLabel.text = "a little sad"
         }
         if mood!.value(forKey: "sad") as? String  == "3"{
            self.reasonsLabel.text = "a little joyful"
         }
         if mood!.value(forKey: "sad") as? String  == "4"{
            self.reasonsLabel.text = "very joyful"
         }
         
         // angry/peaceful
         if mood!.value(forKey: "angry") as? String  == "1"{
            self.reasonsLabel.text = "very angry"
         }
         if mood!.value(forKey: "angry") as? String  == "2"{
            self.reasonsLabel.text = "a little angry"
         }
         if mood!.value(forKey: "angry") as? String  == "3"{
            self.reasonsLabel.text = "a little peaceful"
         }
         if mood!.value(forKey: "angry") as? String  == "4"{
            self.reasonsLabel.text = "very peaceful"
         }
         
         // anxious/confident
         if mood!.value(forKey: "happy") as? String  == "1"{
            self.reasonsLabel.text = "very anxious"
         }
         if mood!.value(forKey: "happy") as? String  == "2"{
            self.reasonsLabel.text = "a little anxious"
         }
         if mood!.value(forKey: "happy") as? String  == "3"{
            self.reasonsLabel.text = "a little confident"
         }
         if mood!.value(forKey: "happy") as? String  == "4"{
            self.reasonsLabel.text = "very confident"
         }
         
         // tired/energetic
         
         if mood!.value(forKey: "excited") as? String  == "1"{
         self.reasonsLabel.text = "very tired"
         }
         if mood!.value(forKey: "excited") as? String  == "2"{
         self.reasonsLabel.text = "a little tired"
         }
         if mood!.value(forKey: "excited") as? String  == "3"{
         self.reasonsLabel.text = "a little energetic"
         }
         if mood!.value(forKey: "excited") as? String  == "4"{
         self.reasonsLabel.text = "very energetic"
         }
         
        // probably don't need this stuff but thought i'd go ahead and keep it
        //self.reasonsLabel.text = mood!.value(forKey: "reasons") as? String
        //self.excitedLabel.text = mood!.value(forKey: "excited") as? String
        //self.happyLabel.text = mood!.value(forKey: "happy") as? String
        //self.sadLabel.text = mood!.value(forKey: "sad") as? String
        //self.angryLabel.text = mood!.value(forKey: "angry") as? String
        //self.anxiousLabel.text = mood!.value(forKey: "anxious") as? String
        //self.sleepLabel.text = mood!.value(forKey: "sleep") as? String

        // Do any additional setup after loading the view.
    */
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
