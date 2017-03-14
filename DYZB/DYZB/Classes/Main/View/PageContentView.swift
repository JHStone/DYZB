//
//  PageContentView.swift
//  DYZB
//
//  Created by gujianhua on 2017/3/13.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

//protocol PageContentViewDeledate : class {
//    func  pageContentView(pageView : PageContentView, )
//}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    fileprivate var childVCs : [UIViewController]?
    fileprivate var originalX : CGFloat = 0
    fileprivate var parentController : HomeViewController?
    fileprivate lazy var collectionView :UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        layout.itemSize = (self?.bounds.size)!
        
        let collection = UICollectionView(frame: CGRect.zero , collectionViewLayout: layout)
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collection.backgroundColor = UIColor.white
        collection.dataSource = self
        collection.delegate  = self
        collection.isPagingEnabled = true
        return collection
    }()
    
    init(frame: CGRect, childVCs:[UIViewController], parentVC: HomeViewController?) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blue
        self.childVCs = childVCs
        self.parentController = parentVC
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



extension  PageContentView{
    fileprivate func setupUI(){
       //将控制器加入控制器中
        for controller in childVCs! {
            parentController?.addChildViewController(controller)
        }
       addSubview(collectionView)
       collectionView.frame = self.bounds
    }
}

extension  PageContentView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return  (self.childVCs?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //首先移除, 再次添加
        for view in collectionViewCell.subviews {
            view.removeFromSuperview()
        }
        //拿到控制器的view添加
        let childVC = childVCs?[indexPath.item]
        let childView = childVC?.view
        childView?.backgroundColor = UIColor(r:CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
        childView?.frame = self.bounds
        collectionViewCell.addSubview(childView!)
        
        return collectionViewCell
    }
}


extension PageContentView: UICollectionViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //起始点
        originalX = collectionView.contentOffset.x
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        var sourceIndex = 0
        var targetIndex = 0
        var progress : CGFloat = 0
        let currentX = collectionView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        //判断左滑还是右滑
        if currentX > originalX {//左滑
            sourceIndex = Int(currentX / scrollViewW)
            targetIndex = sourceIndex + 1
            let floatSource = CGFloat(sourceIndex)
            progress = (currentX - floatSource * scrollViewW) / scrollViewW
            
            if currentX - originalX == scrollViewW{
                progress = 1
                sourceIndex = targetIndex
            }
            
            if sourceIndex > (childVCs?.count)! - 1{
                sourceIndex = (childVCs?.count)! - 1
            }
            print(progress)
        }else{//右滑
            
        }
        
        
    }
}

//MARK:- titleViewDelegate
extension  PageContentView : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex: Int) {
        let  offSet = (CGFloat(selectedIndex)) * screenW
        collectionView.setContentOffset(CGPoint(x: offSet, y: 0), animated: false)
    }
    
    
}
