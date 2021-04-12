//
//  AppDelegate.swift
//  SeniorProj
//
//  Created by 2ndGen on 1/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        NotificationCenter.default.addObserver(forName:UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [self] (_) in
            removeBlurViews()
        }

        NotificationCenter.default.addObserver(forName:UIApplication.willResignActiveNotification, object: nil, queue: nil) { [self] (_) in
            addBlurViews()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
    
    
    
    
    
    // Blur on app multitask
  
   
    func applicationWillResignActive(_ application: UIApplication) {
            addBlurViews()
    }

    func applicationDidBecomeActive(_ application: UIApplication){
        removeBlurViews()
    }

}

private extension AppDelegate {
    var blurViewTag: Int {
        return 999999
    }

    func addBlurViews() {
        for window in UIApplication.shared.windows {
            let blurEffect: UIBlurEffect
            if #available(iOS 13.0, *) {
                blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
            } else {
                blurEffect = UIBlurEffect(style: .light)
            }
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = window.frame
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.tag = blurViewTag
            window.addSubview(blurEffectView)
        }
    }

    func removeBlurViews() {
        for window in UIApplication.shared.windows {
            if let blurView = window.viewWithTag(blurViewTag) {
                blurView.removeFromSuperview()
            }
        }
    }
}

