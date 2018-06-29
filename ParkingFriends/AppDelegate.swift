//
//  AppDelegate.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 3. 5..
//  Copyright © 2018년 rao. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import GooglePlaces

import Firebase
import GoogleSignIn

let googleApiKey = "AIzaSyBwqFR308aG7E02HTXsopaJmGTUbmPFMI8"
//let googleApiKey = "AIzaSyDU39SZ_T7pc_0nkKdvfvHO1LS7hxiXZQE"


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var loginList = [NSManagedObject]()
    
    
    var spinner = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    var loadingView: UIView?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        GMSPlacesClient.provideAPIKey(googleApiKey)     // For Place
        GMSServices.provideAPIKey(googleApiKey)
        
 
        FirebaseApp.configure()     // For Google Auth
        
//        GIDSignIn.sharedInstance().clientID = "com.googleusercontent.apps.675515171374-k5bqb7s78ttsjp1tvp4ec9umiqeuumph"
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
//        GIDSignIn.sharedInstance().delegate = self
 
        
        /*
        guard let LaunchVC = self.window?.rootViewController?.storyboard?.instantiateViewController(withIdentifier: "LaunchVC") as?  LaunchVC else {
            return true
        }
        
        
        self.window?.rootViewController?.addChildViewController(LaunchVC)
        self.window?.rootViewController?.view.addSubview(LaunchVC.view)
        LaunchVC.didMove(toParentViewController: self.window?.rootViewController)
        */
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    /*
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
*/
    
    /*
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            if let err = error {
                print("LoginViewController:    error = \(err)")
                return
            }
            
            // todo...
            // 넘어오는 값을 기준으로 회원가입을 진행하면 됩니다.
            print("name: \(user?.displayName)")
            print("name: \(user?.email)")
            
            
            
            
        }
        
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }
 */

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ParkingFriends")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate{
    
    func startLoading() {
        DispatchQueue.main.async{
            
            if(self.loadingView == nil){
                
                self.loadingView = UIView()
                self.loadingView?.frame = CGRect(x: 0.0, y: 0.0, width: (self.window?.bounds.width)!, height: (self.window?.bounds.height)!)
                self.loadingView?.center = (self.window?.center)!
                self.loadingView?.backgroundColor = UIColor.black
                self.loadingView?.alpha = 0.46
                self.loadingView?.clipsToBounds = true
                self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
                self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
                self.spinner.center = CGPoint(x:(self.loadingView?.bounds.size.width)! / 2, y:(self.loadingView?.bounds.size.height)! / 2)
                
                self.loadingView?.addSubview(self.spinner)
                self.window?.addSubview(self.loadingView!)
                self.spinner.startAnimating()
            }
        }
        
    }
    
    func endLoading() {
        
        DispatchQueue.main.async{
            
            guard self.loadingView != nil
                else{
                    return
            }
            
            self.spinner.stopAnimating()
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
        
    }
    
}
