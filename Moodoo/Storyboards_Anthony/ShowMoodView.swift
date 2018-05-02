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
    @IBOutlet weak var anxiousLabel: UILabel!
    @IBOutlet weak var angryLabel: UILabel!
    @IBOutlet weak var excitedLabel: UILabel!
    @IBOutlet weak var sadLabel: UILabel!
    @IBOutlet weak var happyLabel: UILabel!
    
    var mood: NSManagedObject? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.reasonsLabel.text = mood!.value(forKey: "reasons") as? String
        //self.excitedLabel.text = mood!.value(forKey: "excited") as? String
        //self.happyLabel.text = mood!.value(forKey: "happy") as? String
        //self.sadLabel.text = mood!.value(forKey: "sad") as? String
        //self.angryLabel.text = mood!.value(forKey: "angry") as? String
        //self.anxiousLabel.text = mood!.value(forKey: "anxious") as? String
        //self.sleepLabel.text = mood!.value(forKey: "sleep") as? String

        // Do any additional setup after loading the view.
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
