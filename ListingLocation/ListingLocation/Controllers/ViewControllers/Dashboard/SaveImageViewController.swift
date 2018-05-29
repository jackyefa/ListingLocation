//
//  SaveImageViewController.swift
//  ListingLocation
//
//  Created by Apple on 28/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class SaveImageViewController: BaseViewController {
    
    // MARK:- Life Cycle Methods.
    
    @IBOutlet var container_view: UIView?
    @IBOutlet var capturedImage: UIImageView?
    var screenshot_image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
    }
    
    // MARK: - Button tap actions.
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveBtnTapped(_ sender: UIButton){
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.keyWindow!.layer
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        layer.render(in:context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @IBAction func panAnnotation(sender: UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
    }
    
    // Method for storing image in photos library with error handling.
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: error.localizedDescription)
            self.present(self.alertListingLocation!, animated:true, completion:nil)
        } else {
            self.alertListingLocation = UIAlertController.alertWithTitleAndMessage(title: appTitle, message: "The property has been stored in photos.")
            self.present(self.alertListingLocation!, animated: true, completion: nil)
        }
    }
    
    // MARK: - Common methods.
    
    func configureComponentsLayout(){
        self.container_view?.layer.cornerRadius = 8
        
        if ((screenshot_image) != nil){
            self.capturedImage?.image = screenshot_image
        }
    }
    
}
