//
//  AppDelegate.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

// So it turned out that I have to import FBSDKCoreKit instead of FacebookCore which was not mentioned in facebook's documentation. And it should be imported strictly using the .xcworkspace file which was also not mentioned in the documentation. The documentation only mentions to import FacebookCore.
import FBSDKCoreKit
import UIKit
import FirebaseCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }
}


