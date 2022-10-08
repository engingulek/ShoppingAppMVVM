//
//  WebService.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation
import Alamofire
import UIKit
class WebService {
    
    static var webService = WebService()
    
    // MARK : Alamofire Requests
    /// Dowload Categories
    func dowloadCategory(completion:@escaping ([Category]?)->() ){
        APICaller.sharred.fetchData(router: "categories") { (result:[Category]?) in
        
            if let result = result {
                completion(result)
            }else {
            completion(nil)
            }
        }
        
        }
    /// Dowload Products
    func dowloadProducts(completion:@escaping([Product]?)->()){
        
        APICaller.sharred.fetchData(router: "products") { (result:[Product]?) in
        
            if let result = result {
                completion(result)
            }else {
            completion(nil)
                
            }
        }
        
        }

    
    
        }

    
    
    // post cartList-> Add Product to Cart
    
   /* func addProducToCart(cartListUserId
                         :String,cartList:CartProductList,completion:@escaping(String?)->()){
        let addProductCartUrl = "http://localhost:3000/postCartList"
       
    
       // let parameters = ["cartListUserId":cartListUserId,"cartList":[cartList]] as [String : Any]
        
        let parameters : [String:Any] = [
            "cartListUserId":cartListUserId,
            "cartList":[
                ["cartProductId":cartList.cartProductId,
                 "cartProductName":cartList.cartProductName,
                 "cartProductPrice":cartList.cartProductPrice,
                 "cartProductCategory":["_id":cartList.cartProductCategory._id,"categoryName":cartList.cartProductCategory.categoryName],
                 "cartProductImgUrl":cartList.cartProductImgUrl,
                 "cartProductPiece":cartList.cartProductPiece
                
                ]
               
            ]
        ]
       
        Alamofire.request(addProductCartUrl,method: .post,parameters: parameters,encoding: JSONEncoding.init()).responseJSON { response in
            if let data  = response.data{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]{
                        print(json)
                        completion("Success")
                    }
                }catch{
                    print(error.localizedDescription)
                    completion(nil)
                }
            }
            
        }
    }*/
    
    /// It click work when clicking the increment and decrement button
   /* func  incrementAndDecrementAction(type:String,userId:String,cartProductId:String,comletion:@escaping(String?)->()){
        let url = "http://localhost:3000/productPieceIncDec"
        let parameters = ["userId":userId,"cartProductId":cartProductId,"type":type]
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.init()).responseJSON { response in
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]{
                        print(json)
                        comletion("Success")
                    
                    }
                }catch {
                    print(error.localizedDescription)
                    comletion(nil)
                }
            }
        }
    
   }*/
    
    /*func  deleteProduct(userId:String,cartProductId:String,comletion:@escaping(String?)->()){
        let url = "http://localhost:3000/deleteProduct"
        let parameters = ["userId":userId,"cartProductId":cartProductId]
        Alamofire.request(url,method: .post,parameters: parameters,encoding: JSONEncoding.init()).responseJSON { response in
            if let data = response.data {
                do{
                    if let json = try JSONSerialization.jsonObject(with: data,options: []) as? [String:Any]{
                        print(json)
                        comletion("Success")
                    
                    }
                }catch {
                    print(error.localizedDescription)
                    comletion(nil)
                }
            }
        }
    
        
        
    }*/
   
    
    
    // get cart list
    /*func dowloadCartList(comletion:@escaping([CartList]?)->()){
        let dowloadCartListUrl = "http://localhost:3000/getCartList"
        Alamofire.request(dowloadCartListUrl,method: .get).responseJSON { response in
            if let data = response.data {
                do {
                    let result = try JSONDecoder().decode(CartListResult.self,from: data)
                    
                    if let cartList = result.cartList {
                        comletion(cartList)
                    }
                    
                }catch{
                    comletion(nil)
                    
                }
            }
        }
    }*/
    
    
    
   
    
   
    
    
    
  
    
    


