//
//  ViewController.swift
//  StockHolding
//
//  Created by Rohan Patil on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //changes5
    }

    @IBAction func DashBoardViewAction(sender: AnyObject)
    {
        let dashboardController = self.storyboard?.instantiateViewControllerWithIdentifier("Dashboard_View") as! DashboardViewController
        self.navigationController?.pushViewController(dashboardController, animated: true)
    }

}

