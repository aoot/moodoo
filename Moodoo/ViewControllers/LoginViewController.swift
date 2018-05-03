//
//  LoginViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/29/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!    // Username input field
    @IBOutlet weak var txtPassword: UITextField!    // Password input field
    
    private var alertController:UIAlertController?
    
    override func viewWillAppear(_ animated: Bool) {
        PersistenceService.shared.fetchUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Secure text entry for password
        txtPassword.isSecureTextEntry = true
        
        txtEmail.delegate = self
        txtPassword.delegate = self
        
        assignbackground()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        /*
         Auth.auth().signIn(withEmail: txtEmail.text!, password: txtPassword.text!) { (user, error) in
         if user != nil {
         // TODO: - remove after firebase
         PersistenceService.shared.setCurrentUser(username: self.txtEmail.text!)
         // TODO: - remove segue from button into if else statement
         //                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
         print("\(user!.email!) signed in")
         } else {
         print(error!)
         }
         }
         */
        
        if self.txtEmail.text == "" || self.txtPassword.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    PersistenceService.shared.setCurrentUser(username: self.txtEmail.text!)
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "moodCapture")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}

/*
 
 if user.username == "<bad>" {
 self.alertController = UIAlertController(title: "Invalid Login", message: "Username not recognized", preferredStyle: UIAlertControllerStyle.alert)
 let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
 self.alertController!.addAction(OKAction)
 self.present(self.alertController!, animated:true, completion:nil)
 }
 else {
 if user.password != txtPassword.text {
 self.alertController = UIAlertController(title: "Invalid Login", message: "Password does not match our records", preferredStyle: UIAlertControllerStyle.alert)
 let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
 self.alertController!.addAction(OKAction)
 self.present(self.alertController!, animated:true, completion:nil)
 }
 else {
 // THEN YOU CAN FINALLY LOG IN
 PersistenceService.shared.setCurrentUser(username: txtEmail.text!)
 }
 }
 */



/*
 // MARK: - Navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
 }
 */


extension LoginViewController: UITextFieldDelegate {
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

extension LoginViewController {
    func assignbackground(){
        // Assign background
        let background = UIImage(named: "BackgroundImage.jpg")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubview(toBack: imageView)
    }
}

