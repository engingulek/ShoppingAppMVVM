//
//  CartList.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation


struct CartList : Codable {
    
    var _id:String
    var cartListUserId:String
    var cartList:[CartProductList]
}
