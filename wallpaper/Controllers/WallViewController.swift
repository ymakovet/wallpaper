//
//  ViewController.swift
//  wallpaper
//
//  Created by Yuliia MAKOVETSKAYA on 1/20/20.
//  Copyright © 2020 Yuliia MAKOVETSKAYA. All rights reserved.
//

import UIKit

final class WallViewController: UIViewController {
    
    //MARK: - Outlets

    @IBOutlet private weak var wallpaperImageView: UIImageView!
    
    var imageName = ""
    
    var wallpaperImage: UIImage? {
        wallpaperImageView.image
    }
    
    //MARK: - Lifeсycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupWallImageView()
    }
    
    //MARK: - Setup UI
    
    private func setupWallImageView() {
        wallpaperImageView.image = UIImage(named: imageName)
    }

}

