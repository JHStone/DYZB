//
//  JHTabBarController.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/13.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

class JHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildViewController(childControllerStoryBoard(name: "Home"))
        addChildViewController(childControllerStoryBoard(name: "Live"))
        addChildViewController(childControllerStoryBoard(name: "Follow"))
        addChildViewController(childControllerStoryBoard(name: "Profile"))
    }
    
    fileprivate func childControllerStoryBoard(name :String) -> UIViewController {
      return  UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
    }
}
