//
//  LoginViewController.swift
//  StockHolding
//
//  Created by Vinayv on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    let bounds = UIScreen.mainScreen().bounds
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet var EmailField: UITextField!
    @IBOutlet var PasswordField: UITextField!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.layer.cornerRadius=5.0
        loginBtn.layer.masksToBounds=true
        addDoneButtonOnKeyboard()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        //changes5
    }

    @IBAction func SubmitLoginAction(sender: AnyObject)
    {
        let isValid = isValidEmail(EmailField.text!)
        
         if(isValid == false)
        {
            let Alert: UIAlertView = UIAlertView()
            Alert.delegate = self
            //Alert.title = "Park-a-Car"
            Alert.message = "Please enter a valid Email Address."
            Alert.addButtonWithTitle("Ok")
            Alert.show()
        }
//        else if PasswordField.text == ""
//        {
//            let Alert: UIAlertView = UIAlertView()
//            Alert.delegate = self
//            //Alert.title = "Park-a-Car"
//            Alert.message = "Please enter password"
//            Alert.addButtonWithTitle("Ok")
//            Alert.show()
//        }
        else
        {
            EmailField.resignFirstResponder()
            PasswordField.resignFirstResponder()
            let dashboardController = self.storyboard?.instantiateViewControllerWithIdentifier("Dashboard_View") as! DashboardViewController
            self.navigationController?.pushViewController(dashboardController, animated: true)
        }
        
        
    }
    @IBAction func backView(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    // -------------------------  TextField Delegate Methods -------------------- \\
    
    func textFieldDidBeginEditing(textField: UITextField){
        
        let height = bounds.size.height
        if(height <= 500.0)
        {
            UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations:
                {
                    
                    self.view.frame = CGRectMake(self.view.frame.origin.x, -100 , self.view.frame.width, self.view.frame.height)
                    
                    
                }, completion: { finished in
                    
            })
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        
        UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations:
            {
                
                self.view.frame = CGRectMake(self.view.frame.origin.x, 0 , self.view.frame.width, self.view.frame.height)
                
            }, completion: { finished in
                
        })
        textField.resignFirstResponder()
        
        return false
    }
    
    // -------------------  NumberPad For PhoneNumber Field with Tool Bar ---------------- \\
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRectMake(0, 0, self.view.frame.size.width, 40))
        doneToolbar.barStyle = UIBarStyle.Default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Next", style: UIBarButtonItemStyle.Done, target: self, action: #selector(LoginViewController.doneButtonAction))
        
        var items: [UIBarButtonItem]? = [UIBarButtonItem]()
        items?.append(flexSpace)
        items?.append(done)
        
        
        doneToolbar.setItems(items, animated: true)
        doneToolbar.sizeToFit()
        EmailField.inputAccessoryView=doneToolbar
    }
    
    func doneButtonAction()
    {
        if PasswordField.text == ""
        {
            PasswordField.becomeFirstResponder()
            
            let height = bounds.size.height
            if(height <= 500.0)
            {
                UIView.animateWithDuration(0.4, delay: 0, options: .CurveEaseOut, animations:
                    {
                        self.view.frame = CGRectMake(self.view.frame.origin.x, -70 , self.view.frame.width, self.view.frame.height)
                        
                    }, completion: { finished in
                        
                })
                
                EmailField.resignFirstResponder()
                
            }
        }
    }

    func isValidEmail(testStr:String) -> Bool
    {
        if testStr == ""
        {
            return true
        }
        else
        {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluateWithObject(testStr)
        }
        
    }

    
}