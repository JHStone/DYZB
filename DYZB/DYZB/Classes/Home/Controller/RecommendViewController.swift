//
//  RecommendViewController.swift
//  DYZB
//
//  Created by gujianhua on 2017/3/13.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

fileprivate let normalItemID : String = "normalItemID"
fileprivate let prettyItemID : String = "prettyItemID"
fileprivate let headerViewID : String = "headerViewID"

fileprivate let itemSpace : CGFloat = 10

fileprivate let kHeaderViewH : CGFloat = 50;


class RecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        let itemW = (screenW - 3 * itemSpace) / 2
        let itemH = itemW / 4 * 3
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemSpace
        layout.headerReferenceSize = CGSize(width: screenW, height: kHeaderViewH)
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.autoresizingMask = [.flexibleHeight , .flexibleWidth];
        
        collection.contentInset = UIEdgeInsetsMake(0, 10, 49, 10)
        collection.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewID)
        collection.register(UINib.init(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: normalItemID)
        collection.register(UINib.init(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: prettyItemID)
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.red
        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


extension RecommendViewController{
    func setupUI(){
        view.addSubview(collectionView)
       
    }
}

extension RecommendViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell;
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: prettyItemID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: normalItemID, for: indexPath)
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewID, for: indexPath)
        return reusableView
    }
    
    
    
    
}
