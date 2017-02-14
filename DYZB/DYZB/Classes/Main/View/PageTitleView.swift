//
//  PageTitleView.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/14.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

class PageTitleView: UIView {
    
    fileprivate lazy  var titleArray : [String] = [String]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    //定义元组
    fileprivate var kNormalColor: (CGFloat,CGFloat, CGFloat) = (85, 85, 85)

       init(frame: CGRect, titles: [String]) {
            super.init(frame: frame)
            titleArray = titles
            setupUI()
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}

//MARK:- UI
extension PageTitleView{
    
    fileprivate func setupUI(){
        scrollView.frame = self.bounds
        addSubview(scrollView)
        setupLabelTitle()
        setupBottomLineAndScrollViewLine()
    }
    
    
    private func setupLabelTitle(){
        //这里是创建label
        let labelW =  screenW / CGFloat(titleArray.count)
        let labelH = self.bounds.size.height
        for (index, content) in titleArray.enumerated(){
            let label = UILabel()
            label.textAlignment = .center
            label.text = content
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.frame = CGRect(x: CGFloat(index) * labelW , y: 0, width: labelW, height: labelH)
            scrollView.addSubview(label)
        }

    }
    
    //设置底部线条
    private func setupBottomLineAndScrollViewLine(){
        let lineH : CGFloat = 0.5
        let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
    }
    
}
