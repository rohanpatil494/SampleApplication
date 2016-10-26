//
//  CustomCollectionViewCell.swift
//  SampleCollectionViewDemo
//
//  Created by Kaizan on 19/04/16.
//  Copyright © 2016 Kaizan. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var moduleIcon: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    let boundss = UIScreen.mainScreen().bounds
    //var moduleStaticRef:NSString!
    //var moduleId:NSString!//
   
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imgUser.translatesAutoresizingMaskIntoConstraints = true
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = true
        self.moduleIcon.translatesAutoresizingMaskIntoConstraints = true
        
        
        self.imgUser.frame=CGRectMake(0, 0, ((boundss.size.width/2)-10), ((boundss.size.height/3)-10))
        
        if boundss.size.width > 340
        {
            self.nameLabel.frame=CGRectMake(0, ((boundss.size.width/2)-25), ((boundss.size.width/2)-10), 40)
            self.moduleIcon.frame=CGRectMake((((boundss.size.width-20)/2)-120)/2, 30, 120, 120)
        }
        else if boundss.size.width < 330
        {
            self.nameLabel.frame=CGRectMake(0, ((boundss.size.width/2)-20), ((boundss.size.width/2)-10), 40)
            self.moduleIcon.frame=CGRectMake((((boundss.size.width-20)/2)-100)/2, 20, 100, 100)
        }
        else
        {
            
        }
        
        
         imgUser.frame = CGRectMake(0, 0, boundss.size.width, boundss.size.height)
        
        
//        imgUser.layer.shadowColor = UIColor.blackColor().CGColor
//        imgUser.layer.shadowOpacity = 0.5
//        imgUser.layer.shadowOffset = CGSizeZero
//        imgUser.layer.shadowRadius = 2
        
        
        // Initialization code
        //        imgUser.layer.cornerRadius = 6.0
        //        imgUser.clipsToBounds = true
        //        imgUser.layer.borderWidth=2.0
        //        imgUser.layer.borderColor=UIColor.whiteColor().CGColor
    }
}

