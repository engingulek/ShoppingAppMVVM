//
//  CategoriesViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit


protocol CategoryDelegate {
    func selectedCategory(category:CategoryViewModel)
}


class CategoriesViewController: UIViewController {
 
    
    @IBOutlet weak var categoriesTableView: UITableView!
   // private var  categoryListViewModel : CategoryListViewModel!
    
    let categoryLitViewModel = CategoryListViewModel()
    var delegate : CategoryDelegate?
    
 
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
   

        
        getData()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        categoriesTableView.delegate = self
        categoriesTableView.dataSource = self
        
    
    }
    
   private func getData(){
        WebService().dowloadCategory {  list  in
            if let categoryList = list {
                print(categoryList)
               
               self.categoryLitViewModel.categoryList = categoryList.map(CategoryViewModel.init)
              
                Dispatch.DispatchQueue.main.async {
                    self.categoriesTableView.reloadData()
                    
               
                    
                 
                }
            }
        }
    }
    
    
    
    
 
    
    
  
    
  

}


extension CategoriesViewController : UITableViewDelegate, UITableViewDataSource  {
    
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = categoryLitViewModel.categoryAtIndex(indexPath.row)
        self.dismiss(animated: true,completion: nil)
        delegate?.selectedCategory(category: selectedCategory)
    }
    
   

    
}


