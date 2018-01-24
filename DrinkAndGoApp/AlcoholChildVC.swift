//
//  AlcoholChildVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 18.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

extension Notification.Name {
    static let alcoholCountDidChange = Notification.Name("alcoholCountDidChange")
}

class AlcoholChildVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    private let cellID = "ChildCell"
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
       
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        self.viewModel.removeItemAt(index: indexPath.row)
        collectionView.deleteItems(at: [indexPath])
        postNotification()
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
            let lastSectionIndex = self.collectionView.numberOfSections - 1
            let lastItemIndex = self.collectionView.numberOfItems(inSection: lastSectionIndex) - 1
            let indexPath = IndexPath.init(item: lastItemIndex, section: lastSectionIndex)
            collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            postNotification()
        }
    }
    private func postNotification() {
        let dict = ["count" : self.viewModel.numberOfCells()]
        NotificationCenter.default.post(Notification.init(name: Notification.Name.alcoholCountDidChange, object: nil, userInfo: dict))
    }
}
