//
//
//  webservice+User.swift
//
//  Copyright © 2018 Test. All rights reserved.
//


import Foundation
import SwiftyJSON

extension webservice
{
    func getInfo(_ parameter:[String: Any]?,completion:@escaping (Info?) -> Void)
    {
        self.sendRequest(.getInfo(parameter!)).responseJSON { response in
            
            switch response.result
            {
                case .success:
                    if let _ = response.result.value
                    {
                        let jsonResult: JSON = JSON(response.result.value!)
 
                        if (jsonResult["code"].intValue == 200)
                        {
                            let user = jsonResult.to(type: Info.self) as! Info
 
                            completion(user)
                        }
                        else
                        {
//                          let response = DMResponse(parameter: jsonResult)

                            completion(nil)
                        }
                    }
                case .failure(let error):
                    print("Error: \(error)")
                    completion(nil)
            }
        }
    }
    
//    func GetAllData(_ parameter:[String: Any]?,completion:@escaping ([Category]?, AMResponse?) -> Void)
//    {
//        self.sendRequest(.getActiveCategory(parameter!)).responseJSON { response in
//
//            switch response.result
//            {
//            case .success:
//                if let _ = response.result.value
//                {
//                    let jsonResult: JSON = JSON(response.result.value!)
//
//                    if (response.response?.statusCode == 200)
//                    {
//                        let list = (jsonResult[CKeyData].to(type: Category.self) ?? [] ) as! [Category]
//
//                        let response = AMResponse(parameter: jsonResult)
//
//                        completion(list, response)
//                    }
//                    else
//                    {
//                        let response = AMResponse(parameter: jsonResult)
//
//                        completion(nil,response)
//                    }
//                }
//            case .failure(let error):
//                print("Error: \(error)")
//                Utill.showAlert(withMessage: Text.UnKnownError)
//                completion(nil,nil)
//            }}
//    }
}
