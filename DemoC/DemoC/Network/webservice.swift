//
//
//  webservice.swift
//
//
//  Copyright © 2018 Test. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

let webserviceAPI: webservice = webservice.APIClient

class webservice: SessionManager
{
    var header = ["Content-Type" : "application/x-www-form-urlencoded"]
    
    static let APIClient: webservice =
    {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = 180
        configuration.timeoutIntervalForRequest  = 180
        
        return webservice(configuration: configuration)
    }()
  
    func sendRequest(_ route: Router) -> DataRequest
    {
            let path = route.path.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)
            
            var encoding: ParameterEncoding = JSONEncoding.default
        
            encoding = URLEncoding.default
 
            return self.request(path!, method: route.method, parameters: route.parameters, encoding: encoding, headers: header)
    }
}


