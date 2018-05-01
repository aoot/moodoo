//
//  ForgotPasswordViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 4/10/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtUsername.delegate = self
        txtEmail.delegate = self
        txtNewPassword.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func btnSendEmail(_ sender: Any) {
        // SEND EMAIL
        // ALERT IF SUCCESSFUL OR NOT
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        // USER ENTERS NEW PASSWORD FROM EMAIL
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
