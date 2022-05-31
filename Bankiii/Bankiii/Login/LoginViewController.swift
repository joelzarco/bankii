//
//  ViewController.swift
//  Bankiii
//
//  Created by Johel Zarco on 12/04/22.
//

import UIKit

protocol LogoutDelegate : AnyObject{
    func didLogout()
}

protocol LoginViewControllerDelegate : AnyObject{
    // LoginViewControllerDelegate is THE protocol name, even it's confusing
    func didLogin()
}

class LoginViewController: UIViewController {
    
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
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
    var leadingEdgeOnScreen : CGFloat = 50
    var leadingEdgeOffScreen : CGFloat = -1000
    // variable constraints for animation
    var titleLeadingAnchor : NSLayoutConstraint?
    var subtitleLeadingAnchor : NSLayoutConstraint?
    // define delegate as weak to avoid retain cycles
    weak var delegate : LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    // to stop activity indicator
    override func viewDidDisappear(_ animated: Bool) {
        signInButton.configuration?.showsActivityIndicator = false
    }
    // animate Title & subtitle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animate()
    }
}

extension LoginViewController{
    private func style(){
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "BanKiii"
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.alpha = 0
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.text = "Your anonymous source for all things crypto"
        subtitleLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        subtitleLabel.adjustsFontForContentSizeCategory = true
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        
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
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(loginView)
        view.addSubview(signInButton)
        view.addSubview(errorMessageLabel)
        // title
        // grab title's leading anchor as NSLyoutConstraint in order to animate
        titleLabel.trailingAnchor.constraint(equalTo: loginView.trailingAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: loginView.topAnchor, constant: -150).isActive = true
        titleLeadingAnchor = titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        titleLeadingAnchor?.isActive = true
        // subtitle
        subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 3).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        subtitleLeadingAnchor = subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: leadingEdgeOffScreen)
        subtitleLeadingAnchor?.isActive = true
        // loginView
        loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loginView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 2).isActive = true // 1x = 8 points
        view.trailingAnchor.constraint(equalToSystemSpacingAfter: loginView.trailingAnchor, multiplier: 2).isActive = true // same 8 points
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
            // fire delegate only when credentials are valid
            delegate?.didLogin()
            // it will call whatever is listening to delegate
        } else{
          configureView(withMessage: "Incorrect username/password")
        }
    }
    
    private func configureView(withMessage message : String){
        errorMessageLabel.isHidden = false
        errorMessageLabel.text = message
    }
    
}

extension LoginViewController{
    
    private func animate(){
        let animator1 = UIViewPropertyAnimator(duration: 2, curve: .easeInOut){
            self.titleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator1.startAnimation()

        let animator2 = UIViewPropertyAnimator(duration: 1, curve: .easeInOut){
            self.subtitleLeadingAnchor?.constant = self.leadingEdgeOnScreen
            self.view.layoutIfNeeded()
        }
        animator2.startAnimation(afterDelay: 0.2)
        
        let animator3 = UIViewPropertyAnimator(duration: 4, curve: .easeInOut){
            self.titleLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
        animator3.startAnimation(afterDelay: 0.5)
    }
    
}

