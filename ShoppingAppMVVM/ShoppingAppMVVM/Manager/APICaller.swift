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
    static let userIdv = "testUserId"
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
    
    
    func sendData(router:String,data: ProductViewModel,  completion:@escaping(String?)-> Void) {
        let url = "\(Constant.baseURL)\(router)"
        let parameters : [String:Any] = [
            "cartListUserId":Constant.userIdv,
            "cartList":[
                ["cartProductId":data._id,
                 "cartProductName":data.productName,
                 "cartProductPrice":data.productPrice,
                 "cartProductCategory":["_id":data.productCategory._id,"categoryName":data.productCategory.categoryName],
                 "cartProductImgUrl":data.productImgUrl,
                 "cartProductPiece":data.productPiece
                ]
            ]
        ]
        
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.init()).responseJSON { response in
            if let data = response.data {
                do {
                    if try JSONSerialization.jsonObject(with: data,options: []) is [String:Any]{
                        completion("Success")
                    }
                  
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
        }
    }
    
    func deleteData(router:String,productId:String,completion:@escaping(String?)-> Void ){
        let url = "\(Constant.baseURL)\(router)"
        let parameters = ["userId":Constant.userIdv,"cartProductId":productId]
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.init()).responseJSON { response in
            if let data = response.data {
                do{
                    if try JSONSerialization.jsonObject(with: data,options: []) is [String:Any]{
                        completion("Success")
                    }
                }catch{
                    completion(nil)
                    
                }
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
