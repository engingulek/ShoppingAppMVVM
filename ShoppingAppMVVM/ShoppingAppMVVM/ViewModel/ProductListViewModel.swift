//
//  ProductListViewModel.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 15.05.2022.
//

import Foundation


struct ProductListViewModel {
    var productList : [ProductViewModel]
    
    init(){
        self.productList = [ProductViewModel]()
    }
    
    
    func numberOfRowsInSection()->Int {
        return self.productList.count
    }
    
    func cellForItemAt(_ index:Int) -> ProductViewModel {
        return productList[index]
    }
}




struct ProductViewModel {
    var product : Product
    
    var _id:String {
        return self.product._id
        
    }
    var productName : String {
        return self.product.productName
    }
    var productPrice : Int {
        return self.product.productPrice
        
    }
    var  productCategory: Category {
        
        return self.product.productCategory
        
    }
    var  productImgUrl: String{
        return self.product.productImgUrl
        
    }
    var  productPiece : Int {
        return self.product.productPiece
        
    }
    
    var productGender: String {
        return self.product.productGender
    }
}


