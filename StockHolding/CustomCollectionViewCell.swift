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
        
        if boundss.size.width == 375
        {
            self.imgUser.frame = CGRectMake(-0.2, 0, 188, 204)
            self.nameLabel.frame=CGRectMake(0, ((boundss.size.width/2)-35), ((boundss.size.width/2)-10), 40)
            self.moduleIcon.frame=CGRectMake((((boundss.size.width-10)/2)-110)/2, 30, 110, 110)
        }
        else if boundss.size.height == 568
        {
            self.imgUser.frame = CGRectMake(0, 0, 160, 170)
            self.nameLabel.frame=CGRectMake(0, ((boundss.size.width/2)-40), ((boundss.size.width/2)-10), 40)
            self.moduleIcon.frame=CGRectMake((((boundss.size.width-20)/2)-95)/2, 20, 95, 95)
        }
        else if boundss.size.width == 414
        {
            self.imgUser.frame = CGRectMake(0, 0, 207.2, 225)
            self.nameLabel.frame=CGRectMake(0, ((boundss.size.width/2)-35), ((boundss.size.width/2)-10), 40)
            self.moduleIcon.frame=CGRectMake((((boundss.size.width-20)/2)-120)/2, 30, 120, 120)
        }
        else if boundss.size.height == 480
        {
            self.imgUser.frame = CGRectMake(0, 0, 160, 150)
            self.nameLabel.frame=CGRectMake(0, ((boundss.size.width/2)-55), ((boundss.size.width/2)-10), 40)
            self.moduleIcon.frame=CGRectMake((((boundss.size.width-20)/2)-75)/2, 20, 75, 75)
        }
        
        imgUser.backgroundColor = UIColor.whiteColor()
        imgUser.layer.borderColor = UIColor.lightGrayColor().CGColor
        
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
