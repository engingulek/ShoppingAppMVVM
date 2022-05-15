//
//  ProductViewModel.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation

struct ProdutListViewModel {
    var productList : [Product]
    
    func numberOfRowInSection() -> Int {
        return productList.count
    }
    
    
    func productAtIndex(_ index : Int) -> ProductViewModel {
        let product = productList[index]
        return ProductViewModel(product: product)
        
    }
}


struct ProductViewModel {
    var product : Product
    
    var productName : String {
        return self.product.productName
    }
      var   productPrice : Int {
          return self.product.productPrice
      }
       var  productCategory: String {
           return self.product.productCategory
       }
        var  productImgUrl: String {
            return self.product.productImgUrl
        }
        var  productPiece : Int {
            return self.product.productPiece
        }
}

