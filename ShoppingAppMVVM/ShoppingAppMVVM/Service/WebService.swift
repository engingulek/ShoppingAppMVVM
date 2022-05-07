//
//  WebService.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation
import Alamofire
class WebService {
    
    func dowloadCategory(completion:@escaping ([Category]?)->() ){
        let categoryUrl = "http://localhost:3000/categories"
        
        
        Alamofire.request(categoryUrl,method: .get).responseJSON {
            response in
            
            if let data  = response.data {
                
                do {
                    
                    let result = try JSONDecoder().decode(Categoryresult.self, from: data)
                    
                    if let categoryList = result.categoryList {
                        completion(categoryList)
                     
                        
                     
                        
                    }
                }catch{
                    completion(nil)
                    print(error.localizedDescription)
                }
                
            }
            
        }
        
        
        
        
      
}
}

