//
//  SignUpViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/29/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtNewUsername: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewEmail: UITextField!
    
    private var alertController:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "New Account"
        
        // Hard code testing accounts
        PersistenceService.shared.saveUser(username: "tony", password: "tonypw", email: "anthonyylee@utexas.edu")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        if (txtNewUsername.text == "" || txtNewPassword.text == "" || txtConfirmPassword.text == "" || txtNewEmail.text == "") {
            self.alertController = UIAlertController(title: "Validation Error", message: "All fields are required", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated:true, completion:nil)
        }
        else {
            if txtNewPassword.text != txtConfirmPassword.text {
                self.alertController = UIAlertController(title: "Validation Error", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
                self.alertController!.addAction(OKAction)
                self.present(self.alertController!, animated:true, completion:nil)
            }
            else {
                
                let user = PersistenceService.shared.getUser(name: txtNewUsername.text!)
                
                if user.username != "<bad>" {
                    self.alertController = UIAlertController(title: "Validation Error", message: "Username taken - please try another one", preferredStyle: UIAlertControllerStyle.alert)
                    let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
                    self.alertController!.addAction(OKAction)
                    self.present(self.alertController!, animated:true, completion:nil)
                }
                else {
                    PersistenceService.shared.saveUser(username: txtNewUsername.text!, password: txtNewPassword.text!, email: txtNewEmail.text!)
                }
            }
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
