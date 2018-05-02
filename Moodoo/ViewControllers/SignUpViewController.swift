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
        
        var iconClick: Bool!    // Used to toggle password visibility --> Implement later https://stackoverflow.com/questions/37873119/how-to-toggle-a-uitextfield-secure-text-entry-hide-password-in-swift
        
        // Set password txtfields as secure entries
        txtNewPassword.isSecureTextEntry = true
        txtConfirmPassword.isSecureTextEntry = true
        
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
        // - Update signup page design and remove username textfield
        // o Hash the password textfield in the signup page
        // - Set up password retrieval email
        // - Remove username parameter - and use email as username instead --> Michael?
        // - Setup Firebase user authentication
        //  - Then pass it to Michael to update the coredata user information
        
//        if (txtNewUsername.text == "" || txtNewPassword.text == "" || txtConfirmPassword.text == "" || txtNewEmail.text == "") {
//            self.alertController = UIAlertController(title: "Validation Error", message: "All fields are required", preferredStyle: UIAlertControllerStyle.alert)
//            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
//            self.alertController!.addAction(OKAction)
//            self.present(self.alertController!, animated:true, completion:nil)
//        }
//        else {
//            if txtNewPassword.text != txtConfirmPassword.text {
//                self.alertController = UIAlertController(title: "Validation Error", message: "Passwords do not match", preferredStyle: UIAlertControllerStyle.alert)
//                let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
//                self.alertController!.addAction(OKAction)
//                self.present(self.alertController!, animated:true, completion:nil)
//            }
//            else {
//
//                let user = PersistenceService.shared.getUser(name: txtNewUsername.text!)
//
//                if user.username != "<bad>" {
//                    self.alertController = UIAlertController(title: "Validation Error", message: "Username taken - please try another one", preferredStyle: UIAlertControllerStyle.alert)
//                    let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
//                    self.alertController!.addAction(OKAction)
//                    self.present(self.alertController!, animated:true, completion:nil)
//                }
//                else {
//                    PersistenceService.shared.saveUser(username: txtNewUsername.text!, password: txtNewPassword.text!, email: txtNewEmail.text!, moodCount: 0)
        
        Auth.auth().createUser(withEmail: txtNewEmail.text!, password: txtNewPassword.text!) { (user, error) in
            if user != nil {
                // Saving to local persistence service until firebase is fully implemented // TODO: - remove persistence after firebase
                PersistenceService.shared.saveUser(username: self.txtNewUsername.text!, password: self.txtNewPassword.text!, email: self.txtNewEmail.text!, moodCount: 0)
                
                print("\(user!.email!) created")
            } else {
                // BUG: - Alert won't show, sigabrt
                let alertController = UIAlertController(title: "Something is Wrong!", message: (error! as! String), preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "Okay", style: .cancel, handler: nil)
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
                
                print(error!)
                // Apparently if your password is too weak, it will not create the user
            }
        }
    }
}

// BUG: - Unknown class TabBarControll in IB file
// Happens after creating user and segueing into the tabBarController, maybe this is why the tabBar icons are not showing up.

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
