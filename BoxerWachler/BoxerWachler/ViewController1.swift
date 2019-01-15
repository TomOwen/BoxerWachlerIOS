//
//  ViewController1.swift
//  BoxerWachler
//
//  Created by Tom Owen on 4/20/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    @IBOutlet weak var eyechartView: HomepageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //NSLog("here in 1")
       // eyechartView.addEyechartAnimation()       // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        eyechartView.addEyechartAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
