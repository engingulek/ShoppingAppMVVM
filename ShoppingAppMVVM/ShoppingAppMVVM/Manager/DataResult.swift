//
//  DataResult.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 8.10.2022.
//

import Foundation

class DataResult<T:Codable>: Codable {
    var list:[T]?
    var success:Int?
}
