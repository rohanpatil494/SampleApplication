//
//  TopScrollView.swift
//  ScrollViewController
//
//  Created by jasnig on 16/4/6.
//  Copyright © 2016年 ZeroJ. All rights reserved.
// github: https://github.com/jasnig
// 简书: http://www.jianshu.com/users/fb31a3d1ec30/latest_articles

//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.//

//

import UIKit

public class ScrollSegmentView: UIView {

    
    
    /// (style setting)
    public var segmentStyle: SegmentStyle
    
    /// closure(click title)
    public var titleBtnOnClick:((label: UILabel, index: Int) -> Void)?
    /// (click extraBtn)
    public var extraBtnOnClick: ((extraBtn: UIButton) -> Void)?
    /// self.bounds.size.width
    private var currentWidth: CGFloat = 0

    private var xGap = 5
    private var wGap: Int {
        return 2 * xGap
    }

    /// labels( save labels )
    private var labelsArray: [UILabel] = []
    private var currentIndex = 0
    private var oldIndex = 0
    private var titlesWidthArray: [CGFloat] = []
    private var titles:[String]
    
    private lazy var scrollView: UIScrollView = {
        let scrollV = UIScrollView()
        scrollV.showsHorizontalScrollIndicator = false
        scrollV.bounces = true
        scrollV.pagingEnabled = false
        scrollV.scrollsToTop = false
        return scrollV
        
    }()
    
    private lazy var scrollLine: UIView? = {[unowned self] in
        let line = UIView()
        return self.segmentStyle.showLine ? line : nil
    }()
    private lazy var coverLayer: UIView? = {[unowned self] in
        
        if !self.segmentStyle.showCover {
            return nil
        }
        let cover = UIView()
        cover.layer.cornerRadius = CGFloat(self.segmentStyle.coverCornerRadius)
        cover.layer.masksToBounds = true
        
        
        return cover
    
    }()
    
