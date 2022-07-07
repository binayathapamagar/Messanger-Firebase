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
import GoogleSignIn
import FirebaseAuth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        ApplicationDelegate.shared.application(
            application,
            didFinishLaunchingWithOptions: launchOptions
        )
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    private func signGoogleUserInFirebase(with user: GIDGoogleUser) {
        guard let firstName = user.profile.givenName, let lastName = user.profile.familyName, let email = user.profile.email else {
            print("User's profile details are nil")
            return
        }
        DatabaseManager.shared.isEmailUnique(with: user.profile.email) { userEmailExists in
            if !userEmailExists {
                DatabaseManager.shared.createUser(with: ChatAppUser(firstName: firstName, lastName: lastName, email: email))
            }
        }
        guard let authentication = user.authentication else {
            print("Google user authenticaiton is nil!")
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        FirebaseAuth.Auth.auth().signIn(with: credential) { authDataResult, error in
            guard authDataResult != nil, error == nil else {
                if let error = error {
                    print("Error signing in using Google. Multi-factor authentication may be needed: \(error)")
                }
                return
            }
            print("Google Sign-In with Firebase success! ")
            NotificationCenter.default.post(name: .didCompleteGoogleSignIn, object: nil)
        }
    }
    
}

// MARK: - GIDSignInDelegate extension
extension AppDelegate: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else {
            print("Error signing in with google account: \(error!)")
            return
        }
        guard let user = user, let userProfile = user.profile else {
            print("User variable and it's profile property nil!")
            return
        }
        print("Successfully signed in with google user: \(userProfile)")
        signGoogleUserInFirebase(with: user)
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        print("Google user was disconnected.")
    }
    
}

