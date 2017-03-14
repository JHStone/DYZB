//
//  HomeViewController.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/14.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var pageTitleView : PageTitleView = {[weak self] in
        let titles = ["推荐","游戏", "娱乐","趣玩"]
        let pageTitleView = PageTitleView(frame: CGRect(x: 0, y: kNavigationH, width: screenW, height: pageTitleViewH)  , titles:  titles)
        pageTitleView.delegate = self
        return pageTitleView
        }()
    
    fileprivate lazy var  pageContentView : PageContentView = {[weak self] in
        let frame = CGRect(x: 0, y: kNavigationH + pageTitleViewH, width: screenW, height: screenH - kNavigationH - pageTitleViewH)
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(AmuseViewController())
        childVCs.append(FunnyViewController())
        let  contentView = PageContentView(frame:frame , childVCs: childVCs, parentVC: self)
        contentView.delegate = self
        return contentView
        }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupPageTitleView()
        setupPageContentView()
        automaticallyAdjustsScrollViewInsets = false
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
    
    fileprivate func  setupPageTitleView(){
        view.addSubview(self.pageTitleView)
    }
    
    fileprivate func setupPageContentView(){
        view.addSubview(self.pageContentView)
    }
}

//MARK:- PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        pageContentView.setupContentOffset(titleView: pageTitleView, selectedIndex: selectedIndex)
    }
}

//MARK:- PageContentViewDelegate
extension HomeViewController : PageContentViewDeledate{
    func pageContentView(pageView: PageContentView, sourceIndex: Int, target: Int, progress: CGFloat) {
        pageTitleView.setupTitleViewContentOffset(pageView : pageView, sourceIndex: sourceIndex, target: target, progress: progress)
    }
}
