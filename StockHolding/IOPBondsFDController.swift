//
//  IOPBondsFDController.swift
//  StockHolding
//
//  Created by Rohan Patil on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit

class IOPBondsFDController: UIViewController {
    let bounds = UIScreen.mainScreen().bounds
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNavigationBar()
        // This is the necessary settings
        automaticallyAdjustsScrollViewInsets = false
        
        var style = SegmentStyle()
        style.showLine = true
        style.gradualChangeTitleColor = true
        style.scrollLineColor = UIColor.whiteColor()
        
        let titles = setChildVcs().map { $0.title! }
        
        let scroll = ScrollPageView(frame: CGRect(x: 0, y: 64, width: view.bounds.size.width, height: view.bounds.size.height - 64), segmentStyle: style, titles: titles, childVcs: setChildVcs(), parentViewController: self)
        view.addSubview(scroll)//
    }
    
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "IOP / Bonds / Fix Deposit"
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 22)! , NSForegroundColorAttributeName:UIColor.whiteColor()]
        // ---- Back Button ----- //
        let btnBack = UIButton(type: UIButtonType.Custom)
        btnBack.setImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        btnBack.frame = CGRectMake(0, 0, 30, 30)
        btnBack.addTarget(self, action: #selector(IOPBondsFDController.backView), forControlEvents: UIControlEvents.TouchUpInside)
        let customBarItem = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItem = customBarItem;
        
        let bar:UINavigationBar! =  self.navigationController?.navigationBar
        bar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        bar.shadowImage = UIImage()
        bar.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        
    }
    
    func backView()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func setChildVcs() -> [UIViewController] {
        
        let IPO = storyboard!.instantiateViewControllerWithIdentifier("IPO_View")
        let Bonds = storyboard!.instantiateViewControllerWithIdentifier("Bonds_View")
        let FD = storyboard!.instantiateViewControllerWithIdentifier("FD_View")
        
        if bounds.size.width == 414
        {
            IPO.title   =  "IPO                      "
            Bonds.title =  "Bonds                    "
            FD.title =     "Fix Deposit              "
        }
        else if bounds.size.width == 375
        {
            IPO.title    = "IPO                   "
            Bonds.title =  "Bonds                 "
            FD.title =     "Fix Deposit           "
        }
        else
        {
            IPO.title    = "IPO              "
            Bonds.title =  "Bonds            "
            FD.title =     "Fix Deposit      "
        }
        
        return [IPO, Bonds,FD]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

