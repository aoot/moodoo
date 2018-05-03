//
//  ForgotPasswordViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 4/10/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmail.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSendEmail(_ sender: Any) {
        Auth.auth().sendPasswordReset(withEmail: txtEmail.text!) { (error) in
            if error != nil {
                print(error!)
            }
            else {
                let alertController = UIAlertController(title: "Email Sent", message: "Please check your inbox", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                //print("No errors, email should be sent.")
            }
        }
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ForgotPasswordViewController: UITextFieldDelegate {
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
