//
//  ViewController.swift
//  Bankiii
//
//  Created by Johel Zarco on 12/04/22.
//

import UIKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    let signInButton = UIButton(type: .system)
    let errorMessageLabel = UILabel()
    // computed properties for textFields
    var username : String?{
        return loginView.userNameTextField.text
    }
    var password : String?{
        return loginView.passwordTextField.text
    }
    // define delegate as weak to avoid retain cycles
    //weak var delegate : LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    // to stop activity indicator
    override func viewDidDisappear(_ animated: Bool) {
        signInButton.configuration?.showsActivityIndicator = false
    }
}

extension LoginViewController{
    private func style(){
        loginView.translatesAutoresizingMaskIntoConstraints = false
        
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.configuration = .filled()
        signInButton.configuration?.imagePadding = 8
        signInButton.setTitle("Sign In", for: [])
        signInButton.addTarget(self, action: #selector(signInTapped), for: .primaryActionTriggered)
        
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemPink
        errorMessageLabel.numberOfLines = 0// multiline
//        errorMessageLabel.text = "Some dark magic :("
        errorMessageLabel.isHidden = true
    }
    
    private func layout(){
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        // loginView
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1).isActive = true // 1x = 8 points
        // starting from the left edge view to 'hug' loginView
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 1).isActive = true // same 8 points
        // signInButton
        signInButton.topAnchor.constraint(equalToSystemSpacingBelow: loginView.bottomAnchor, multiplier: 2).isActive = true
        signInButton.leadingAnchor.constraint(equalTo: loginView.leadingAnchor).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: loginView.trailingAnchor).isActive = true
        // errorMessageLabel
        errorMessageLabel.topAnchor.constraint(equalToSystemSpacingBelow: signInButton.bottomAnchor, multiplier: 2).isActive = true
        errorMessageLabel.leadingAnchor.constraint(equalTo: loginView.leadingAnchor).isActive = true
        errorMessageLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor).isActive = true
        
    }
}

extension LoginViewController{
    
    @objc func signInTapped(sender : UIButton){
        print("signIn Tapped!")
        errorMessageLabel.isHidden = true
        login()
    }
    
    private func login(){
        // unwrap optional with guard
        guard let username = username, let password = password else{
            // assertion only appears in debug builds, not in production
            assertionFailure("username/password should never be nil")
            return
        }
        if(username.isEmpty || password.isEmpty){
            configureView(withMessage: "username/password cannot be blank")
            return
        }
        if(username == "Felicity" && password == "johnes"){
            signInButton.configuration?.showsActivityIndicator = true
            // fire delegate when credentials are valid
            //delegate?.didLogin()
            // it will whatever is listening to delegate
        } else{
          configureView(withMessage: "Incorrect username/password")
        }
    }
    
    private func configureView(withMessage message : String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}


