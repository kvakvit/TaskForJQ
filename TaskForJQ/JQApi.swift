//
//  JQApi.swift
//  TestTaskForJQ
//
//  Created by Виталий on 05.05.16.
//  Copyright © 2016 kvakvit. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JQApi {
    
    struct Object {
        
        let id: Int
        let kindSale: String
        let price: Int
        let rentPrice: Int
        let kind: String
        let area: Int
        let bedrooms: Int
        let condition: String
        let updateAt: String
        let location: String
        let capture: String
    
    }
    
    func fetchObjects(offset: Int, callback: ([Object]) -> Void) {
        request(.GET, "https://api.jqestate.ru/v1/properties/country?pagination%5Blimit%5D=5&pagination%5Boffset%5D=\(offset)").responseJSON { (response) -> Void in
            self.populateObjects(response.result.value!, callback: callback)
        }
        
    }
    
    func populateObjects(data: AnyObject?, callback: ([Object]) -> Void) {
        
        let json = JSON(data!)
        
        var objects = [Object]()
        
        for item in json["items"].arrayValue {
            
            var date = item["updatedAt"].stringValue
            date[3] = "."
            
            objects.append(Object(id: item["id"].intValue , kindSale: item["saleOffer"]["kind"].stringValue, price: item["saleOffer"]["multiCurrencyPrice"]["rub"].intValue, rentPrice: item["rentOffer"]["multiCurrencyPrice"]["rub"].intValue, kind: item["kind"].stringValue, area: item["specification"]["area"].intValue, bedrooms: item["specification"]["bedrooms"].intValue, condition: item["specification"]["condition"].stringValue, updateAt: item["updatedAt"].stringValue , location: item["location"]["settlementName"].stringValue, capture: item["images"][0]["url"].stringValue))
            
        }
        
       
        callback(objects)
        
        
    }
    
}