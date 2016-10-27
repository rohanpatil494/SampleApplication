//
//  DashboardViewController.swift
//  StockHolding
//
//  Created by Rohan Patil on 26/10/16.
//  Copyright © 2016 Rohan Patil. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var titleArray = ["Demat","Mutual Funds","National Pension Scheme","IPO / Bonds / FD","Gold Rush","Services"]
    var imagesArray = ["demat.png","mutual_fund.png","nps.png","ipo.png","gold_rush.png","services.png"]
    var timer = NSTimer()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        createNavigationBar()
    }
    
    func createNavigationBar(){
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.title = "SHCIL Products"
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Helvetica", size: 22)! , NSForegroundColorAttributeName:UIColor.whiteColor()]
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 64/255.0, green: 111/255.0, blue: 214/255.0, alpha: 1.0)
        
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        cell.moduleIcon.image = UIImage(named: imagesArray[indexPath.row])
        cell.moduleIcon.backgroundColor = UIColor.clearColor()
        cell.nameLabel.text = titleArray[indexPath.row]
        //
        
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath){
        //14 mar
        //let cell : CustomCollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell
        
        
        if indexPath.row == 0
        {
 //           let summaryController = self.storyboard?.instantiateViewControllerWithIdentifier("summary_view") as! SummaryViewController
//            self.navigationController?.pushViewController(summaryController, animated: true)
        }
        else if indexPath.row == 1
        {
 //           let lastTransactionController = self.storyboard?.instantiateViewControllerWithIdentifier("last_trans_view") as! LastTransactionController
 //           self.navigationController?.pushViewController(lastTransactionController, animated: true)
        }
        else if indexPath.row == 2
        {
//            self.indicator.startAnimating()
            
//            let wsm : WebserviceClass = WebserviceClass.sharedInstance
//            wsm.delegates=self
//            wsm.getReedemGift()
            
//            timer = NSTimer.scheduledTimerWithTimeInterval(9.0, target: self, selector: #selector(HomeViewController.someSelector), userInfo: nil, repeats: false)
            //timer.fire()
            
        }
        else if indexPath.row == 3
        {
            let IPOBondsFDController = self.storyboard?.instantiateViewControllerWithIdentifier("IPOBondsFD_View") as! IOPBondsFDController
            self.navigationController?.pushViewController(IPOBondsFDController, animated: true)
        }
        else
        {
//            let RedeemptionViewController = self.storyboard?.instantiateViewControllerWithIdentifier("redumption_view") as! RedumptionStatusController
//            self.navigationController?.pushViewController(RedeemptionViewController, animated: true)
        }
    }
    
}

