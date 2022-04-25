//
//  UIViewController+Utils.swift
//  Bankiii
//
//  Created by Johel Zarco on 22/04/22.
//

import Foundation
import UIKit

// helper methods to set status bar

extension UIViewController{
    
    func setStatusBar(){
        
        let statusBarSize = UIApplication.shared.statusBarFrame.size // deprecated ???
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBarView = UIView(frame: frame)
        
        statusBarView.backgroundColor = appColor
        view.addSubview(statusBarView)
    }
    
    func setTabBarImage(imageName : String, title : String){
        
        let configuration = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
}
