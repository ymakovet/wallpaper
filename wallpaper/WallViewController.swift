//
//  ViewController.swift
//  wallpaper
//
//  Created by Yuliia MAKOVETSKAYA on 1/20/20.
//  Copyright © 2020 Yuliia MAKOVETSKAYA. All rights reserved.
//

import UIKit

final class WallViewController: UIViewController {

    @IBOutlet weak var wallpaperImageView: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    
    var imageName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateWallImageView()
        updateSaveButton()
    }
    
    private func updateWallImageView() {
        
        if let wallImage = UIImage(named: imageName) {
            wallpaperImageView.image = wallImage
        }
    }
    
    private func updateSaveButton() {
        
        saveButton.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        saveButton.layer.cornerRadius = 12
        
        let attributedString = NSAttributedString(string: "Save", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17, weight: .regular) as Any, NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.kern : -0.41])
        
        saveButton.setAttributedTitle(attributedString, for: .normal)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        guard let image = wallpaperImageView.image else { return }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let ac = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Saved!", message: "Image has been saved to your photos.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }

}

