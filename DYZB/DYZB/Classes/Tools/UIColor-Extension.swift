//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/14.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit


extension UIColor{
    convenience init(r : CGFloat, g: CGFloat, b: CGFloat) {
        self.init (red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
     }
}
