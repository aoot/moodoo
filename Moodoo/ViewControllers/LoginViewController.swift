//
//  LoginViewController.swift
//  Moodoo
//
//  Created by Michael Moscoso on 3/29/18.
//  Copyright © 2018 Group6. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var txtUsername: UITextField!    // Username input field
    @IBOutlet weak var txtPassword: UITextField!    // Password input field
    
    private var alertController:UIAlertController?
    
    override func viewWillAppear(_ animated: Bool) {
        PersistenceService.shared.fetchUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtUsername.delegate = self
        txtPassword.delegate = self
        
        assignbackground()
    }
    
    func assignbackground(){
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if txtUsername.text == "" || txtPassword.text == "" {
            self.alertController = UIAlertController(title: "Invalid Login", message: "Please enter both Username and Password", preferredStyle: UIAlertControllerStyle.alert)
            let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action:UIAlertAction) in }
            self.alertController!.addAction(OKAction)
            self.present(self.alertController!, animated:true, completion:nil)
        }
        else {
            let user = PersistenceService.shared.getUser(name: txtUsername.text!)
            
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
                    PersistenceService.shared.setCurrentUser(username: txtUsername.text!)
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    */

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
