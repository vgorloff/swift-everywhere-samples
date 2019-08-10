//
//  AppDelegate.swift
//  hello-application
//
//  Created by Vlad Gorlov on 09.08.19.
//  Copyright © 2019 WaveLabs. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {

   private lazy var mainWindow = UIWindow(frame: UIScreen.main.bounds)
   private lazy var viewController = ViewController()

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      mainWindow.rootViewController = viewController
      mainWindow.backgroundColor = .white
      mainWindow.makeKeyAndVisible()
      return true
   }
}
