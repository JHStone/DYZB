//
//  RecommendViewController.swift
//  DYZB
//
//  Created by gujianhua on 2017/3/13.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

fileprivate var normalItemID : String = "normalItemID"

fileprivate var itemSpace : CGFloat = 10


class RecommendViewController: UIViewController {
    
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        let itemW = (screenW - 3 * itemSpace) / 2
        let itemH = itemW / 4 * 3
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemSpace
        let collection = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collection.dataSource = self
        collection.backgroundColor = UIColor.gray
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: normalItemID)
        collection.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
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
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: normalItemID, for: indexPath)
        item.backgroundColor = UIColor.red
        return item
    }
    
    
}
