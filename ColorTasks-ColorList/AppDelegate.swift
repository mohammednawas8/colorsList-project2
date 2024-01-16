//
//  AppDelegate.swift
//  ColorTasks-ColorList
//
//  Created by mac on 04/01/2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    private struct Constants {
        static let COLORS_MODEL = "Colors"
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setUpTapBar()
        saveDefaultColors()
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

    private func setUpTapBar() {
            UIToolbar.appearance().tintColor = .white
            let appearance = UIToolbarAppearance()
            appearance.configureWithOpaqueBackground()
            UIToolbar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UIToolbar.appearance().scrollEdgeAppearance = appearance
            }
        }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.COLORS_MODEL)
        container.loadPersistentStores { NSPersistentStoreDescription, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    // when we update/add new data we add it to the context, to reflect the new data in the Database we need to save the context.
    func saveContext(backgroundContext: NSManagedObjectContext? = nil) {
        let context = backgroundContext ?? persistentContainer.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch let error as NSError {
            print("Core Data save error: \(error), \(error.userInfo)")
        }
    }
    
    func saveDefaultColors() {
        let userPreferences: UserPreferencesManager = UserPreferencesManagerImpl.getInstance()
        let shouldSaveDefaultColors = !userPreferences.readAppEntry()
        if shouldSaveDefaultColors {
            let context = persistentContainer.viewContext
            var defaultColors = [Color]()
            for colorTuple in Color.getDefaultColors() {
                let color = Color(context: context)
                color.value = colorTuple.value
                color.colorDescription = colorTuple.description
                color.name = colorTuple.name
                color.id = UUID().uuidString
                defaultColors.append(color)
                saveContext()
            }
            userPreferences.saveAppEntry()
            userPreferences.saveColorOrder(colors: defaultColors)
        }
    }
}

