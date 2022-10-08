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
    
    
    func filterProducts(products:[Product],selectedSortType:Bool?,selectedFilterName:String?,selectedCategory : CategoryViewModel?) -> [Product] {
        
        var filterProducts = [Product]()
        if (selectedCategory != nil && selectedCategory!.categoryName != "Hepsi") {
                           let productList = products.filter{
                               $0.productCategory._id == selectedCategory?.categoryId
                           }
            filterProducts = productList
            
                          
                       }else if(selectedFilterName != nil && selectedFilterName != "All"){
                           let productList = products.filter{
                               $0.productGender == selectedFilterName
                           }
                           filterProducts = productList
                           
                    
                       }else if (selectedSortType == true) {
                           let productList = products.sorted (by: {$0.productPrice < $1.productPrice})
                           
                           filterProducts = productList
                       }
                       
                       else if (selectedSortType == false) {
                           let productList = products.sorted (by: {$0.productPrice > $1.productPrice})
                           
                           filterProducts = productList
                       }
                       
                       else{
                           
                           filterProducts = products
                           
                       }
        return filterProducts
        
        
        
        
        
        
        
        
        

        
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


