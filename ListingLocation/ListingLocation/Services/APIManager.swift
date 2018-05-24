//
//  APIManager.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import Alamofire_SwiftyJSON

public class APIManager {
    
    class var sharedAPIManager: APIManager {
        struct Static {
            static let instance: APIManager = APIManager()
        }
        return Static.instance
    }
    
    //MARK:- USER LOGIN, SIGNUP AND LOGOUT RELATED METHODS
    
    func user_signIn_apiCall(_ apiParams: NSDictionary, success:@escaping (_ userData: User) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_LOGIN, method: .post, apiParameters: apiParams, loadingViewText: LOGIN_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            self.update_user_authToken(responseObject.response!)
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            let userData = Mapper<User>().map(JSONObject: responseDictionary["user"])
            if let user_name = userData?.name{
                name = user_name
            }
            if let user_phone = userData?.phone{
                phone = user_phone
            }
            if let user_id = userData?.id{
                id = user_id
            }
            if let email = userData?.email{
                user_email = email
            }
            if let user_address = userData?.address_response{
                address = user_address
            }
            success(userData!)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    func user_signUp_apiCall(_ apiParams: NSDictionary, success:@escaping (_ responseDictionary: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_SIGNUP, method: .post, apiParameters: apiParams, loadingViewText: SIGNUP_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            self.update_user_authToken(responseObject.response!)
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            let userData = Mapper<User>().map(JSONObject: responseDictionary["user"])
            if let user_name = userData?.name{
                name = user_name
            }
            if let user_phone = userData?.phone{
                phone = user_phone
            }
            if let user_id = userData?.id{
                id = user_id
            }
            if let email = userData?.email{
                user_email = email
            }
            if let user_address = userData?.address_response{
                address = user_address
            }
            success(responseDictionary)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    func user_signOut_apiCall( success:@escaping (_ responseDictionary: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_LOGOUT, method: .delete, apiParameters: emptyParams, loadingViewText: LOGOUT_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            guard let isSuccess: Int = responseDictionary["success"] as? Int, isSuccess == 1 else{
                failure(emptyDataError)
                return
            }
            success(responseDictionary)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    func user_forgotPassword_apiCall(_ apiParams: NSDictionary, success:@escaping (_ responseDictionary: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_FORGOTPWD, method: .post, apiParameters: apiParams, loadingViewText: LOADING_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            guard let isSuccess: Int = responseDictionary["success"] as? Int, isSuccess == 1 else{
                failure(emptyDataError)
                return
            }
            success(responseDictionary)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    func user_updatePassword_apiCall(_ apiParams: NSDictionary, success:@escaping (_ responseDictionary: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_CHANGEPWD, method: .put, apiParameters: apiParams, loadingViewText: UPDATE_PASSWORD_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            guard let isSuccess: Int = responseDictionary["success"] as? Int, isSuccess == 1 else{
                failure(emptyDataError)
                return
            }
            success(responseDictionary)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    func user_updateProfile_apiCall(_ apiParams: NSDictionary, success:@escaping (_ responseDictionary: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_UPDATEPROFILE, method: .put, apiParameters: apiParams, loadingViewText: UPDATE_PASSWORD_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            guard let isSuccess: Int = responseDictionary["success"] as? Int, isSuccess == 1 else{
                failure(emptyDataError)
                return
            }
            success(responseDictionary)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    //MARK:- PROPERTY_RELATED_API'S
    
    func user_dashboard_apiCall( success:@escaping (_ responseDictionary: DashboardResponse) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_DASHBOARD, method: .get, apiParameters: emptyParams, loadingViewText: LOADING_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            
            if let dashboardResponse: DashboardResponse = Mapper<DashboardResponse>().map(JSONObject: responseDictionary){
                success(dashboardResponse)
            }
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    func user_addListing_apiCall(_ apiParams: NSDictionary, success:@escaping (_ responseDictionary: NSDictionary) ->(), failure:@escaping (_ error: NSError) ->()) {
        
        sharedAPIClient.baseApiCallWith_HttpHeader(API_ADDLISTING, method: .post, apiParameters: apiParams, loadingViewText: ADD_LISTING_POPUP_TEXT, baseSuccessBlock: { (responseObject: DataResponse) -> () in
            
            let emptyDataError: NSError = getFailureError(["error": "empty error."])
            guard let responseDictionary: NSDictionary = responseObject.result.value as? NSDictionary else{
                failure(emptyDataError)
                return
            }
            
            success(responseDictionary)
            
        }, baseFailureBlock:{ (error: NSError?) -> () in
            failure(error!)
        })
    }
    
    // Update user auth token
    func update_user_authToken(_ response: HTTPURLResponse) {
        if let token: String = response.allHeaderFields["X-AUTH-TOKEN"] as? String {
            auth_token = token
        }
    }
    
}

