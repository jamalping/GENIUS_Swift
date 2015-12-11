//
//  CycleScrollView.swift
//  CycleScrollView
//
//  Created by jamalping on 15/12/10.
//  Copyright © 2015年 jamalping. All rights reserved.
//

import Foundation
import UIKit

// MARK: - NSTimer
private extension NSTimer {
    func pauseTimer() {
        if !self.valid {
            return
        }
        self.fireDate = NSDate.distantFuture()
    }
    func resumeTimer() {
        if !self.valid {
            return
        }
        self.fireDate = NSDate()
    }
    func resumeTimerAfterInterval(interval:NSTimeInterval) {
        if !self.valid {
            return
        }
        self.fireDate = NSDate.init(timeIntervalSinceNow: interval)
    }
}

class CycleScrollView :UIView ,UIScrollViewDelegate {
    
    var scrollView:UIScrollView?
    var pageControl:UIPageControl!
    var animationTimer:NSTimer?
    var animationTimerInterval:NSTimeInterval = 0.0
    var tapAction:((index:Int)->Void)?
    var dataSource:[String]! {
        didSet {
            self.setDataSource(dataSource)
        }
    }
    
    init(frame: CGRect, animationTimerInterVal:NSTimeInterval, tapAction:(index:Int)->Void) {
        self.animationTimerInterval = animationTimerInterVal
        self.tapAction = tapAction
        super.init(frame: frame)
        
        self.scrollView = UIScrollView.init(frame: self.bounds)
        scrollView?.showsVerticalScrollIndicator = false
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.pagingEnabled = true
        scrollView?.delegate = self
        self.addSubview(self.scrollView!)
        
        pageControl = UIPageControl.init(frame: CGRectMake(0, self.frame.size.height-15, self.frame.size.width, 10))
        pageControl.currentPage = 0
        pageControl.userInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.init(red: 199/255.0, green: 199/255.0, blue: 199/255.0, alpha: 0.8)
        pageControl.currentPageIndicatorTintColor = UIColor.init(red: 99.0 / 255.0, green: 157.0 / 255.0, blue: 253.0 / 255.0, alpha: 1)
        self.addSubview(pageControl)
        
        self.animationTimer = NSTimer.scheduledTimerWithTimeInterval(animationTimerInterVal, target: self, selector: "animationTimerDidFire", userInfo: nil, repeats: true)
        self.animationTimer?.pauseTimer()
    }
    
    private func setDataSource(datas:[String]) {
        self.animationTimer?.resumeTimerAfterInterval(self.animationTimerInterval)
        var contentSize:CGSize? = CGSizeZero
        if datas.count > 1 {
            contentSize = CGSizeMake(self.frame.size.width * CGFloat(datas.count+2), self.frame.size.height)
            for var i:Int = 0; i < datas.count + 2; i++ {
                var str:String?
                if (i == 0) {
                    str = datas[datas.count-1]
                }else if (i == datas.count + 1) {
                    str = datas[0]
                }else{
                    str = datas[i-1]
                }
                let imageView = UIImageView.init(image: UIImage.init(named: str!))
                imageView.frame = CGRectMake(self.frame.size.width*CGFloat(i), 0, self.frame.size.width, self.frame.size.height)
                self.scrollView?.addSubview(imageView)
                imageView.userInteractionEnabled = true
                
                let tap:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "tapAction:")
                imageView.addGestureRecognizer(tap)
                
                let label = UILabel.init(frame: imageView.bounds)
                label.text = str
                imageView.addSubview(label)
            }
        }else {
            contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height)
        }
        self.scrollView?.contentSize = contentSize!
        
        pageControl.numberOfPages = datas.count
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:UIScrollView-Delegate
extension CycleScrollView {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x < scrollView.frame.size.width {
           scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width * CGFloat(self.dataSource.count + 1), 0), animated: false)
        }
        if (scrollView.contentOffset.x > scrollView.frame.size.width * CGFloat(self.dataSource.count + 1)) {
            scrollView.setContentOffset(CGPointMake(scrollView.frame.size.width, 0), animated: false)
        }
        var pageCount = Int(scrollView.contentOffset.x / self.frame.size.width)
        if (pageCount > self.dataSource.count) {
            pageCount = 0;
        }else if (pageCount == 0){
            pageCount = self.dataSource.count - 1;
        }else{
            pageCount--
        }
        self.pageControl.currentPage = pageCount;
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.animationTimer?.pauseTimer()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        self.animationTimer?.resumeTimerAfterInterval(self.animationTimerInterval)
    }
}

// MARK:CycleScrollView Private Method
extension CycleScrollView {
    func tapAction(tap:UITapGestureRecognizer) {
        print(self.pageControl.currentPage)
        if self.tapAction != nil {
            self.tapAction!(index: self.pageControl.currentPage)
        }
    }
    
    func animationTimerDidFire() {
        let newOffset = CGPointMake(self.scrollView!.contentOffset.x + self.scrollView!.frame.size.width, self.scrollView!.contentOffset.y)
        self.scrollView?.contentOffset = newOffset
    }
}


