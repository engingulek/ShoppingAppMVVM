//
//  ViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit

class ViewController: UIViewController,CategoryDelegate {
    func selectedCategory(category: CategoryViewModel) {
        categoryTitle.text = "\(category.categoryName)"
    }
    

    @IBOutlet weak var categoryTitle: UILabel!
    
   
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nav = segue.destination as? UINavigationController else
        {
            fatalError("nav error")
        }
        
        guard let homePageViewController = nav.viewControllers.first as? CategoriesViewController else {
            fatalError("ViewController not found")
        }
        
        homePageViewController.delegate = self
    }
  
    
   
    
   
    
}

