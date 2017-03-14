//
//  PageTitleView.swift
//  DYZB
//
//  Created by 谷建华 on 17/2/14.
//  Copyright © 2017年 谷建华. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class{
    func pageTitleView(titleView : PageTitleView, selectedIndex: Int)
}

fileprivate let scrollViewLineH : CGFloat = 2

//定义长量
private let kSelectColor : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

class PageTitleView: UIView {
    
    lazy  var titleArray : [String] = [String]()
    weak var delegate : PageTitleViewDelegate?
    fileprivate lazy var titlesLabels : [UILabel] = [UILabel]()
    fileprivate var lastIndex : Int = 0
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    fileprivate lazy var scrollViewLine : UIView = {
        let scrollViewLine = UIView()
        scrollViewLine.backgroundColor = UIColor.orange
        return scrollViewLine
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
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick(tap:)))
            label.addGestureRecognizer(tapGes)
            scrollView.addSubview(label)
            
            titlesLabels.append(label)
        }

    }
    
    //设置底部线条
    private func setupBottomLineAndScrollViewLine(){
        let lineH : CGFloat = 0.5
        let bottomLine = UIView(frame: CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH))
        bottomLine.backgroundColor = UIColor.lightGray
        addSubview(bottomLine)
        
        
        //底部的orangeView
        scrollViewLine.frame = CGRect(x: 0, y: frame.height - lineH - scrollViewLineH, width: screenW / CGFloat(titleArray.count), height: scrollViewLineH)
        addSubview(scrollViewLine)
    }
    
}


//MARK:- 监听label的点击
extension PageTitleView{
   @objc  fileprivate func titleLabelClick(tap : UITapGestureRecognizer){
        //获取当前的label
      let currentLabel =  tap.view as! UILabel
        //拿到tag
        let currentTage = currentLabel.tag
        
        if currentTage == lastIndex {return}
        
        //获取之前的label
       let lastLabel = titlesLabels[lastIndex]
        
        currentLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        lastLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        currentLabel.textColor = UIColor.orange
        
        UIView.animate(withDuration: 0.25) {
            self.scrollViewLine.frame.origin.x = CGFloat(currentTage) * (self.scrollViewLine.frame.size.width)
        }
        
         lastIndex = currentTage;
    
        delegate?.pageTitleView(titleView: self, selectedIndex: currentTage)
    
    }
}

//MARK:- collectionView的滚动
extension PageTitleView{
    func setupTitleViewContentOffset(pageView: PageContentView, sourceIndex: Int, target: Int, progress: CGFloat) {
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titlesLabels[sourceIndex]
        let targetLabel = titlesLabels[target]
        
        // 2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollViewLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //颜色的变化
         let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        // 3.2.变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        
        // 3.2.变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
    }
    
}
