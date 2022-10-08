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
    
    
  /*  func dowloadProducts(comletion:@escaping([Product]?)->()){
        let productUrl = "http://localhost:3000/products"
        
        Alamofire.request(productUrl,method: .get).responseJSON { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(Productresult.self, from: data)
                    
                    if let productList = result.productList {
                        comletion(productList)
                    }
                }catch{
                    comletion(nil)
                    print(error.localizedDescription)
                }
            }
        }
    }*/
    
    
   func fetchData<T:Codable>(router:String,completion:@escaping([T]?)-> Void) {
       let url = "\(Constant.baseURL)categories"
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

    
    

    
    
    
    
    
    /*func fetchData<T:Codable>(router:String,completion: (Result<[T]?>)-> Void ){
        let url = "http://localhost:3000/\(Constant.baseURL)"
        Alamofire.request(url,method: .get).responseJSON {
           response in
           
           if let data  = response.data {
               
               do {
                   
                   //let result = try JSONDecoder.decode(Result.)
                   
                   /*let result = try JSONDecoder().decode(Result<T>.self, from: data)
                   if let list = result.list {
                       completion(list)
                   }*/
                   
                  /* if var categoryList = result.categoryList {
                       let allCategory = Category(_id: "0", categoryName: "Hepsi")
                       categoryList.insert(allCategory, at: 0)
                       completion(categoryList)
                   }*/
               }catch{
                   completion(nil)
                   print(error.localizedDescription)
               }
               
           }
           
       }
        
    }*/
   // func fetchData<T>(router:String,data:(T?)->()) where T: Decodable{}
    
   /* func fetchData<T:Codable>(router:String,completion:@escaping ([T]?)->() ){
        let url = "http://localhost:3000/\(Constant.baseURL)"
        Alamofire.request(url,method: .get).responseJSON {
           response in
           
           if let data  = response.data {
               
               do {
                   
                   let result = try JSONDecoder().decode(Result<T>.self, from: data)
                   if let list = result.list {
                       completion(list)
                   }
                   
                  /* if var categoryList = result.categoryList {
                       let allCategory = Category(_id: "0", categoryName: "Hepsi")
                       categoryList.insert(allCategory, at: 0)
                       completion(categoryList)
                   }*/
               }catch{
                   completion(nil)
                   print(error.localizedDescription)
               }
               
           }
           
       }
        
    }*/
}
