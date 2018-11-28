//
//  Info.swift
//
//  Created  on 28/11/18.
//


import Foundation
import SwiftyJSON

let UKeyResults = "results"
let UKeyType   = "type"
let UKeyData     = "data"
let UKeyCategory    = "category"
 let UKeyCompName =  "companyname"


class Info: NSObject, JSONable
{
    var lists  : NSArray?  = []
    var info : infoData?

    
    required init(parameter: JSON)
    {
        lists = parameter["data"]["results"].arrayValue as NSArray
        info =  infoData(parameter: parameter["data"]["results"][0])

//        let list = (parameter["results"].to(type: Lists.self) ?? []) as! [Lists]
//        lists = NSMutableArray(array:list) as? [Lists]
    }
}

class infoData: NSObject, JSONable
{
    let total  : Int!
    let currentPage  : Int!
    var List  : [Lists]!
    
    required init(parameter: JSON)
    {
        total       = parameter["total_pages"].intValue
        currentPage = parameter["current_page"].intValue
        let datas = (parameter["data"].to(type: Lists.self) ?? [] ) as! [Lists]
        List = NSMutableArray(array:datas) as? [Lists]
     }
}

class Lists: NSObject, JSONable
{
    var category : String!
    var compName : String!
 
    required init(parameter: JSON)
    {
        category = parameter[UKeyCategory].stringValue
        compName = parameter[UKeyCompName].stringValue
    }
    required init(parameterDict: [String:Any])
    {
        category = parameterDict[UKeyCategory] as! String
        compName = parameterDict[UKeyCompName] as! String
    }
}





