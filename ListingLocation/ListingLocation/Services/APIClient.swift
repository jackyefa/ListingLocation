//
//  APIClient.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import SVProgressHUD

public class APIClient {
    
    class var sharedAPIClient : APIClient {
        struct Static {
            static let instance: APIClient = APIClient()
        }
        return Static.instance
    }
    
    // MARK: - ACTIVITY INDICATOR START/STOP METHODS
    
    func showLoadingViewWith(_ statusText: String) {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            SVProgressHUD.show(withStatus: statusText)
        })
    }
    
    func removeLoadingView() {
        DispatchQueue.main.async(execute: {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            SVProgressHUD.dismiss()
        })
    }
    
    // MARK: - CHECK NETWORK CONNECTION
    
    func isNetworkReachable() -> Bool {
        return ReachabilityManager.shared.isNetworkAvailable
    }
    
    // MARK: - COMMON GET/POST API CALLS
    
    func serverApiCallWith_Post(_ params: NSDictionary, urlString: String, success:@escaping(_ responseObject: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        self.showLoadingViewWith("Loading")
        
        Alamofire.request(urlString, method: .post, parameters: params as? [String:Any]).responseObject { (response: DataResponse<User>) in
            
            self.removeLoadingView()
            
            switch response.result {
            case .success:
                success((response as AnyObject) as! NSDictionary)
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    func serverApiCallWith_Get(_ params: NSDictionary, urlString: String, success:@escaping(_ responseObject: NSDictionary) ->(), failure:@escaping(_ error: NSError) ->()) {
        
        self.showLoadingViewWith("Loading")
        
        Alamofire.request(urlString, method: .get, parameters: params as? [String:Any]).responseJSON { responseObject in
            
            self.removeLoadingView()
            
            switch responseObject.result {
            case .success:
                if let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary {
                    success(responseDictionary)
                }
            case .failure(let error):
                failure(error as NSError)
            }
        }
    }
    
    // MARK: - BASE API CALL METHOD
    
    func baseApiCallWith_HttpHeader(_ apiServiceUrl: String, method: HTTPMethod, apiParameters: NSDictionary, loadingViewText: String, baseSuccessBlock: @escaping(_ responseObject: DataResponse<Any>) ->(), baseFailureBlock: @escaping(_ error: NSError) ->() ) {
        
        let isReachable: Bool = isNetworkReachable()
        
        if isReachable {
            
            self.showLoadingViewWith(loadingViewText)
            let requestHeader: HTTPHeaders = auth_token.isEmpty ? apiParameters as! HTTPHeaders : ["X-AUTH-TOKEN": auth_token]
            
            Alamofire.request(apiServiceUrl, method: method, parameters: apiParameters as? [String:Any], headers: requestHeader).responseJSON { (response: DataResponse<Any>) in
                
                self.removeLoadingView()
                
                if (response.result.isSuccess) {
                    
                    if let statusCode = response.response?.statusCode {
                        
                        switch(statusCode) {
                            
                        case 200, 201:
                            baseSuccessBlock(response)
                            break
                            
                        case 401:
                                NotificationCenter.default.post(name: INVALID_USER_ACCESS_TOKEN_NOTIFICATION, object: nil)
                            break
                            
                        default:
                            if response.result.value is NSDictionary {
                                baseFailureBlock(getFailureError(response.result.value as! NSDictionary))
                            }else {
                                baseFailureBlock(getFailureError(["error": "Unknown server error"]))
                            }
                            break
                        }
                    }
                }else if(response.result.isFailure) {
                    if let objError = response.result.error {
                        baseFailureBlock(objError as NSError)
                    }
                }
            }
        }else {
            baseFailureBlock(NO_NETWORK_ERROR)
        }
    }
    
}

