//
//  ViewController.swift
//  StockHolding
//
//  Created by Rohan Patil on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit
import CoreMedia
import MediaPlayer
class ViewController: UIViewController {
    var moviePlayer : MPMoviePlayerController!
    
    @IBOutlet var backView: UIView!
    
    @IBOutlet var logInButton: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
        
        backView.backgroundColor = UIColor.clearColor()
        
        if let path = NSBundle.mainBundle().pathForResource("video", ofType: "mov") {
            let url = NSURL(fileURLWithPath: path)
            moviePlayer = MPMoviePlayerController(contentURL: url)
        }
        else {
            print("Oops, something wrong when playing video.mp4")
        }
        
        moviePlayer.movieSourceType = MPMovieSourceType.File
        moviePlayer.view.frame = self.view.bounds
        moviePlayer.scalingMode = MPMovieScalingMode.None
        moviePlayer.controlStyle = MPMovieControlStyle.None
        moviePlayer.shouldAutoplay = true
        moviePlayer.view.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(moviePlayer.view)
        self.view.sendSubviewToBack(moviePlayer.view)
        
        moviePlayer.prepareToPlay()
        moviePlayer.play()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.playerPlaybackDidFinish(_:)),
                                                         name: MPMoviePlayerPlaybackDidFinishNotification, object: nil)
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.logInButton.layer.borderWidth = 1
        self.logInButton.layer.borderColor = UIColor(red:186/255.0, green:182/255.0, blue:183/255.0, alpha: 1.0).CGColor
        self.logInButton.layer.cornerRadius = 6
        
        
        // Do any additional setup after loading the view.
       /// self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        
        //       NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotated", name: UIDeviceOrientationDidChangeNotification, object: nil)
        
       // NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "updatePlaybackTime:", userInfo: nil, repeats: true)
        //
        
       // NSNotificationCenter.defaultCenter() .addObserver(self, selector: "movieOrientationChanged", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
        
    
    func playerPlaybackDidFinish(notification:NSNotification)
    {
        //NSNotificationCenter.defaultCenter().removeObserver(self)
        moviePlayer.prepareToPlay()
        moviePlayer.play()
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

    @IBAction func LogInViewAction(sender: AnyObject)
    {
        let loginController = self.storyboard?.instantiateViewControllerWithIdentifier("Login_View") as! LoginViewController
        self.navigationController?.pushViewController(loginController, animated: true)
    }
}

