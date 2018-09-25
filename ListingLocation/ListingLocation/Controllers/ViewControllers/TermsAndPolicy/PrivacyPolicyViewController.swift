//
//  PrivacyPolicyViewController.swift
//  ListingLocation
//
//  Created by Apple on 10/09/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

class PrivacyPolicyViewController: BaseViewController {
    
    @IBOutlet var bg_view: UIView?
    @IBOutlet var webView: UIWebView?
    
    // MARK:- Life Cycle Methods.

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configureComponentsLayout()
        self.setupWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:- Button tap actions
    
    @IBAction func cancelBtnTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- Common Methods
    
    func setupWebView(){
        self.webView?.delegate = self
        let url = URL (string: "http://www.mylistinglocation.com/private-policy")
        let requestObj = URLRequest(url: url!)
        webView?.loadRequest(requestObj)
    }
    
    func configureComponentsLayout(){
        self.bg_view?.layer.cornerRadius = 8
        self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

}

// MARK:- UIWebVeiw Deleagte metods

extension PrivacyPolicyViewController: UIWebViewDelegate{
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        sharedAPIClient.showLoadingViewWith("Loading..")
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        sharedAPIClient.removeLoadingView()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        sharedAPIClient.removeLoadingView()
    }
}
