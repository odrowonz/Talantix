//
//  AppDelegate.swift
//  InfiniteScrolling
//
//  Created by Andrey Antipov on 11.02.2021.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "InfiniteScrollingModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

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

    
    lazy var navController = UINavigationController()
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow()
        let vm = FlickrViewModel(context: persistentContainer.viewContext)
        let vc: FeedViewController
        if UIDevice.current.orientation.isLandscape {
            vc = FeedViewController(maxCountOfItemsInSection: MaxCountOfItemsInSection.horizontal.rawValue, viewmodel: vm)
        } else {
            vc = FeedViewController(maxCountOfItemsInSection: MaxCountOfItemsInSection.vertical.rawValue, viewmodel: vm)
        }
        navController.pushViewController(vc, animated: true)
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

