//
//  AppDelegate.swift
//  BaseProject
//
//  Created by Techwin on 21/12/20.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import GoogleSignIn
//import FBSDKCoreKit
import FBSDKLoginKit
import Stripe

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window : UIWindow?
    
    //MARK:- DID FINISH LAUNCHING WITH OPTIONS : CALLED EVERYTIME WHEN APPLICATION LAUNCHED
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //UNABLE IQKEYBOARDMANAGER FOR WHOLE PROJECT & RESIGN THE KEYBOARD WHEN TOUCHED OUTSIDE THE KEYBOARD
        IQKeyboardManager.shared.enable = true
        
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        KeyboardStateListener.shared.start()
        //GOOGLE SIGN IN
         // GIDSignIn.sharedInstance.clientID = "328319051980-hfj8sd9c5n0e55i7aqpvq1779oemlobb.apps.googleusercontent.com" //koti 
        //CHECK FOR LOGIN
        checkForLogin()
       
        STPAPIClient.shared.publishableKey = STRIPE_KEY
        
        //Facebook
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        
        //PUT LOGIC BEFORE RETURN STATEMENT
        return true
    }
    
    //Comes with Facebook
    func application(_ app: UIApplication,open url: URL,options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(app,open: url,sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    //MARK:- CHECK FOR LOGIN
    func checkForLogin(){
        if UserDefaults.standard.bool(forKey: UD_LOGGEDIN) {
            if let window = GetWindow(), let vc = R.storyboard.home.homeViewController() {
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            window.rootViewController = nav
            window.makeKeyAndVisible()
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "BaseProject")
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

