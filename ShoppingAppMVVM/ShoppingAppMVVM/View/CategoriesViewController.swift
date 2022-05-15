//
//  CategoriesViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit

class CategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    

    
    @IBOutlet weak var categoriesTableView: UITableView!
   // private var  categoryListViewModel : CategoryListViewModel!
    
    let categoryLitViewModel = CategoryListViewModel()
 
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        getData()
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        
    
    }
    
    func getData(){
        WebService().dowloadCategory {  categoryList  in
            if let categoryList = categoryList {
               
                self.categoryLitViewModel.categoryList = categoryList.map(CategoryViewModel.init)
              
                Dispatch.DispatchQueue.main.async {
                    self.categoriesTableView.reloadData()
                    
               
                    
                 
                }
            }
        }
    }
    
    
    
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return  self.categoryLitViewModel.numberOfRowInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath)
        
        let category = categoryLitViewModel.categoryAtIndex(indexPath.row)
        cell.textLabel?.text =  category.categoryName
        return cell
    }
    
  
    
    
    /*func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.categoryListViewModel == nil ? 0  :  self.categoryListViewModel.numberOfRowInSection()
        
    }*/
    
    /*func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = categoriesTableView.dequeueReusableCell(withIdentifier: "catagoryCell", for: indexPath)
        
        let categortViewModel = self.categoryListViewModel.categoryAtIndex(indexPath.row)
        cell.textLabel?.text = categortViewModel.categoryName
        return cell
        
    }*/
    // MARK: -Selected Categories
    // If you click to category it will go to homePage
    /*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.tabBarController?.viewControllers?[0] as! ViewController
       
        self.tabBarController?.selectedIndex = 0
        
        vc.categoryTitle.text = self.categoryListViewModel.categoryAtIndex(indexPath.row).categoryName
    }*/
    
    
    
   /* func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Categories"
    }*/
    

}


