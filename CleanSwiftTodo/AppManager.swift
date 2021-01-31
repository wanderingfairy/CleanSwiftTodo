//
//  AppManager.swift
//  CleanSwiftTodo
//
//  Created by Panda on 2021/01/30.
//

import Foundation
import UIKit

class AppManager {
    static let shared = AppManager()
    
    let rootController: UITabBarController
    
    fileprivate struct Consts {
        static var screenWidth = UIScreen.main.bounds.width
        static var screenHeight = UIScreen.main.bounds.height
    }
    
    
    init() {
        rootController = UITabBarController()
      
      let mainVC = MainViewController()
      let mainNaviVC = UINavigationController(rootViewController: mainVC)
        
        rootController.viewControllers = [mainNaviVC]
    }
    
    func setup() {
    }
}
