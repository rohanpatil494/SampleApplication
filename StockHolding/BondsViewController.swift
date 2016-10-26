//
//  BondsViewController.swift
//  StockHolding
//
//  Created by Rohan Patil on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit

class BondsViewController: UIViewController {
    let bounds = UIScreen.mainScreen().bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavigationBar()
        
    }
    
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "IOP / Bonds / Fix Deposit"
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 22)! , NSForegroundColorAttributeName:UIColor.whiteColor()]
        // ---- Back Button ----- //
        let btnBack = UIButton(type: UIButtonType.Custom)
        btnBack.setImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        btnBack.frame = CGRectMake(0, 0, 30, 30)
        btnBack.addTarget(self, action: #selector(BondsViewController.backView), forControlEvents: UIControlEvents.TouchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItem = customBarItem;
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 64/255.0, green: 111/255.0, blue: 214/255.0, alpha: 1.0)
    }
    
    func backView()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


