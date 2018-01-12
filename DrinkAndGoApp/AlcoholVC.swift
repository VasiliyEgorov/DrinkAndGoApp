//
//  AlcoholVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 02.01.18.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
import GravitySliderFlowLayout

class AlcoholVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, CellsDelegate, AlcoholDetailsDelegate {
    
    @IBOutlet weak var resultsView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel : AlcoholViewModel!
    private let segueID = "CompleteSegue"
    private let detailsID = "AlcoholDetailsSegue"
    private let cellID = "AlcoholCell"
    private let collectionViewCellHeight : CGFloat = 0.85
    private let collectionViewCellWidth : CGFloat = 0.55
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // MARK: - Setup
    
    private func setupCollectionView() {
        let gravityLayoutSlider = GravitySliderFlowLayout(with: CGSize(width: self.collectionView.frame.size.height * self.collectionViewCellWidth,
                                                                       height: self.collectionView.frame.size.height * self.collectionViewCellHeight))
        self.collectionView.collectionViewLayout = gravityLayoutSlider
    }
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfCells()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlcoholCell
        cell.viewModel = self.viewModel.setCellsViewModel(row: indexPath.row)
        cell.delegate = self
        return cell
    }
    
    // MARK: - Cells Delegate
    func tapAction(title: String?, alcPercent: String?) {
        if let alcDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlcoholDetails") as? AlcoholDetailsVC {
            alcDetailsVC.viewModel = self.viewModel.setAlcoholDetailsViewModel(title: title, alcPercentage: alcPercent)
            alcDetailsVC.delegate = self
            self.present(alcDetailsVC, animated: true, completion: nil)
        }
    }
    // MARK: - AlcoholDetailsDelegate
    func setAlcohol(volume: String?, percentage: String?) {
        self.viewModel.addAlcohol(volume: volume, percentage: percentage)
    }
    // MARK: - Buttons
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
    }
    
    // MARK: - Navigation

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    

}
