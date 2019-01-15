//
//  MenuTableViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 5/11/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    @IBOutlet var mytable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
        
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //NSLog("row %d",indexPath.row)
        let cell  = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = UIColor.black
        // seque to view
        /*
        if (indexPath.row == 1) {
            performSegueWithIdentifier("meetID", sender: nil)
        }
        if (indexPath.row == 2) {
            performSegueWithIdentifier("keraID", sender: nil)
        }
        if (indexPath.row == 3) {
            performSegueWithIdentifier("visianID", sender: nil)
        }
        if (indexPath.row == 4) {
            performSegueWithIdentifier("ibriteID", sender: nil)
        }
        if (indexPath.row == 5) {
            performSegueWithIdentifier("dryeyeID", sender: nil)
        }
        if (indexPath.row == 6) {
            performSegueWithIdentifier("lasikID", sender: nil)
        }
        if (indexPath.row == 7) {
            performSegueWithIdentifier("outoftownID", sender: nil)
        }
        if (indexPath.row == 8) {
            performSegueWithIdentifier("contactID", sender: nil)
        }
        if (indexPath.row == 9) {
            performSegueWithIdentifier("linksID", sender: nil)
        }
        let mycontrol =  self.navigationController!.tabBarController
        */
        //mycontrol?.selectedIndex = indexPath.row
        //let mycontrol =  self.navigationController!.tabBarController
        //mycontrol?.selectedViewController = mycontrol!.viewControllers![indexPath.row]
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
