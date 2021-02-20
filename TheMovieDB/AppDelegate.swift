//
//  AppDelegate.swift
//  TheMovieDB
//
//  Created by User on 20/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var navigationController: UINavigationController?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.makeKeyAndVisible()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MovieListViewController") as! MovieListViewController
        let mainVc = UINavigationController(rootViewController: vc)
        window?.rootViewController = mainVc
        return true
    }
}

