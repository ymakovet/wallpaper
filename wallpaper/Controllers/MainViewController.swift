//
//  MainViewController.swift
//  wallpaper
//
//  Created by Yuliia MAKOVETSKAYA on 1/23/20.
//  Copyright © 2020 Yuliia MAKOVETSKAYA. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var saveButton: UIButton!

    //MARK: - Stored Properties
    
    private weak var pageVC: UIPageViewController?
    
    private var arrayImageName: [String] = ["first_wallpaper", "second_wallpaper"]
    
    private var currentPageIndex = 0
    
    private(set) lazy var orderedViewControllers: [UIViewController?] = {
        return getViewControllers()
    }()

    //MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSaveButton()
    }
    
    //MARK: - Setup UI
    
    private func setupSaveButton() {
        
        saveButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        saveButton.layer.cornerRadius = 12
        
        let attributedString = NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .regular), NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.kern : -0.41])
        
        saveButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    //MARK: - PageVC methods
    
    private func getViewControllers() -> [UIViewController?] {
        
        var arrayVC = [UIViewController?]()
        
        arrayVC = arrayImageName.compactMap { (name) -> WallViewController? in
            guard let vc = storyboard?.instantiateViewController(identifier: WallViewController.identifier) as? WallViewController else { return nil }
            vc.imageName = name
            return vc
        }
        return arrayVC
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if self.pageVC == nil, let pageVC = segue.destination as? UIPageViewController {
            guard let currentVC = orderedViewControllers.first as?
                WallViewController else { return }

            pageVC.setViewControllers([currentVC], direction: .forward, animated: false, completion: nil)
            
            pageVC.delegate = self
            pageVC.dataSource = self
            
            self.pageVC = pageVC
        }
    }
    
    //MARK: - Actions
    
    @IBAction func didTapSaveButton(_ sender: Any) {
        
        guard let wallVC = orderedViewControllers[currentPageIndex] as? WallViewController else { return }
        guard let image = wallVC.wallpaperImage else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
        
    }
    
    //MARK: - Objc func
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        
        if let error = error {
            presentAlertWith(title: "Save error", message: error.localizedDescription)
        } else {
            presentAlertWith(title: "Saved!", message: "Image has been saved to your photos.")
        }
    }
}

//MARK: - UIPageViewControllerDelegate

extension MainViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        guard let topVC = pageVC?.viewControllers?.first else { return }
        guard let topVCIndex = orderedViewControllers.firstIndex(of: topVC) else { return }
        
        currentPageIndex = topVCIndex
    }
}

//MARK: - UIPageViewControllerDataSource

extension MainViewController: UIPageViewControllerDataSource {
   
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
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
