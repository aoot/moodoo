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

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
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
        if self.txtEmail.text == "" || self.txtPassword.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            Auth.auth().signIn(withEmail: self.txtEmail.text!, password: self.txtPassword.text!) { (user, error) in
                if error == nil {
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    if PersistenceService.shared.getUser(name: self.txtEmail.text!).username == "<bad>" {
                        PersistenceService.shared.saveUser(username: self.txtEmail.text!, password: self.txtPassword.text!, email: self.txtEmail.text!, moodCount: 0)
                    }
                    else {
                        PersistenceService.shared.setCurrentUser(username: self.txtEmail.text!)
                    }
                    
                    if self.txtEmail.text == "anthonyylee@utexas.edu" {
                        self.demoData(); // Creates demo data
                        print("Demo data created")
                    }
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

extension LoginViewController {
    func demoData() {
        PersistenceService.shared.saveMood(angry: "2.0", happy: "2.0", excited: "4.0", sad: "4.0", sleep: "2", reasons: "Tomorrow is SB2k18", date: "March 11, 2018")
        PersistenceService.shared.saveMood(angry: "4.0", happy: "4.0", excited: "4.0", sad: "4.0", sleep: "0", reasons: "FLYING TO CABO", date: "March 12, 2018")
        PersistenceService.shared.saveMood(angry: "2.0", happy: "4.0", excited: "4.0", sad: "4.0", sleep: "0", reasons: "HIDE", date: "March 13, 2018")
        PersistenceService.shared.saveMood(angry: "1.0", happy: "4.0", excited: "4.0", sad: "4.0", sleep: "0", reasons: "Glitch mob", date: "March 14, 2018")
        PersistenceService.shared.saveMood(angry: "3.0", happy: "2.0", excited: "4.0", sad: "4.0", sleep: "0", reasons: "Penthouse party", date: "March 15, 2018")
        PersistenceService.shared.saveMood(angry: "4.0", happy: "2.0", excited: "3.0", sad: "3.0", sleep: "0", reasons: "RAVE", date: "March 16, 2018")
        PersistenceService.shared.saveMood(angry: "2.0", happy: "1.0", excited: "1.0", sad: "1.0", sleep: "0", reasons: "Last day of SB", date: "March 17, 2018")
        PersistenceService.shared.saveMood(angry: "4.0", happy: "3.0", excited: "2.0", sad: "1.0", sleep: "12", reasons: "Skipped classes, still tired!!!", date: "March 18, 2018")
    }
}
