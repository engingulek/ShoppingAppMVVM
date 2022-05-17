//
//  ShoppingCartViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 17.05.2022.
//

import Foundation
import UIKit


class ShoppingCartViewController : UIViewController{
    @IBOutlet weak var emptyCartUIView: UIView!
    
    @IBOutlet weak var cartListUIView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emptyCartUIView.isHidden = true
        cartListUIView.isHidden = false
    }
}
