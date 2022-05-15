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
    
    
  
    
    
}

