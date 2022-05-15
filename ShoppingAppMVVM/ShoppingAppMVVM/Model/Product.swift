//
//  Product.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import Foundation

struct Product : Decodable {
    var _id:String
   var productName : String
   var   productPrice : Int
   var  productCategory: Category
   var  productImgUrl: String
    var  productPiece : Int 
}
