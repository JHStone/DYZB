//
//  HomeViewController.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/14.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
}


//MARK:- UI
extension HomeViewController{
    fileprivate func setupNavigationBar(){
        let leftBarButton = UIButton()
        leftBarButton.setImage(UIImage(named: "logo"), for: .normal)
        leftBarButton.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        
        
        let size = CGSize(width: 40, height: 40)
         //导航栏右侧
        let qrItem = UIBarButtonItem(image: "Image_scan", highlighted: "Image_scan_click" ,size:size)
         let searchItem = UIBarButtonItem(image: "btn_search", highlighted: "btn_search_clicked" ,size:size)
         let timeItem = UIBarButtonItem(image: "image_my_history", highlighted: "Image_my_history_click" ,size:size)
         navigationItem.rightBarButtonItems = [timeItem,searchItem,qrItem ]
    }
}