//
//  LoginViewController.swift
//  Pizza-Order-App
//
//  Created by Katrina Aliashkevich on 10/20/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    // outlet connection for the SegmentedController variable
    @IBOutlet weak var segCtrl: UISegmentedControl!
    // outlet connection for the userField variable
    @IBOutlet weak var userField: UITextField!
    // outlet connection for the passwordField variable
    @IBOutlet weak var passwordField: UITextField!
    // outlet connection for the confirm Password label variable
    @IBOutlet weak var confirmPass: UILabel!
    // outlet connection for the confirm Password text field variable
    @IBOutlet weak var confirmText: UITextField!
    // outlet connection for the signIn Button variable
    @IBOutlet weak var signInButton: UIButton!
    // outlet connection for the signUp Button variable
    @IBOutlet weak var signUpButton: UIButton!
    // outlet connection for the status label variable
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // make the password and confirm password characters be hidden by bulletin points as user types them
        passwordField.isSecureTextEntry = true
        confirmText.isSecureTextEntry = true
        // start initial screen with confirm password label and text field hidden
        confirmPass.isHidden = true
        confirmText.isHidden = true
        // start initial screen with signUp button hidden, but signIn button showing
        signUpButton.isHidden = true
        signInButton.isHidden = false
        // Do any additional setup after loading the view.
        
        // refresh the userField and both password fields when the user logs in on signs up
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginIdentifier", sender: nil)
                self.userField.text = nil
                self.passwordField.text = nil
                self.confirmText.text = nil
            }
        }
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex{
        // case for Sign in
        case 0:
            // confirm password label and field hidden
            confirmPass.isHidden = true
            confirmText.isHidden = true
            // sign in button showing only
            signUpButton.isHidden = true
            signInButton.isHidden = false
        // case for Sign up
        case 1:
            // confirm password label and field showing
            confirmPass.isHidden = false
            confirmText.isHidden = false
            // sign up button showing only
            signInButton.isHidden = true
            signUpButton.isHidden = false
        // sign in view is the default
        default:
            confirmPass.isHidden = true
            confirmText.isHidden = true
            signUpButton.isHidden = true
            signInButton.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // function runs when signIn button is pressed
    @IBAction func signInPressed(_ sender: Any) {
        // use the userField and passwordFiled text to sign into firebase auth
        Auth.auth().signIn(withEmail: userField.text!, password: passwordField.text!) {
            (authResult, error) in
            if let error = error as NSError? {
                // if there is an error, print it in the status label
                self.statusLabel.text = "\(error.localizedDescription)"
            } else {
                // empty string in status label if no errors
                self.statusLabel.text = ""
            }
        }
    }
    
    // function runs when signUp button is pressed
    @IBAction func singUpPressed(_ sender: Any) {
        // if the password field text is the same as confirm password field text
        if passwordField.text == confirmText.text {
            // create a new user with the userField text and passwordField text for firebase auth
            Auth.auth().createUser(withEmail: userField.text!, password: passwordField.text!){
                authResult, error in
                if let error = error as NSError? {
                    // if there is an error, print it in the status label
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else {
                    // empty string in status label if no errors
                    self.statusLabel.text = ""
                }
            }
        // if both password fields dont match
        } else {
            // state the error in status label
            self.statusLabel.text = "Passwords don't match"
        }
    }
}
