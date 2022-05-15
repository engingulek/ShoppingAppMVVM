//
//  ViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var categoryTitle: UILabel!
    var productListViewModel  : ProdutListViewModel!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    @IBAction func filterAction(_ sender: Any) {
        print(categoryTitle.text!)
        
    }
    
    @IBAction func allActionButton(_ sender: Any) {
        
    }
    
   
    
}

