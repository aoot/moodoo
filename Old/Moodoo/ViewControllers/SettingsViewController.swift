//
//  SettingsViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 4/10/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit

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
    
    
    
    @IBAction func btnDeleteData(_ sender: Any) {
        self.alertController = UIAlertController(title: "Are you sure?", message: "This action cannot be undone", preferredStyle: UIAlertControllerStyle.alert)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
        self.alertController!.addAction(OKAction)
        self.present(self.alertController!, animated:true, completion:nil)
    }
    
    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
