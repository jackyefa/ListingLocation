//
//  ReachabilityManager.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import ReachabilitySwift

class ReachabilityManager: NSObject {
    
    static let shared = ReachabilityManager()
    var noNetworkLbl: UILabel?
    
    // Boolean to track network reachability
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    // Tracks current NetworkStatus (notReachable, reachableViaWiFi, reachableViaWWAN)
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    // Reachibility instance for Network status monitoring
    let reachability = Reachability()!
    
    // Called whenever there is a change in NetworkReachibility Status
    // parameter notification: Notification with the Reachability instance
    @objc func reachabilityChanged(notification: Notification) {
        
        let reachability = notification.object as! Reachability
        self.reachabilityStatus = reachability.currentReachabilityStatus
        switch reachability.currentReachabilityStatus {
            
        case .notReachable:
            debugPrint("Network became unreachable")
            self.showNoNetworkOverlayView()
            
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
            self.hideNoNetworkOverlayView()
            
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
            self.hideNoNetworkOverlayView()
        }
    }
    
    // Starts monitoring the network availability status
    func startMonitoring() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: ReachabilityChangedNotification, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }
    
    func showNoNetworkOverlayView() {
        self.noNetworkLbl = UILabel(frame: CGRect(x: 0, y: objWindow.frame.size.height - 40, width: objWindow.frame.size.width, height: 40))
        self.noNetworkLbl?.backgroundColor = UIColor.appRedButtonColor()
        self.noNetworkLbl?.text = "Sorry! No Internet Connection."
        self.noNetworkLbl?.textAlignment = .center
        self.noNetworkLbl?.textColor = UIColor.white
        self.noNetworkLbl?.font = UIFont.boldFontOfSize(size: 15.0)
        objWindow.addSubview(self.noNetworkLbl!)
        
        UIView.animate(withDuration:5, delay:1, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.noNetworkLbl?.alpha = 0
        }, completion: { finished in
            self.hideNoNetworkOverlayView()
        })
    }
    
    func hideNoNetworkOverlayView() {
        if self.noNetworkLbl != nil {
            self.noNetworkLbl?.removeFromSuperview()
        }
    }
}

