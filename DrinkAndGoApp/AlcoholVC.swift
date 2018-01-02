//
//  AlcoholVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 02.01.18.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class AlcoholVC: UIViewController {
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel : AlcoholViewModel!
    private let segueID = "CompleteSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Buttons
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
