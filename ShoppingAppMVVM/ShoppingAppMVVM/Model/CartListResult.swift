//
//  CartListResult.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation

struct CartListResult:Decodable {
    var cartList:[CartList]?
    var success:Int
}