    private lazy var extraButton: UIButton? = {[unowned self] in
        if !self.segmentStyle.showExtraButton {
            return nil
        }
    
        let btn = UIButton()
        btn.addTarget(self, action: #selector(self.extraBtnOnClick(_:)), forControlEvents: .TouchUpInside)
        let imageName = self.segmentStyle.extraBtnBackgroundImageName ?? ""
        btn.setImage(UIImage(named:imageName), forState: .Normal)
        btn.backgroundColor = UIColor.whiteColor()
        btn.layer.shadowColor = UIColor.whiteColor().CGColor
        btn.layer.shadowOffset = CGSize(width: -5, height: 0)
        btn.layer.shadowOpacity = 1
        return btn
    }()
    
    
//    private lazy var rgbDelta: (deltaR: CGFloat, deltaG: CGFloat, deltaB: CGFloat) = {[unowned self] in
//        let normalColorRgb = self.normalColorRgb
//        let selectedTitleColorRgb = self.selectedTitleColorRgb
//        let deltaR = normalColorRgb.r - selectedTitleColorRgb.r
//        let deltaG = normalColorRgb.g - selectedTitleColorRgb.g
//        let deltaB = normalColorRgb.b - selectedTitleColorRgb.b
//        
//        return (deltaR: deltaR, deltaG: deltaG, deltaB: deltaB)
//    }()
    
//    private lazy var normalColorRgb: (r: CGFloat, g: CGFloat, b: CGFloat) = {
//        
//        if let normalRgb = self.getColorRGB(self.segmentStyle.normalTitleColor) {
//            return normalRgb
//        } else {
//            fatalError("设置普通状态的文字颜色时 请使用RGB空间的颜色值")
//        }
//        
//    }()
//    
//    private lazy var selectedTitleColorRgb: (r: CGFloat, g: CGFloat, b: CGFloat) =  {
//        
//        if let selectedRgb = self.getColorRGB(self.segmentStyle.selectedTitleColor) {
//            return selectedRgb
//        } else {
//            fatalError("设置选中状态的文字颜色时 请使用RGB空间的颜色值")
//        }
//        
//    }()
    
//    private func getColorRGB(color: UIColor) -> (r: CGFloat, g: CGFloat, b: CGFloat)? {
//        let colorString = String(color)
//        let colorArr = colorString.componentsSeparatedByString(" ")
//        print(colorString)
//        guard Int(colorArr[0]) != nil else {
//            return UIColor.whiteColor()
//        }
//        
//        
//        let numOfComponents = CGColorGetNumberOfComponents(color.CGColor)
//        if numOfComponents == 4 {
//            let componemts = CGColorGetComponents(color.CGColor)
////            print("\(componemts[0]) --- \(componemts[1]) ---- \(componemts[2]) --- \(componemts[3])")
//
//            return (r: componemts[0], g: componemts[1], b: componemts[2])
//
//        }
//        return nil
//        
//        
//    }
    public var backgroundImage: UIImage? = nil {
        didSet {
            // 在设置了背景图片的时候才添加imageView
            if let image = backgroundImage {
                backgroundImageView.image = image
                insertSubview(backgroundImageView, atIndex: 0)

            }
        }
    }
    private lazy var backgroundImageView: UIImageView = {[unowned self] in
        let imageView = UIImageView(frame: self.bounds)
        return imageView
    }()
    

//MARK:- life cycle
    public init(frame: CGRect, segmentStyle: SegmentStyle, titles: [String]) {
        self.segmentStyle = segmentStyle
        self.titles = titles
        super.init(frame: frame)
        if !self.segmentStyle.scrollTitle {

            self.segmentStyle.scaleTitle = !(self.segmentStyle.showCover || self.segmentStyle.showLine)
        }
        
        addSubview(scrollView)
        if let extraBtn = extraButton {
            addSubview(extraBtn)
        }
        setupTitles()
        setupUI()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func titleLabelOnClick(tapGes: UITapGestureRecognizer) {
        guard let currentLabel = tapGes.view as? CustomLabel else { return }
        currentIndex = currentLabel.tag
        
        adjustUIWhenBtnOnClickWithAnimate(true)

    }

    func extraBtnOnClick(btn: UIButton) {
        extraBtnOnClick?(extraBtn: btn)
    }

    deinit {
        print("\(self.debugDescription) --- 销毁")
    }
    

}

//MARK: - public helper
extension ScrollSegmentView {
    public func selectedIndex(selectedIndex: Int, animated: Bool) {
        assert(!(selectedIndex < 0 || selectedIndex >= titles.count), "设置的下标不合法!!")
        
        if selectedIndex < 0 || selectedIndex >= titles.count {
            return
        }
        
        currentIndex = selectedIndex
        
        //        print("\(oldIndex) ------- \(currentIndex)")
        adjustUIWhenBtnOnClickWithAnimate(animated)
    }
    
    public func reloadTitlesWithNewTitles(titles: [String]) {
        scrollView.subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        titlesWidthArray.removeAll()
        labelsArray.removeAll()
        
        self.titles = titles
        setupTitles()
        setupUI()
        // default selecte the first tag
        selectedIndex(0, animated: true)
    }
}

//MARK: - private helper
extension ScrollSegmentView {
    private func setupTitles() {
        for (index, title) in titles.enumerate() {
            
            let label = CustomLabel(frame: CGRectZero)
            label.tag = index
            label.text = title
            label.textColor = segmentStyle.normalTitleColor
            label.font = segmentStyle.titleFont
            label.textAlignment = .Center
            label.userInteractionEnabled = true
            
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelOnClick(_:)))
            label.addGestureRecognizer(tapGes)
            
            let size = (title as NSString).boundingRectWithSize(CGSizeMake(CGFloat(MAXFLOAT), 0.0), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: label.font], context: nil)
            
            titlesWidthArray.append(size.width)
            labelsArray.append(label)
            scrollView.addSubview(label)
            
            scrollView.backgroundColor = UIColor(red: 64/255.0, green: 135/255.0, blue: 202/255.0, alpha: 1.0)
        }
    }
    
    private func setupUI() {
        
        setupScrollViewAndExtraBtn()
        
        setUpLabelsPosition()
        setupScrollLineAndCover()
        
        if segmentStyle.scrollTitle {
            if let lastLabel = labelsArray.last {
                scrollView.contentSize = CGSize(width: CGRectGetMaxX(lastLabel.frame) + segmentStyle.titleMargin, height: 0)
                
            }
        }
        
    }
    
    private func setupScrollViewAndExtraBtn() {
        currentWidth = bounds.size.width
        let extraBtnW: CGFloat = 44.0
        let extraBtnY: CGFloat = 5.0
        let scrollW = extraButton == nil ? currentWidth : currentWidth - extraBtnW
        scrollView.frame = CGRect(x: 0.0, y: 0.0, width: scrollW, height: bounds.size.height)
        extraButton?.frame = CGRect(x: scrollW, y: extraBtnY, width: extraBtnW, height: bounds.size.height - 2*extraBtnY)
    }
    private func setUpLabelsPosition() {
        var titleX: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleH = bounds.size.height - segmentStyle.scrollLineHeight
        
        if !segmentStyle.scrollTitle {
            titleW = currentWidth / CGFloat(titles.count)
            
            for (index, label) in labelsArray.enumerate() {
                
                titleX = CGFloat(index) * titleW
                
                label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
                
                
            }
            
        } else {
            
            for (index, label) in labelsArray.enumerate() {
                titleW = titlesWidthArray[index]
                
                titleX = segmentStyle.titleMargin
                if index != 0 {
                    let lastLabel = labelsArray[index - 1]
                    titleX = CGRectGetMaxX(lastLabel.frame) + segmentStyle.titleMargin
                }
                label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
                
            }
            
        }
        
        if let firstLabel = labelsArray[0] as? CustomLabel {
            
            if segmentStyle.scaleTitle {
                firstLabel.currentTransformSx = segmentStyle.titleBigScale
            }
            firstLabel.textColor = segmentStyle.selectedTitleColor
        }
        
        
    }
    
    private func setupScrollLineAndCover() {
        if let line = scrollLine {
            line.backgroundColor = segmentStyle.scrollLineColor
            scrollView.addSubview(line)
            
        }
        if let cover = coverLayer {
            cover.backgroundColor = segmentStyle.coverBackgroundColor
            scrollView.insertSubview(cover, atIndex: 0)
            
        }
        let coverX = labelsArray[0].frame.origin.x
        let coverW = labelsArray[0].frame.size.width
        let coverH: CGFloat = segmentStyle.coverHeight
        let coverY = (bounds.size.height - coverH) / 2
        if segmentStyle.scrollTitle {
            coverLayer?.frame = CGRect(x: coverX - CGFloat(xGap), y: coverY, width: coverW + CGFloat(wGap), height: coverH)
        } else {
            coverLayer?.frame = CGRect(x: coverX, y: coverY, width: coverW, height: coverH)
        }
        
        scrollLine?.frame = CGRect(x: coverX, y: bounds.size.height - segmentStyle.scrollLineHeight, width: coverW, height: segmentStyle.scrollLineHeight)
        
        
    }
    

}

