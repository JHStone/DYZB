//
//  PageContentView.swift
//  DYZB
//
//  Created by gujianhua on 2017/3/13.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

class PageContentView: UIView {
     init(frame: CGRect, childVCs:[UIViewController]) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
