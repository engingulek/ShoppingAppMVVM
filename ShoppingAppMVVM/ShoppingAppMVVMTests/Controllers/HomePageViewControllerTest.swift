//
//  HomePageViewControllerTest.swift
//  ShoppingAppMVVMTests
//
//  Created by engin gülek on 9.10.2022.
//

import XCTest
@testable import ShoppingAppMVVM
class HomePageViewControllerTest: XCTestCase{
   
    var storyboard : UIStoryboard!
    var hpvc : HomePageViewController!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        hpvc = storyboard.instantiateViewController(identifier: "homePageViewController") as? HomePageViewController
        hpvc.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        storyboard = nil
        hpvc = nil
   
        
    }
    
    
    func test_cellForItem_returnsCategoryCell(){
        hpvc.filterNameList = ["All"]
        let indexPath = IndexPath(item: 0, section: 0)
        let cell = hpvc.filterCollectionView.dataSource?.collectionView(hpvc.filterCollectionView, cellForItemAt: indexPath) as! FilterCollectionViewCell
        let filterName = cell.filterName!
        XCTAssertEqual(filterName.text, "All")
    }
    
  
    
    
   
    
   
    
  
    
    

 

  

}
