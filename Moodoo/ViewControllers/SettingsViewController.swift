//
//  SettingsViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 4/10/18.
//  Copyright © 2018 Group6. All rights reserved.
//

// TODO:
// - Find a better solution for the logout button --> tabBarController is giving a warning in the console
//  - Trying to see if present VC can work
// - Set constraints

import UIKit
import CoreData
import Firebase

class SettingsViewController: UIViewController {

    private var alertController:UIAlertController?
    var mood: UserMood?
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var moodsLoggedLabel: UILabel!
    @IBAction func logOutButton(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = true
//        let vc: LoginViewController = LoginViewController()
//        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        emailLabel.text = PersistenceService.shared.getUsername()
        moodsLoggedLabel.text = String(PersistenceService.shared.getMoodCount())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnDeleteData(_ sender:Any) {
        self.alertController = UIAlertController(title: "Are you sure?", message: "This action cannot be undone", preferredStyle: UIAlertControllerStyle.alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (action:UIAlertAction) in print("Cancel Button Pressed 1")}
        self.alertController!.addAction(cancelAction)
        let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in PersistenceService.shared.deleteAllMoods()}
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

extension SettingsViewController {
    @IBAction func btnSEndEmail(_ sender: Any) {
        // Reset password function
        Auth.auth().sendPasswordReset(withEmail: emailLabel.text!) { (error) in
            if error != nil {
                print(error!)
            } else {
                self.alertController = UIAlertController(title: "Reset Password", message: "A password reset email has been sent. Please check your email.", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
                self.alertController!.addAction(OKAction)
                print("No errors, email should be sent.")
            }
        }
    }
}
