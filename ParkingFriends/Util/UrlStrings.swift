//
//  UrlStrings.swift
//  ParkingFriends
//
//  Created by MyoungHyoun Cho on 2018. 4. 9..
//  Copyright © 2018년 rao. All rights reserved.
//

import Foundation


class UrlStrings {
//    static let URL_SERVER_BASE = "http://api.parkingfriends.net"
    static let URL_SERVER_BASE = "http://dev.parkingfriends.net/~vata/api"
    
    // API
    static let URL_API_BASE = URL_SERVER_BASE + "/app"
    
    // USER
    static let URL_API_USER =          URL_API_BASE + "/user";
    static let URL_API_USER_LOGIN =    URL_API_USER + "/login.php";
    static let URL_API_USER_LOGOUT =   URL_API_USER + "/logout.php";
    static let URL_API_USER_SIGNUP =   URL_API_USER + "/register.php";
    static let URL_API_USER_GET =      URL_API_USER + "/get.php";
    static let URL_API_USER_CARINFO =  URL_API_USER + "/car.php";
    static let URL_API_USER_LEAVE =    URL_API_USER + "/leave.php";
    static let URL_API_USER_FCM =      URL_API_USER + "/fcmUpdate.php";
    
    static let URL_API_FCM_TOPIC = URL_API_BASE + "/message/fcm_topic_reg.php";
    
    
    // SMS
    static let URL_API_CERTIFICATION = URL_API_BASE + "/user/certification"
    static let URL_API_SMS = URL_API_CERTIFICATION + "/sms_cert.php"
    static let URL_API_SMSCONFIRM = URL_API_CERTIFICATION + "/check_cert_code.php"
    
    // PARKINGLOT
    static let URL_API_PARKINGLOT =             URL_API_BASE + "/parkinglot";
    static let URL_API_PARKINGLOT_FETCH =       URL_API_PARKINGLOT + "/get.php";
    static let URL_API_PARKINGLOT_FETCH_RATIO = URL_API_PARKINGLOT + "/getWithRatio.php";
    //  static let URL_API_PARKINGLOT_IMG = URL_API_PARKINGLOT + "/img/";
    static let URL_API_PARKINGLOT_IMG = "https://s3-ap-northeast-1.amazonaws.com/parkingfriends/parkinglots/";
    static let URL_SETUP_PARKINGLOT_PAGE =      URL_API_PARKINGLOT + "/set_parkinglot.php";
    static let URL_FETCH_PARKINGLOT_DETAIL =    URL_API_PARKINGLOT + "/get_parkinglot_detail.php";
    static let URL_ROADVIEW_PAGE =              URL_API_PARKINGLOT + "/roadview.php";
    
    // PAYMENT
    static let URL_API_PAYMENT = URL_API_BASE + "/payment";
    //  static let URL_API_NICEPAY_REQUEST = URL_API_PAYMENT + "/nicepay_etc/request.php";
    //  static let URL_API_NICEPAY_CARD_REQUEST = URL_API_PAYMENT + "/nicepay_card/request.php";
    //  static let URL_API_KAKAOPAY_REQUEST = URL_API_PAYMENT + "/kakao/kakaopayLiteRequest.php";
//    static let URL_API_NICEPAY_REQUEST =      "http://api.parkingfriends.net/app/payment/unipay.php";
//    static let URL_API_NICEPAY_CARD_REQUEST = "http://api.parkingfriends.net/app/payment/unipay.php";
//    static let URL_API_KAKAOPAY_REQUEST =     "http://api.parkingfriends.net/app/payment/unipay.php";
    
    
    static let URL_API_NICEPAY_REQUEST =      URL_API_PAYMENT + "/unipay.php";
    static let URL_API_NICEPAY_CARD_REQUEST = URL_API_PAYMENT + "/unipay.php";
    static let URL_API_KAKAOPAY_REQUEST =     URL_API_PAYMENT + "/unipay.php";
    
    
    // RESERVATION
    static let URL_API_RESERVATION =                URL_API_BASE + "/reservation";
    static let URL_API_RESERVATION_FETCH_HISTORY =  URL_API_RESERVATION + "/getHistory.php";
    static let URL_API_RESERVATION_FETCH_DETAIL =   URL_API_RESERVATION + "/getHistoryDetail.php";
    static let URL_API_RESERVATION_CANCEL =         URL_API_RESERVATION + "/cancel.php";
    static let URL_API_RESERVATION_IMPOSSIBLE =     URL_API_RESERVATION + "/getImpossibleTime.php";
    
    // ASK
    static let URL_COOP_ASK_FORM = "http://dev.parkingfriends.net/~vata/html/";
    
    // DVR
    static let URL_API_DVR =         URL_SERVER_BASE + "/camera";
    static let URL_API_DVR_REQUEST = URL_API_DVR + "/get.php";
}
