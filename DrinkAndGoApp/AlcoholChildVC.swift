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

class AlcoholChildVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AlcChildCellDelegate {

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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.numberOfSections()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfCells()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlcoholChildCell
        cell.imageView.image = self.viewModel.setImageToCellAt(index: indexPath.row).uiImage
        cell.delegate = self
        return cell
    }
   
    // MARK: - Flow Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageSize = CGSize.init(width: self.cellWidth, height: self.cellHeight)
        return imageSize
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets.init(top: self.cellOffset, left: self.cellOffset, bottom: self.cellOffset, right: self.cellOffset)
    }
    // MARK: - Methods
    func calculateFrameFor(alcoholImageView: UIImageView) {
        self.cellWidth = self.collectionView.frame.size.width / 4
        self.cellHeight = self.collectionView.frame.size.height - self.cellOffset
        if let image = alcoholImageView.image {
            self.viewModel.addNewImage(image: image.pngData())
            self.collectionView.reloadSections(self.viewModel.getIndexSetForReload())
            collectionView.scrollToItem(at: self.viewModel.getIndexPathToScrollTo(), at: .bottom, animated: true)
            postNotification()
        }
    }
    // MARK: - AlcChildCell Delegate
    func closeButtonAction(_ sender: UIButton) {
        let point : CGPoint = sender.convert(CGPoint.zero, to: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: point)
        if let indexPath = indexPath {
            self.viewModel.removeItemAt(index: indexPath.row)
            collectionView.deleteItems(at: [indexPath])
            postNotification()
        }
    }
    private func postNotification() {
        let dict = ["count" : self.viewModel.numberOfCells()]
        NotificationCenter.default.post(Notification.init(name: Notification.Name.alcoholCountDidChange, object: nil, userInfo: dict))
    }
}
