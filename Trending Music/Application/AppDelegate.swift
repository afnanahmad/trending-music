//
//  AppDelegate.swift
//  Trending Music
//
//  Created by Afnan Ahmad on 2022-07-04.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let appDIContainer = AppDIContainer()
    var appFlowCoordinator: AppFlowCoordinator?
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        AppAppearance.setupAppearance()

        window = UIWindow(frame: UIScreen.main.bounds)

        // Used custom navigation controller to override status bar style back on top view controller
        let navigationController = TMNavigationController()

        window?.rootViewController = navigationController
        appFlowCoordinator = AppFlowCoordinator(navigationController: navigationController,
                                                appDIContainer: appDIContainer)
        appFlowCoordinator?.start()
        window?.makeKeyAndVisible()

        return true
    }
}
