 //
//  AppDelegate.swift
//  BoxerWachler
//
//  Created by Tom Owen on 4/18/16.
//  Copyright © 2016 Boxer Wachler Vision Institute. All rights reserved.
//

import UIKit



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //GMSServices.provideAPIKey("AizaSyB3Kg6eP21-KLu1mSagg3tqFsF0E0hRY20")
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.init(red: 14/255.0, green: 45/255.0, blue: 76/255.0, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.orange
        // do not allow user to move icons because it will break the main menu viewcontroller
        let tabBarController = window?.rootViewController as? UITabBarController
        tabBarController!.customizableViewControllers = nil
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = UIColor.init(red: 14/255.0, green: 45/255.0, blue: 76/255.0, alpha: 1.0)
        //UINavigationBar.appearance().tintColor = UIColor.orangeColor()
        UINavigationBar.appearance().barStyle = UIBarStyle.black
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orange]
        /*
        self.navigationController!.navigationBar.barTintColor = UIColor.init(red: 14/255.0, green: 45/255.0, blue: 76/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.orangeColor()]
        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        */
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

