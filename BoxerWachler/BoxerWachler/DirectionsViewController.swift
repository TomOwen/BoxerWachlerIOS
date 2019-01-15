//
//  DirectionsViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 4/28/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit
import SystemConfiguration


class DirectionsViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var WebView: UIWebView!
    @IBAction func showDirections(_ sender: UIButton) {
        let isLive = Reachability.isConnectedToNetwork()
        if (!isLive) {
            let alert = UIAlertView(title: "No Internet Connection", message: "Sorry, Please connect to the internet!", delegate: self, cancelButtonTitle: "Ok!")
            
            alert.show()
        } else {
            WebView.delegate = self
            //
            let localfilePath = Bundle.main.url(forResource: "directions", withExtension: "html");
            let myRequest = URLRequest(url: localfilePath!);
            WebView.loadRequest(myRequest);
            //
        }

    }
    @IBAction func showStatic(_ sender: AnyObject) {
        WebView.delegate = self
        //
        let localfilePath = Bundle.main.url(forResource: "staticmap", withExtension: "html");
        let myRequest = URLRequest(url: localfilePath!);
        WebView.loadRequest(myRequest);
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.showStatic(self)
        let isLive = Reachability.isConnectedToNetwork()
        if (!isLive) {
            let alert = UIAlertView(title: "No Internet Connection", message: "Sorry, Please connect to the internet!", delegate: self, cancelButtonTitle: "Ok!")
            
            alert.show()
        } else {
            WebView.delegate = self
            //
            let localfilePath = Bundle.main.url(forResource: "directions", withExtension: "html");
            let myRequest = URLRequest(url: localfilePath!);
            WebView.loadRequest(myRequest);
            //
        }
        WebView.scrollView.bounces = false
        // check for internet availability
       
        
        let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoMenu))
        
        let rightLoadBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(self.reloadMethod))
        
        self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem,rightAddBarButtonItem], animated: true)

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
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activity.stopAnimating()
        activity.isHidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    internal class Reachability {
        class func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
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
