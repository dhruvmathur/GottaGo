//
//  FirstStartupPageView.swift
//  GottaGo
//
//  Created by Dhruv Mathur on 2018-08-12.
//  Copyright © 2018 Dhruv Mathur (LCL). All rights reserved.
//

import Foundation
import UIKit

class FirstStartUpPageView: UIPageViewController{
    
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
        let titlePage = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "Title")
        
        return titlePage
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        let settingsPage = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "Settings")
        
        return settingsPage
    }
}
