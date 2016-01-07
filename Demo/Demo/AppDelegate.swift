//
//  AppDelegate.swift
//  Demo
//
//  Created by CHEN Xian’an on 1/7/16.
//  Copyright © 2016 lazyapps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)
    window?.rootViewController = ViewController()
    window?.makeKeyAndVisible()
    return true
  }

}

