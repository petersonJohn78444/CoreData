//
//
//  router.swift
//
//  Copyright © 2018 Test. All rights reserved.
//


import UIKit
import Alamofire

let BasePath =  " "

protocol Routable
{
    var path        : String {get}
    var method      : HTTPMethod {get}
    var parameters  : Parameters? {get}
}

enum Router: Routable, CustomDebugStringConvertible
{
    case getInfo(Parameters)

    var debugDescription: String
    {
        var printString = ""
        
        printString     += "\n*********************************"
        printString     += "\nMethod : \(method)"
        printString     += "\nParameter : \(path)"
        printString     += "\n*********************************\n"
        
        return printString
    }
}

extension Router
{
    var path: String
    {
        switch self
        {
            case .getInfo:
                return BasePath + " "
         }
    }
}

extension Router
{
    var method: HTTPMethod
    {
        switch self
        {
            case .getInfo:
                return .post
        }
    }
}

extension Router
{
    var parameters: Parameters?
    {
        switch self
        {
        case .getInfo(let param):
                return param
        }
    }
}
