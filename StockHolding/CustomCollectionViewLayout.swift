//
//  CustomCollectionViewLayout.swift
//  SampleCollectionViewDemo
//
//  Created by Kaizan on 19/04/16.
//  Copyright © 2016 Kaizan. All rights reserved.
//

import UIKit

class CustomCollectionViewLayout: UICollectionViewFlowLayout {
    
    let bounds = UIScreen.mainScreen().bounds
    //  let width1 = bounds.size.width
    let itemWidth =  150
    let itemSpacing: CGFloat = 10
    var layoutInfo: [NSIndexPath:UICollectionViewLayoutAttributes] = [NSIndexPath:UICollectionViewLayoutAttributes]()
    var maxXPos: CGFloat = 0
    
    // var custcl:CustomCollectionViewCell!
    override init() {
        super.init()
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup() {
        // setting up some inherited values
        self.itemSize = CGSizeMake(((bounds.size.width/2)-10), ((bounds.size.height/3)-10))
        
        self.minimumInteritemSpacing = 5
        self.minimumLineSpacing = itemSpacing
        print(bounds.size.width)
        
        self.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5)
        
//        if bounds.size.width == 320
//        {
//            self.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5)
//        }
//        else if bounds.size.width == 375.0
//        {
//            self.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5)
//        }
//        else// if bounds.size.width == 414.0
//        {
//            self.sectionInset = UIEdgeInsetsMake(5, 5, 10, 5)
//        }
        
        //UIEdgeInsetsMake(5, 5, 5, 5);
        self.scrollDirection = UICollectionViewScrollDirection.Vertical
        
   }
}