extension ScrollSegmentView {
    public func adjustUIWhenBtnOnClickWithAnimate(animated: Bool) {
        if currentIndex == oldIndex { return }
        
        let oldLabel = labelsArray[oldIndex] as! CustomLabel
        let currentLabel = labelsArray[currentIndex] as! CustomLabel
        
        adjustTitleOffSetToCurrentIndex(currentIndex)
        
        let animatedTime = animated ? 0.3 : 0.0
        UIView.animateWithDuration(animatedTime) {[unowned self] in
            
            oldLabel.textColor = self.segmentStyle.normalTitleColor
            currentLabel.textColor = self.segmentStyle.selectedTitleColor
            
            if self.segmentStyle.scaleTitle {
                oldLabel.currentTransformSx = self.segmentStyle.titleOriginalScale
                
                currentLabel.currentTransformSx = self.segmentStyle.titleBigScale
                
            }
            
            
            self.scrollLine?.frame.origin.x = currentLabel.frame.origin.x
            self.scrollLine?.frame.size.width = currentLabel.frame.size.width
            
            if self.segmentStyle.scrollTitle {
                self.coverLayer?.frame.origin.x = currentLabel.frame.origin.x - CGFloat(self.xGap)
                self.coverLayer?.frame.size.width = currentLabel.frame.size.width + CGFloat(self.wGap)
            } else {
                self.coverLayer?.frame.origin.x = currentLabel.frame.origin.x
                self.coverLayer?.frame.size.width = currentLabel.frame.size.width
            }
            
        }
        oldIndex = currentIndex
        
        titleBtnOnClick?(label: currentLabel, index: currentIndex)
    }
    
