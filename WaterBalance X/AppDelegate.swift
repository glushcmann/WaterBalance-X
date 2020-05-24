//
//  AppDelegate.swift
//  WaterBalance X
//
//  Created by Никита on 20.05.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let layout = UICollectionViewFlowLayout()
    
    func registerForPushNotifications() {
       UNUserNotificationCenter.current()
         .requestAuthorization(options: [.alert, .sound, .badge]) {
           [weak self] granted, error in
             
           print("Permission granted: \(granted)")
           guard granted else { return }
           self?.getNotificationSettings()
       }
     }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
        print("Notification settings: \(settings)")
        guard settings.authorizationStatus == .authorized else { return }
        DispatchQueue.main.async {
          UIApplication.shared.registerForRemoteNotifications()
        }
      }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "hasLaunched")
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if launchedBefore {
            window?.rootViewController = MainVC(collectionViewLayout: layout)
        } else {
            window?.rootViewController = UINavigationController(rootViewController: OpeningVC())
        }
       
        registerForPushNotifications()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(
      _ application: UIApplication,
      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
    ) {
      let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
      let token = tokenParts.joined()
      print("Device Token: \(token)")
    }

    func application(
      _ application: UIApplication,
      didFailToRegisterForRemoteNotificationsWithError error: Error) {
      print("Failed to register: \(error)")
    }

}

