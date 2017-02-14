//
//  UIBarButtonItem-Extension.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/14.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    convenience  init(image: String, highlighted: String, size: CGSize = CGSize.zero) {
        let itemButton = UIButton()
        itemButton.setImage(UIImage(named: image), for: .normal)
        itemButton.setImage(UIImage(named: highlighted), for: .highlighted)
        
        if size == CGSize.zero {
            itemButton.sizeToFit()
        }else{
           itemButton.frame = CGRect(origin: CGPoint.zero, size: size)
        }
       
        self.init(customView : itemButton)
    }
}
