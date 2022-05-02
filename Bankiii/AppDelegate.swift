//
//  AppDelegate.swift
//  Bankiii
//
//  Created by Johel Zarco on 12/04/22.
//

import UIKit

let appColor : UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let loginViewController = LoginViewController()
    let onBoardingContainerVC = OnBoardingContainerViewController()
//    let dummyVC = DummyViewController()
    let mainVC = MainViewController()
    
    func application(_ application : UIApplication, didFinishLaunchingWithOptions launchOptions : [UIApplication.LaunchOptionsKey : Any]?) -> Bool{
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onBoardingContainerVC.delegate = self

//        window?.rootViewController = LoginViewController()
        let vc = mainVC
        vc.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
        
        window?.rootViewController = vc
        
        return true
    }

}

extension AppDelegate : LoginViewControllerDelegate{
    func didLogin() {
        print("foo - didLogin succesfull!!!")
        setRootViewController(onBoardingContainerVC)
        if LocalState.hasOnboarded{
         setRootViewController(mainVC)
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
        setRootViewController(mainVC)
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
