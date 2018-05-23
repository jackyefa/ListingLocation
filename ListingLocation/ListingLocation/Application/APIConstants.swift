//
//  APIConstants.swift
//  ListingLocation
//
//  Created by Apple on 11/05/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

// MARK: - NETWORKING SINGLETON OBJECTS

let sharedAPIClient: APIClient = APIClient.sharedAPIClient
let sharedAPIManager: APIManager = APIManager.sharedAPIManager
let emptyParams: NSDictionary = NSDictionary()

// MARK: - NETWORKING BASE URL & API END POINTS

var DOMAIN = "http://e58ec53e.ngrok.io"
var API_ROOT = DOMAIN + "/api/v1/"

var API_LOGIN = API_ROOT + "sign_in"
var API_SIGNUP = API_ROOT + "sign_up"
var API_FORGOTPWD = API_ROOT + "forgot_password"
var API_LOGOUT = API_ROOT + "sign_out"
var API_CHANGEPWD = API_ROOT + "update_password"
var API_UPDATEPROFILE = API_ROOT + "profile_update"

// MARK: - LOADING POPUP TEXT ADN MESSAGE CONSTANTS

let LOADING_POPUP_TEXT = "Loading.."

let LOGIN_POPUP_TEXT = "Login.."
let LOGIN_SUCCESS_MESSAGE = "Thanks! You are successfully logged in."

let SIGNUP_POPUP_TEXT = "Signup.."
let SIGNUP_SUCCESS_MESSAGE = "Thanks! You are successfully sign up."

let FORGOT_PWD_SUCCESS_MESSAGE = "Thanks! The link has been sent to your email."

let LOGOUT_POPUP_TEXT = "Logout.."
let LOGOUT_SUSSESS_MESSAGE = "Thanks! You are successfully logout."

let UPDATE_PASSWORD_POPUP_TEXT = "Updating.."
let UPDATE_PASSWORD_SUCCESS_MESSAGE = "Thanks! Your password has been updated."

let UPDATE_PROFILE_SUCCESS_MESSAGE = "Thanks! Your profile has been updated."
let FORGOT_PASSWORD_SUCCESS_MESSAGE = "Thanks! Reset password link has been sent to your email."
