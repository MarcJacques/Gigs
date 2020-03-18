//
//  LoginViewController.swift
//  Gigs
//
//  Created by Marc Jacques on 3/17/20.
//  Copyright © 2020 Marc Jacques. All rights reserved.
//

import UIKit

enum loginType: String {
    case signUp, login
    
    mutating func toggle() {
        switch self {
        case .signUp:
            self = .login
        case .login:
            self = .signUp
        }
    }
}

class LoginViewController: UIViewController {
//    MARK: - Properties
    
    var gigController: GigController?
    var loginType: loginType = .signUp
    
    @IBOutlet weak var signUpSignInSegmentedController: UISegmentedControl!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInSignUpSegmentControllerTapped(_ sender: UISegmentedControl) {
        
        if signUpSignInSegmentedController.selectedSegmentIndex == 0 {
            loginType = .signUp
        } else {
            loginType = .login
        }
        
        updateViews()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text,
            let password = passwordTextField.text,
            !username.isEmpty,
            !password.isEmpty else { return }
        let user = User(username: username, password: password)
        switch loginType {
        case .signUp:
            gigController?.signup(user: user, completion: { (error) in
                guard error == nil else {
                    print("Error signing up: \(error!)")
                    return
                }
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Sign Up Successful", message: "Please log in.", preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                    alertController.addAction(alertAction)
                    
                    self.present(alertController, animated: true) {
                        self.loginType = .login
                        self.updateViews()
                    }
                }
            })
        case .login:
            gigController?.login(with: user, completion: { (error) in
                guard error == nil else {
                    print("Error logging in: \(error!)")
                    return
                }
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            })
            
        }
    }
    
    func updateViews() {
        loginButton.backgroundColor = UIColor(hue: 190/360, saturation: 70/100, brightness: 80/100, alpha: 1.0)
        loginButton.tintColor = .white
        loginButton.layer.cornerRadius = 8.0
        
      
        signUpSignInSegmentedController.selectedSegmentTintColor = UIColor(hue: 190/360, saturation: 70/100, brightness: 80/100, alpha: 1.0)
//        signUpSignInSegmentedController.backgroundColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0)
        
        if signUpSignInSegmentedController.selectedSegmentIndex == 1 {
            loginType = .login
            loginButton.setTitle("Login", for: .normal)
        } else {
            loginType = .signUp
            loginButton.setTitle("Sign Up", for: .normal)
        }
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
