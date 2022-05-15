//
//  Product.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation

struct Product : Decodable {
   var productName : String
     var   productPrice : Int
      var  productCategory: String // var  productCategory: Category
       var  productImgUrl: String
       var  productPiece : Int
}
