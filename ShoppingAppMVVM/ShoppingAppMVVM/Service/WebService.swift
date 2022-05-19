//
//  WebService.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation
import Alamofire
class WebService {
    
    // MARK : Alamofire Requests
    
    /// Dowload Categories
    func dowloadCategory(completion:@escaping ([Category]?)->() ){
        let categoryUrl = "http://localhost:3000/categories"
        
         Alamofire.request(categoryUrl,method: .get).responseJSON {
            response in
            
            if let data  = response.data {
                
                do {
                    
                    let result = try JSONDecoder().decode(Categoryresult.self, from: data)
                    
                    if var categoryList = result.categoryList {
                        let allCategory = Category(_id: "0", categoryName: "Hepsi")
                        categoryList.insert(allCategory, at: 0)
                        completion(categoryList)
                    }
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
                
            }
            
        }
}
    
    
    /// Dowload Products
    
    func dowloadProducts(comletion:@escaping([Product]?)->()){
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
    
    func  deleteProduct(userId:String,cartProductId:String,comletion:@escaping(String?)->()){
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
    
        
        
    }
   
    
    
    // get cart list
    func dowloadCartList(comletion:@escaping([CartList]?)->()){
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
    }
    
    
    
   
    
   
    
    
    
  
    
    
}

