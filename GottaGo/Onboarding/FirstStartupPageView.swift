//
//  FirstStartupPageView.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2018-08-12.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation
import UIKit

class FirstStartUpPageView: UIPageViewController {
    
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        
        let titlePage = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "Title")
        
        setViewControllers([titlePage], direction: .forward, animated: true, completion: nil)
    }
}

extension FirstStartUpPageView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentIndex == 0 {
            return nil
        }
        let titlePage = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "Title")
        currentIndex = 0
        return titlePage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentIndex == 1 {
            return nil
        }
        let settingsPage = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "Settings")
        currentIndex = 1
        return settingsPage
    }
}
