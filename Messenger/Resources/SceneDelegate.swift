//
//  SceneDelegate.swift
//  Messenger
//
//  Created by Binaya on 20/06/2022.
//

// So it turned out that I have to import FBSDKCoreKit instead of FacebookCore which was not mentioned in facebook's documentation. And it should be imported strictly using the .xcworkspace file which was also not mentioned in the documentation. The documentation only mentions to import FacebookCore.
import FBSDKCoreKit
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    // The iOSAcademy dude said we can skip this step but I just included it since it was in the documentation.
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            open: url,
            sourceApplication: nil,
            annotation: [UIApplication.OpenURLOptionsKey.annotation]
        )
    }

}

