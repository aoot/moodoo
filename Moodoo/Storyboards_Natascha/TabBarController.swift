//
//  TabBarController.swift
//  Moodoo2
//
//  Created by Natascha Brauchle on 4/12/18.
//  Copyright © 2018 Natascha Brauchle. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.tabBar.isTranslucent = false
        self.createTabs()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    fileprivate func createTabs() {
        let storyboard = UIStoryboard(name: "Mood", bundle:nil)

        
        let vc1 = storyboard.instantiateViewController(withIdentifier: "moodCapture")
            as? ViewController
        let vc2 = storyboard.instantiateViewController(withIdentifier: "calendarStoryID")
            as? CalendarViewViewController
        let vc3 = storyboard.instantiateViewController(withIdentifier: "settingsID")
            as? SettingsViewController
        
        // Wrap the view controllers in their own nav controllers.
        let nc1 = UINavigationController(rootViewController: vc1!)
        let nc2 = UINavigationController(rootViewController: vc2!)
        let nc3 = UINavigationController(rootViewController: vc3!)
        
        // Get each tab's image from the Assets.xcassets (asset catalog) file.
        let captureImage = UIImage(named: "moodooCow")
        let calendarImage = UIImage(named: "calendarIcon")
        let settingsImage = UIImage(named: "settingsIcon")
        
        
        // Set each tab's item attributes.
        vc1!.tabBarItem = UITabBarItem(
            title: "Capture",
            image: captureImage,
            tag: 1)
        vc2!.tabBarItem = UITabBarItem(
            title: "Calendar",
            image: calendarImage,
            tag: 2)
        vc3!.tabBarItem = UITabBarItem(
            title: "Settings",
            image: settingsImage,
            tag: 3)
        
        
        // Create the array of controllers that make up the tab bar items.
        let controllers:[UIViewController] = [nc1, nc2, nc3]
        
        // Set the tab bar controller's array of controllers to manage.
        self.viewControllers = controllers
    }
}

extension TabBarController: UITabBarControllerDelegate {
    // Indicates which tab bar item was tapped.
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("====>>>   didSelectItem. item.tag = \(item.tag)")
    }

}
