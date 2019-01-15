//
//  SightTestViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 5/26/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class SightTestViewController: UIViewController {

    
   
    @IBOutlet weak var eyechart4: UIImageView!
    @IBOutlet weak var eyechart6: UIImageView!
    @IBOutlet weak var eyechart8: UIImageView!
    @IBOutlet weak var distanceLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let refreshAlert = UIAlertController(title: "Vison Test", message: "The Vision test is not a substitute for a complete eye examination by a professional.", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        /*
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        */
        
        present(refreshAlert, animated: true, completion: nil)
        eyechart4.isHidden = false
        eyechart6.isHidden = true
        eyechart8.isHidden = true
        distanceLabel.textColor = UIColor.blue
        // Do any additional setup after loading the view.
    }
    @IBAction func view4(_ sender: AnyObject) {
        eyechart4.isHidden = false
        eyechart6.isHidden = true
        eyechart8.isHidden = true
        distanceLabel.textColor = UIColor.blue
        distanceLabel.text = "Eye Chart at 4 Feet"
    }
    @IBAction func view6(_ sender: AnyObject) {
        eyechart4.isHidden = true
        eyechart6.isHidden = false
        eyechart8.isHidden = true
        distanceLabel.textColor = UIColor.red
        distanceLabel.text = "Eye Chart at 6 Feet"
    }
    @IBAction func view8(_ sender: AnyObject) {
        eyechart4.isHidden = true
        eyechart6.isHidden = true
        eyechart8.isHidden = false
        distanceLabel.textColor = UIColor.black
        distanceLabel.text = "Eye Chart at 8 Feet"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        // if an iphone then give message if landscape
        if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
            return
        }
        
        if (toInterfaceOrientation.isPortrait) {
            return
        }
        let refreshAlert = UIAlertController(title: "Portrait Mode", message: "Please take test in Portrait Mode Only", preferredStyle: UIAlertControllerStyle.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            //print("Handle Ok logic here")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
    }

    @IBAction func userChoseLine(_ sender: UIButton!) {
        NSLog("button pressed \(sender.currentTitle!)")
        // set acuity 20/20 etc 
        var eyeMessage = ""
        switch sender.currentTitle! {
        case "1": eyeMessage = "20/200"
        case "2": eyeMessage = "20/100"
        case "3": eyeMessage = "20/70"
        case "4": eyeMessage = "20/50"
        case "5": eyeMessage = "20/40"
        case "6": eyeMessage = "20/30"
        case "7": eyeMessage = "20/25"
        case "8": eyeMessage = "20/20"
        case "9": eyeMessage = "20/15"
        case "10": eyeMessage = "20/13"
        case "11": eyeMessage = "20/10"
        default:
            eyeMessage = "unknown"
        }
        // display results 
        let attributedString = NSAttributedString(string: "Your Vision is approximately " + eyeMessage, attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 25),
            NSForegroundColorAttributeName : UIColor.red
            ])
        let alertController = UIAlertController(title: "Vision Test Results", message: "", preferredStyle: .alert)
        alertController.setValue(attributedString, forKey: "attributedMessage")
        // Create the alert controller
        //let alertController = UIAlertController(title: "Vision Test Results", message: "Your Vision is approximately " + eyeMessage, preferredStyle: .Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Contact Dr Brian", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("Contact Pressed")
            self.performSegue(withIdentifier: "contactus", sender: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
