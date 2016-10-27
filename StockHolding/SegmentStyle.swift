//
//  SegmentStyle.swift
//  ScrollViewController
//
//  Created by jasnig on 16/4/13.
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

/// 通知使用示例
/**
 override func viewDidLoad() {
 super.viewDidLoad()
 NSNotificationCenter.defaultCenter().addObserver(self
 , selector: #selector(self.didSelectIndex(_:)), name: ScrollPageViewDidShowThePageNotification, object: nil)
 }
 
 func didSelectIndex(noti: NSNotification) {
 let userInfo = noti.userInfo!
 //注意键名是currentIndex
 print(userInfo["currentIndex"])
 }
 
 特别注意的是如果你的控制器是使用的storyBoard初始化, 务必重写这个初始化方法中注册通知监听者, 如果在viewDidLoad中注册,在第一次的时候将不会接受到通知
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.didSelectIndex(_:)), name: ScrollPageViewDidShowThePageNotification, object: nil)
 
 }
 func didSelectIndex(noti: NSNotification) {
 let userInfo = noti.userInfo!
 //注意键名是currentIndex
 print(userInfo["currentIndex"])
 }
 */
public let ScrollPageViewDidShowThePageNotification = "ScrollPageViewDidShowThePageNotification"

public struct SegmentStyle {

    public var showCover = false
    public var showLine = false
    public var scaleTitle = false
    public var scrollTitle = true
    public var gradualChangeTitleColor = false
    public var showExtraButton = false
    public var changeContentAnimated = true
    
    public var extraBtnBackgroundImageName: String?
    public var scrollLineHeight: CGFloat = 4
    public var scrollLineColor = UIColor.whiteColor()
    
    public var coverBackgroundColor = UIColor.blueColor()
    public var coverCornerRadius = 14.0
    
    public var coverHeight: CGFloat = 28.0
    public var titleMargin: CGFloat = 15
    public var titleFont = UIFont.systemFontOfSize(14.0)
    
    public var titleBigScale: CGFloat = 1.3
    let titleOriginalScale: CGFloat = 1.0
    
    public var normalTitleColor = UIColor.lightGrayColor()//(red: 51.0/255.0, green: 53.0/255.0, blue: 75/255.0, alpha: 1.0)
    public var selectedTitleColor = UIColor.whiteColor()//(red: 255.0/255.0, green: 0.0/255.0, blue: 121/255.0, alpha: 1.0)
    
    public init() {
        
    }
    
}