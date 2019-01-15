//
//  AboutViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 4/22/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        webview.delegate = self
        /*
        let url = NSURL (string: "http://www.drwilliamgroff.com");
        let myRequest = NSURLRequest(URL: url!);
        activity.hidden = false
        webview.loadRequest(myRequest);
        */
        //
         let localfilePath = Bundle.main.url(forResource: "kerataconous", withExtension: "html");
         let myRequest = URLRequest(url: localfilePath!);
         webview.loadRequest(myRequest);
         //

        // Do any additional setup after loading the view.
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        //NSLog("start load")
        activity.isHidden = false
        activity.startAnimating()
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //NSLog("stop the spinning")
        activity.stopAnimating()
        activity.isHidden = true
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
