//
//  GeneralPageViewController.swift
//  wallpaper
//
//  Created by Yuliia MAKOVETSKAYA on 1/21/20.
//  Copyright © 2020 Yuliia MAKOVETSKAYA. All rights reserved.
//

import UIKit

final class GeneralPageViewController: UIPageViewController {

    private var arrayImageName: [String] = ["first_wallpaper", "second_wallpaper"]
    
    private(set) lazy var orderedViewControllers: [UIViewController?] = {
        return getViewControllers()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        
        if let firstViewControler = orderedViewControllers.first as?
            WallViewController {
            setViewControllers([firstViewControler], direction: .forward, animated: true, completion: nil)
        }
    }
    
    private func getViewControllers() -> [UIViewController?] {
        
        var arrayVC = [UIViewController?]()
        
        for name in arrayImageName {
            guard let vc = storyboard?.instantiateViewController(identifier: "wallViewController") as? WallViewController else { continue }
            vc.imageName = name
            arrayVC.append(vc)
        }
        return arrayVC
    }
    
}

extension GeneralPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
