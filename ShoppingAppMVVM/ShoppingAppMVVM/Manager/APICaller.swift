//
//  APICaller.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 8.10.2022.
//

import Foundation
import Alamofire
import UIKit
struct Constant {
    static let baseURL = "http://localhost:3000/"
}


class APICaller {
   static var sharred = APICaller()
   func fetchData<T:Codable>(router:String,completion:@escaping([T]?)-> Void) {
       let url = "\(Constant.baseURL)\(router)"
       Alamofire.request(url,method: .get).responseJSON { response in
           if let data  = response.data {
               do {
                   let result = try JSONDecoder().decode(DataResult<T>.self, from: data)
                   if let list = result.list {
                       completion(list)
                   }else{
                       completion(nil)
                   }
               }catch{
                   completion(nil)
                  
               }
               
           }
       }
        
    }
}
