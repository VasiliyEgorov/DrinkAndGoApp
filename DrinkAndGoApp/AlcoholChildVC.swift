//
//  AlcoholChildVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 18.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class AlcoholChildVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    private let cellID = "ChildCell"
    private let segueID = "CompleteSegue"
    private var cellWidth : CGFloat!
    private var cellHeight : CGFloat!
    private let cellOffset : CGFloat = 8.0
    var viewModel : AlcoholChildViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    // MARK: - Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlcoholChildCell
        cell.imageView.image = self.viewModel.setImageToCellAt(index: indexPath.row).uiImage
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: true)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.viewModel.removeItemAt(index: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
    }
    // MARK: - Flow Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = CGSize.init(width: self.cellWidth, height: self.cellHeight)
        return imageSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(self.cellOffset, self.cellOffset, self.cellOffset, self.cellOffset)
    }
    // MARK: - Methods
    func calculateFrameFor(alcoholImageView: UIImageView) {
        self.cellWidth = self.collectionView.frame.size.width / 4
        self.cellHeight = self.cellWidth * 1.5
        if let image = alcoholImageView.image {
            self.viewModel.addNewImage(image: UIImagePNGRepresentation(image))
            let range = Range.init(uncheckedBounds: (0, self.collectionView.numberOfSections))
            let indexSet = IndexSet.init(integersIn: range)
            self.collectionView.reloadSections(indexSet)
        }
    }
    // MARK: - Button Action
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultVC {
            resultVC.viewModel = self.viewModel.setResultViewModel()
        }
    }

}
