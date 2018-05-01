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
        
        Auth.auth().createUser(withEmail: txtNewEmail.text!, password: txtNewPassword.text!) { (user, error) in
            print("\(user!.email!) created")
        }
    }
}








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
