//
//  VisualAcuityViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 6/15/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit
import WebKit

class VisualAcuityViewController: UIViewController, WKScriptMessageHandler, UITextFieldDelegate, UIWebViewDelegate {
    
    @IBOutlet var containerView : UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var widthOfLine: UITextField!
    @IBOutlet weak var distanceFromScreen: UITextField!
    var webView: WKWebView?
    
    var visionResults: [String] = ["20/800", "20/600", "20/400", "20/200", "20/100", "20/80", "20/60", "20/40", "20/30", "20/25", "20/20", "20/15"]
    var currentRow = 10
    
    @IBAction func testResults(_ sender: UIButton) {
        NSLog("results=\(visionResults[currentRow])")
        // popup results and link to contact us
        displayResults()
        
    }
    @IBAction func displayLetters(_ sender: AnyObject) {
        webView!.evaluateJavaScript("generateDocument(1)",
            completionHandler: nil)
    }
    func isNumeric(_ a: String) -> Bool {
        return Double(a) != nil
    }
    func passSize() {
        
        
        let mylineWidth = "passSize(1)"
        webView!.evaluateJavaScript(mylineWidth,
            completionHandler: nil)
        
        let myDistance = "passDistance(" + distanceFromScreen.text! + ")"
        webView!.evaluateJavaScript(myDistance,
            completionHandler: nil)
        
        NSLog("\(mylineWidth) and \(myDistance)")
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

    @IBAction func displayLettersNow(_ sender: UIButton) {
        // check if values are numbers
        if (!isNumeric(distanceFromScreen.text!)) {
            let refreshAlert = UIAlertController(title: "Distance from Your Screen", message: "The distance must be a valid number of feet.", preferredStyle: UIAlertControllerStyle.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                self.distanceFromScreen.becomeFirstResponder()
                
                self.distanceFromScreen.selectedTextRange = self.distanceFromScreen.textRange(from: self.distanceFromScreen.beginningOfDocument, to: self.distanceFromScreen.endOfDocument)
                self.distanceFromScreen.becomeFirstResponder()
                return
            }))
            
            present(refreshAlert, animated: true, completion: nil)
        }
        
        
        self.passSize()
        
        
        self.view.endEditing(true)
        
        let title: String = (sender.titleLabel?.text)!
        var action = 1
        NSLog("title = \(title)")
        switch title {
        case " Display Letters ": action = 1
        case " Increase Size ": action = 2; currentRow -= 1;
        case " Decrease Size ": action = 3; currentRow += 1;
        default : action = 1
        }
        if currentRow < 0 { currentRow = 0 }
        if currentRow > 11 { currentRow = 11 }
            NSLog("currentRow=\(currentRow)")
        
        
        webView!.evaluateJavaScript("generateDocument(\(action))",
            completionHandler: nil)
    }
    override func loadView() {
        super.loadView()
        NSLog("load view now")
        let contentController = WKUserContentController();
        /*
        let userScript = WKUserScript(
        source: "redHeader()",
        injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
        forMainFrameOnly: true
        )
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(
        self,
        name: "callbackHandler"
        )
        */
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height - 250
        
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        //let frame = CGRect(x: 0, y: 250, width: 800, height: 800)
        
        let frame = CGRect(x: 0, y: 200, width: screenWidth, height: screenHeight)
        
        
        self.webView = WKWebView(
            //frame: self.containerView.bounds,
            frame: frame,
            configuration: config
        )
        //self.view = self.webView!
        
        self.view.addSubview(self.webView!)
        
    }
    func reloadMethod() {
        let url = Bundle.main.url(forResource: "ivac-new", withExtension: "html")!
        //var url = NSURL(string:"http://localhost/~jornki/tests/WKDemo/")
        let req = URLRequest(url:url)
        self.webView!.load(req)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check for internet availability
        Reachability.isInternetUp()
        
        //let rightAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "Menu", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.gotoMenu))
        
        let rightLoadBarButtonItem:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.refresh, target: self, action: #selector(self.reloadMethod))
        
        //self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem,rightAddBarButtonItem], animated: true)
        self.navigationItem.setRightBarButtonItems([rightLoadBarButtonItem], animated: true)
        
        let url = Bundle.main.url(forResource: "ivac-new", withExtension: "html")!
        //var url = NSURL(string:"http://localhost/~jornki/tests/WKDemo/")
        let req = URLRequest(url:url)
        self.webView!.load(req)
        //widthOfLine.text = "1"
        distanceFromScreen.text = "10"
        //widthOfLine.keyboardType = UIKeyboardType.NumbersAndPunctuation
        distanceFromScreen.keyboardType = UIKeyboardType.numbersAndPunctuation
        
    }
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if(message.name == "callbackHandler") {
            print("JavaScript is sending a message \(message.body)")
        }
    }
    
    @IBAction func setToRed(_ sender: UIButton) {
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func displayResults () {
        var message1 = ""
        message1 = "Your last Vision result was \(visionResults[currentRow])"
        let attributedString = NSAttributedString(string: message1 , attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName : UIColor.red
            ])
        let alertController = UIAlertController(title: "Visual Acuity Test Results", message: "", preferredStyle: .alert)
        alertController.setValue(attributedString, forKey: "attributedMessage")
        // Create the alert controller
        //let alertController = UIAlertController(title: "Vision Test Results", message: "Your Vision is approximately " + eyeMessage, preferredStyle: .Alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "Contact Dr Brian", style: UIAlertActionStyle.default) {
            UIAlertAction in
            NSLog("Contact Pressed")
            self.performSegue(withIdentifier: "contactform", sender: nil)
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

}
