//
//  LoginViewController.swift
//  StockHolding
//
//  Created by Vinayv on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController

{
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        //self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius=5.0
        loginBtn.layer.masksToBounds=true
        //changesrr
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //changes5
    }

}