//
//  AlcoholVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 02.01.18.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit
import GravitySliderFlowLayout

class AlcoholVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, AlcoholDetailsDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectableView: CollectableView!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel : AlcoholViewModel!
    private let segueID = "CompleteSegue"
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
        self.pageControl.numberOfPages = self.viewModel.numberOfCells()
    }
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.viewModel.numberOfCells()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AlcoholCell
        cell.viewModel = self.viewModel.setCellsViewModel(row: indexPath.row)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let alcDetailsVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AlcoholDetails") as? AlcoholDetailsVC {
            let cell = collectionView.cellForItem(at: indexPath) as! AlcoholCell
            alcDetailsVC.viewModel = self.viewModel.setAlcoholDetailsViewModel(title: cell.titleLabel.text, alcPercentage: cell.alcPercentLabel.text, indexPath: indexPath)
            alcDetailsVC.delegate = self
            self.present(alcDetailsVC, animated: true, completion: nil)
        }
    }
   
    // MARK: - AlcoholDetailsDelegate
    func setAlcohol(volume: String?, percentage: String?, indexPath: IndexPath) {
        let cell = self.collectionView.cellForItem(at: indexPath) as! AlcoholCell
        let alcImage = UIImageView.init(image: cell.cellsImageView.image)
        for gradiendLayer in cell.layer.sublayers! {
            if gradiendLayer.isKind(of: CAGradientLayer.self) {
                alcImage.layer.insertSublayer(gradiendLayer, at: 0)
            }
        }
        cell.addSubview(alcImage)
        self.collectableView.calculateFrameFor(alcoholImageView: alcImage)
        self.collectableView.viewModel.addAlcohol(volume: volume, percentage: percentage)
    }
    // MARK: - Buttons
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultVC {
            resultVC.viewModel = self.collectableView.viewModel.setResultViewModel()
        }
    }
    /*
    private func animateChangingTitle(for indexPath: IndexPath) {
        UIView.transition(with: productTitleLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.productTitleLabel.text = self.titles[indexPath.row % self.titles.count]
        }, completion: nil)
        UIView.transition(with: productSubtitleLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.productSubtitleLabel.text = self.subtitles[indexPath.row % self.subtitles.count]
        }, completion: nil)
        UIView.transition(with: priceButton, duration: 0.3, options: .transitionCrossDissolve, animations: {
            self.priceButton.setTitle(self.prices[indexPath.row % self.prices.count], for: .normal)
        }, completion: nil)
    }
 */
}

extension AlcoholVC {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let locationFirst = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationSecond = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x + 20, y: collectionView.center.y + scrollView.contentOffset.y)
        let locationThird = CGPoint(x: collectionView.center.x + scrollView.contentOffset.x - 20, y: collectionView.center.y + scrollView.contentOffset.y)
        
        if let indexPathFirst = collectionView.indexPathForItem(at: locationFirst), let indexPathSecond = collectionView.indexPathForItem(at: locationSecond), let indexPathThird = collectionView.indexPathForItem(at: locationThird), indexPathFirst.row == indexPathSecond.row && indexPathSecond.row == indexPathThird.row && indexPathFirst.row != pageControl.currentPage {
            pageControl.currentPage = indexPathFirst.row
            //self.animateChangingTitle(for: indexPathFirst)
        }
}
}
