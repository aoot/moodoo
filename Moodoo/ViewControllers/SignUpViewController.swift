//
//  SignUpViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/29/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtNewUsername: UITextField!    // TODO: Replace username with just email
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var txtNewEmail: UITextField!
    
    private var alertController:UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtNewUsername.delegate = self
        txtNewPassword.delegate = self
        txtConfirmPassword.delegate = self
        txtNewEmail.delegate = self
        
        self.navigationItem.title = "New Account"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnCreateAccount(_ sender: Any) {
        
        // TODO:
        // - Firebase user persistence fixed VC
        // - Forgot my password email
        // - Use email for username
        // - Verify with firebase when signing in
        // - When sign up, receive email
        
        
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
                    PersistenceService.shared.saveUser(username: txtNewUsername.text!, password: txtNewPassword.text!, email: txtNewEmail.text!, moodCount: 0)


                    
                    }
                }
            }
            }
        }



    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */








extension SignUpViewController: UITextFieldDelegate {
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
