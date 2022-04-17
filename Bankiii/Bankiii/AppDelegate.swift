//
//  AppDelegate.swift
//  Bankiii
//
//  Created by Johel Zarco on 12/04/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onBoardingContainerVC = OnBoardingContainerViewController()
    let dummyVC = DummyViewController()
    
    func application(_ application : UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]?) -> Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onBoardingContainerVC.delegate = self
        dummyVC.logoutDelegate = self
//        window?.rootViewController = LoginViewController()
//        window?.rootViewController = OnBoardingContainerViewController()
        window?.rootViewController = loginViewController
//        window?.rootViewController = onBoardingContainerVC
        return true
    }

}

extension AppDelegate : LoginViewControllerDelegate{
    func didLogin() {
        print("foo - didLogin succesfull!!!")
        setRootViewController(onBoardingContainerVC)
        if LocalState.hasOnboarded{
         setRootViewController(dummyVC)
        }else{
            setRootViewController(onBoardingContainerVC)
        }
        // smothly transition into loginVC
    }
}

extension AppDelegate : OnBoardingDelegate{
    func didFinishOnBoarding() {
        LocalState.hasOnboarded = true
        print("didFinishOnBoarding succesfull!!!")
        setRootViewController(dummyVC)
    }
}

extension AppDelegate : LogoutDelegate{
    func didLogout() {
        setRootViewController(loginViewController)
    }
}

extension AppDelegate{
    func setRootViewController(_ vc : UIViewController, animated : Bool = true){
        guard animated, let window = self.window else{
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }
}
