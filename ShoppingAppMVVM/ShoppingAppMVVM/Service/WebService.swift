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
    
    func addProductCart(data:ProductViewModel, completion:@escaping(String?)-> ()){
        APICaller.sharred.sendData(router : "postCartList" ,data: data) { result in
            if result == nil {
                completion(nil)
            }else{
                completion("Success")
            }
        
            
        }
         
        
        
    }
    
    
    // post cartList-> Add Product to Cart
    
    func addProducToCart(cartListUserId
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
    }

// get cart list
func dowloadCartList(comletion:@escaping([CartList]?)->()){
    APICaller.sharred.fetchData(router: "getCartList") { (result:[CartList]?) in
        if let result = result {
            comletion(result)
            
        }else{
            comletion(nil)
        }
        
    }
}


func deleteProduct(id:String,completion:@escaping(String?)-> Void) {
    APICaller.sharred.deleteData(router: "deleteProduct", productId: id) { result in
        if let result = result {
            completion(result)
        }else{
            completion(nil)
        }
    }
    
}
    
    
    /// It click work when clicking the increment and decrement button
   func  incrementAndDecrementAction(type:String,userId:String,cartProductId:String,comletion:@escaping(String?)->()){
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
    
   }
    

    
    
    
        }





    



    



    


   
    
    
    
   
    
   
    
    
    
  
    
    


