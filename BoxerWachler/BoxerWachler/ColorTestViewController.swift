//
//  ColorTestViewController.swift
//  BoxerWachler
//
//  Created by Tom Owen on 6/3/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit
import AVFoundation

var player: AVAudioPlayer?



class ColorTestViewController: UIViewController, UINavigationControllerDelegate {

   
    fileprivate var myarray: [String]?
     = ["0","2","3","5","6","7","8","15","16","29","45","57","73","74","42"]
    //let arr:Array! = ["0","2","3","5","6","7","8","15","16","29","45","57","73","74","42"]
    let arr: [String]? = ["0","2","3","5","6","7","8","15","16","29","45","57","73","74","42"]
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var X1: UIImageView!
    @IBOutlet weak var X2: UIImageView!
    @IBOutlet weak var X3: UIImageView!
    @IBOutlet weak var X4: UIImageView!
    @IBOutlet weak var circleNumber: UIImageView!
    @IBOutlet weak var numberSelected1: UIButton!
    @IBOutlet weak var numberSelected2: UIButton!
    @IBOutlet weak var numberSelected3: UIButton!
    @IBOutlet weak var numberSelected4: UIButton!
    var currentTestNumber = 0
    var myCircleText = ""
    var rand: Int = 0
    var trand = 0
    var totalCorrect = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        setDisplayatBeginning()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        NSLog("view appear")
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        NSLog("view did")
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
    }
    
    override func willRotate(to toInterfaceOrientation: UIInterfaceOrientation, duration: TimeInterval) {
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setDisplayatBeginning () {
        X1.image = UIImage(named: ("grey-x"))
        X2.image = UIImage(named: ("grey-x"))
        X3.image = UIImage(named: ("grey-x"))
        X4.image = UIImage(named: ("grey-x"))
        currentTestNumber = 0
        totalCorrect = 0
        setCircleNumber()
        setNumbersTobeDisplayed()
    }
    @IBAction func resetColorTest(_ sender: UIButton) {
        setDisplayatBeginning()
    
    }
    func setCircleNumber () {
        // number bewtween 0 and 13
        rand = Int(arc4random_uniform(14)) + 1
        // let randNumber = String(rand)
        // now get actual color number from array
        myCircleText =   myarray![rand]
        myCircleText = arr![rand]
        let circleImage = "color-" + myCircleText + ".jpg"
        NSLog("random number is \(rand) setting \(circleImage)")
        circleNumber.image = UIImage(named: (circleImage))
    }
    func setNumbersTobeDisplayed () {
        
        // need 3 random numbers from arr() except myCircleText (answer)
        // get first number
        var firstNumber = ""
        var secondNumber = ""
        var thirdNumber = ""
        var forthNumber = ""
        // assign rand to either first, second, third or forth
        trand = Int(arc4random_uniform(4)) + 1
        if trand == 1 { firstNumber = myCircleText }
        if trand == 2 { secondNumber = myCircleText }
        if trand == 3 { thirdNumber = myCircleText }
        if trand == 4 { forthNumber = myCircleText }
        // now go thru each and get a unique number
        var myIndex = 0
        while firstNumber == "" {
            myIndex = Int(arc4random_uniform(14)) + 1
            if arr![myIndex] != myCircleText {
                firstNumber = arr![myIndex]
            }
        }
        while secondNumber == "" {
            myIndex = Int(arc4random_uniform(14)) + 1
            if arr![myIndex] != myCircleText
                && arr![myIndex] != firstNumber
                && arr![myIndex] != thirdNumber
                && arr![myIndex] != forthNumber
            {
                secondNumber = arr![myIndex]
            }
        }
        while thirdNumber == "" {
            myIndex = Int(arc4random_uniform(14)) + 1
            if arr![myIndex] != myCircleText
                && arr![myIndex] != firstNumber
                && arr![myIndex] != secondNumber
                && arr![myIndex] != forthNumber
            {
                thirdNumber = arr![myIndex]
            }
        }
        while forthNumber == "" {
            myIndex = Int(arc4random_uniform(14)) + 1
            if arr![myIndex] != myCircleText
                && arr![myIndex] != firstNumber
                && arr![myIndex] != secondNumber
                && arr![myIndex] != thirdNumber
            {
                forthNumber = arr![myIndex]
            }
        }
        // now set the labels
        //NSLog("Numbers \(firstNumber),\(secondNumber),\(thirdNumber),\(forthNumber)")
        // need to set attributed strings since in a font and color
        let label1 = NSAttributedString(string: firstNumber,
                                                         attributes: [NSForegroundColorAttributeName : UIColor.green])
        numberSelected1.setAttributedTitle(label1, for: UIControlState())
        let label2 = NSAttributedString(string: secondNumber,
                                        attributes: [NSForegroundColorAttributeName : UIColor.green])
        numberSelected2.setAttributedTitle(label2, for: UIControlState())
        let label3 = NSAttributedString(string: thirdNumber,
                                        attributes: [NSForegroundColorAttributeName : UIColor.green])
        numberSelected3.setAttributedTitle(label3, for: UIControlState())
        let label4 = NSAttributedString(string: forthNumber,
                                        attributes: [NSForegroundColorAttributeName : UIColor.green])
        numberSelected4.setAttributedTitle(label4, for: UIControlState())
        
        
      
    }
    @IBAction func userChoseNumber(_ sender: UIButton) {
        currentTestNumber += 1
        NSLog("User chose \(sender.titleLabel!)")
        // see if user chose correctly myCircleText is displayed
        NSLog("mycircletext=" + myCircleText)
        NSLog("button=" + (sender.titleLabel?.text)!)
        if (myCircleText == sender.titleLabel?.text!) {
            NSLog("Correct")
            totalCorrect += 1
            // play correct sound
            let url = Bundle.main.url(forResource: "correct", withExtension: "mp3")!
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error as NSError {
                print(error.description)
            }
            // set check mark in appropriate X
            switch currentTestNumber {
            case 1:
                X1.image = UIImage(named: ("green-check"))
            case 2:
                X2.image = UIImage(named: ("green-check"))
            case 3:
                X3.image = UIImage(named: ("green-check"))
            case 4:
                X4.image = UIImage(named: ("green-check"))
            default:
                NSLog("invalid testnumber")
            }
        } else {
            NSLog("Incorrect")
            // play buzz
            let url = Bundle.main.url(forResource: "wrong", withExtension: "mp3")!
            
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                
                player.prepareToPlay()
                player.play()
            } catch let error as NSError {
                print(error.description)
            }
            switch currentTestNumber {
            case 1:
                X1.image = UIImage(named: ("redx"))
            case 2:
                X2.image = UIImage(named: ("redx"))
            case 3:
                X3.image = UIImage(named: ("redx"))
            case 4:
                X4.image = UIImage(named: ("redx"))
            default:
                NSLog("invalid testnumber")
        }
        }
        // display check or X and ding or buzz
        // keep count of test
        if currentTestNumber > 3 {
            displayResults()
        }
        setCircleNumber()
        setNumbersTobeDisplayed()
        // if this is 5th time reset test and popup results/contact
        
    }
    func displayResults () {
        var message1 = ""
        switch totalCorrect {
        case 0:
            message1 = "None correct! You probably are color blind."
        case 1:
            message1 = "One correct! Not too good."
        case 2:
            message1 = "Half correct! Maybe you have a color blindness condition."
        case 3:
            message1 = "Missed One! You might be ok, check with Dr Brian"
        case 4:
            message1 = "Congratulations! It appears you are quite normal when it comes to color vision."
        default:
            message1 = "Unsure of results! Contact Dr Brian for an appointment."
        }
        let attributedString = NSAttributedString(string: message1 , attributes: [
            NSFontAttributeName : UIFont.systemFont(ofSize: 18),
            NSForegroundColorAttributeName : UIColor.red
            ])
        let alertController = UIAlertController(title: "Color Test Results", message: "", preferredStyle: .alert)
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
            self.setDisplayatBeginning()
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
