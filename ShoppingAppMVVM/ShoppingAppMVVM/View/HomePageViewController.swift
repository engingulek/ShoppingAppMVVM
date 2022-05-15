//
//  ViewController.swift
//  ShoppingAppMVVM
//
//  Created by engin gülek on 7.05.2022.
//

import UIKit
import Kingfisher

class HomePageViewController: UIViewController,CategoryDelegate {
 
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var productCollectionView : UICollectionView!
    private var selectedCategory : CategoryViewModel? = nil
 
   
    // implement ProductListViewModel
    var productListViewModel = ProductListViewModel()
    
    override func viewDidLoad() {
        getData()
        setupUI()
        
        productCollectionView.dataSource = self
        productCollectionView.delegate = self
        
        super.viewDidLoad()
    }
    
    private func getData() {
        WebService().dowloadProducts { products in
            
            if let products = products {
               
                
                if (self.selectedCategory != nil && self.selectedCategory?.categoryName != "Hepsi") {
                    let productList = products.filter{
                        $0.productCategory._id == self.selectedCategory?.categoryId
                    }
                    self.productListViewModel.productList = productList.map(ProductViewModel.init)
                }else{
                    self.productListViewModel.productList = products.map(ProductViewModel.init)
                    
                }
                
                DispatchQueue.main.async {
                    self.productCollectionView.reloadData()
                }
                
             
                
               
                
            }
        }
        
    }
  
    func selectedCategory(category: CategoryViewModel) {
        categoryTitle.text = "\(category.categoryName)"
        self.selectedCategory = category
        getData()
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


extension HomePageViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productListViewModel.productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.productCollectionView.dequeueReusableCell(withReuseIdentifier: "productCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        
        let product = self.productListViewModel.cellForItemAt(indexPath.row)
        let url = URL(string: "\(product.productImgUrl)")
        cell.productImageView.kf.setImage(with: url)
        cell.productNameLabel.text = product.productName
        cell.productPriceLabel.text = "\(product.productPrice) ₺"
        
        
        
        
        
        
     
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 10.0
        
        return cell
    }
    
    
    private func setupUI(){
        let design :UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let width = self.productCollectionView.frame.size.width
        
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let cellWidth = (width-30)/2
        
        design.itemSize = CGSize(width: cellWidth, height: cellWidth*1.7)
        
        design.minimumInteritemSpacing = 10
        design.minimumLineSpacing = 10
        
        productCollectionView.collectionViewLayout = design
    }
    

    
    
    
    
    
    
}