    public func adjustUIWithProgress(progress: CGFloat,  oldIndex: Int, currentIndex: Int) {
        self.oldIndex = currentIndex
        
        //        print("\(currentIndex)------------currentIndex")
        
        let oldLabel = labelsArray[oldIndex] as! CustomLabel
        let currentLabel = labelsArray[currentIndex] as! CustomLabel
        
        let xDistance = currentLabel.frame.origin.x - oldLabel.frame.origin.x
        let wDistance = currentLabel.frame.size.width - oldLabel.frame.size.width
        
        scrollLine?.frame.origin.x = oldLabel.frame.origin.x + xDistance * progress
        scrollLine?.frame.size.width = oldLabel.frame.size.width + wDistance * progress
        
        if segmentStyle.scrollTitle {
            coverLayer?.frame.origin.x = oldLabel.frame.origin.x + xDistance * progress - CGFloat(xGap)
            coverLayer?.frame.size.width = oldLabel.frame.size.width + wDistance * progress + CGFloat(wGap)
        } else {
            coverLayer?.frame.origin.x = oldLabel.frame.origin.x + xDistance * progress
            coverLayer?.frame.size.width = oldLabel.frame.size.width + wDistance * progress
        }
        
//        print(progress)
        if segmentStyle.gradualChangeTitleColor {
            
            oldLabel.textColor = UIColor.lightGrayColor()//(red:selectedTitleColorRgb.r + rgbDelta.deltaR * progress, green: selectedTitleColorRgb.g + rgbDelta.deltaG * progress, blue: selectedTitleColorRgb.b + rgbDelta.deltaB * progress, alpha: 1.0)
            
            currentLabel.textColor = UIColor.whiteColor()//(red: normalColorRgb.r - rgbDelta.deltaR * progress, green: normalColorRgb.g - rgbDelta.deltaG * progress, blue: normalColorRgb.b - rgbDelta.deltaB * progress, alpha: 1.0)
            
            
        }
        
        
        if !segmentStyle.scaleTitle {
            return
        }
             let deltaScale = (segmentStyle.titleBigScale - segmentStyle.titleOriginalScale)
        
        oldLabel.currentTransformSx = segmentStyle.titleBigScale - deltaScale * progress
        currentLabel.currentTransformSx = segmentStyle.titleOriginalScale + deltaScale * progress
        
        
    }
    public func adjustTitleOffSetToCurrentIndex(currentIndex: Int) {
        
        let currentLabel = labelsArray[currentIndex]
        
        labelsArray.enumerate().forEach {[unowned self] in
            if $0.index != currentIndex {
                $0.element.textColor = self.segmentStyle.normalTitleColor
            }
        }
        
        var offSetX = currentLabel.center.x - currentWidth / 2
        if offSetX < 0 {
            offSetX = 0
        }
        // considering the exist of extraButton
        let extraBtnW = extraButton?.frame.size.width ?? 0.0
        var maxOffSetX = scrollView.contentSize.width - (currentWidth - extraBtnW)
        
        if maxOffSetX < 0 {
            maxOffSetX = 0
        }
        
        if offSetX > maxOffSetX {
            offSetX = maxOffSetX
        }
        
        scrollView.setContentOffset(CGPoint(x:offSetX, y: 0), animated: true)
        
        if !segmentStyle.gradualChangeTitleColor {
            
            
            for (index, label) in labelsArray.enumerate() {
                if index == currentIndex {
                    label.textColor = segmentStyle.selectedTitleColor
                    
                } else {
                    label.textColor = segmentStyle.normalTitleColor
                    
                }
            }
        }
//        print("\(oldIndex) ------- \(currentIndex)")
        
        
    }
}




public class CustomLabel: UILabel {
    public var currentTransformSx:CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransformMakeScale(currentTransformSx, currentTransformSx)
        }
    }
}


