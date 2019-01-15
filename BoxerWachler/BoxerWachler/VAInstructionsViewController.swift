//
//  VAInstructionsViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 6/16/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit

class VAInstructionsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        WebView.delegate = self
        WebView.scrollView.bounces = false
        // check for internet availability
        Reachability.isInternetUp()
        
        //let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoMenu))
        
        let rightLoadBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(self.reloadMethod))
        
        //self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem,rightAddBarButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem], animated: true)
        //
        let localfilePath = Bundle.main.url(forResource: "vainstructions", withExtension: "html");
        let myRequest = URLRequest(url: localfilePath!);
        WebView.loadRequest(myRequest);
        //
        /*
        let url = NSURL (string: "http://www.drwilliamgroff.com");
        let myRequest = NSURLRequest(URL: url!);
        WebView.loadRequest(myRequest);
        */
        // Do any additional setup after loading the view.
    }
    func reloadMethod() {
        self.WebView.reload()
    }
    func gotoMenu() {
        self.performSegue(withIdentifier: "mainmenu", sender: nil)
    }
    func webViewDidStartLoad(_ webView: UIWebView) {
        activity.isHidden = false
        activity.startAnimating()
        
    }
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        let fileUrl:String = (request.url?.lastPathComponent)!
        
        if navigationType == UIWebViewNavigationType.linkClicked {
            NSLog("clicked on=\(fileUrl)")
            if fileUrl == "begineyetest" {
                NSLog("perform seque")
                self.performSegue(withIdentifier: "begineyetest", sender: nil)
                return false
            }
            
        }
        /*
         if navigationType == UIWebViewNavigationType.LinkClicked {
         if (request.URL!.host! == "example.com"){
         return true
         } else {
         UIApplication.sharedApplication().openURL(request.URL!)
         return false
         }
         }
         */
        return true
    }

    func webViewDidFinishLoad(_ webView: UIWebView) {
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
