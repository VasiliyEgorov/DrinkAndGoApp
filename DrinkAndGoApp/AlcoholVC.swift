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
    
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageControllBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomContstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel : AlcoholViewModel!
    private let cellID = "AlcoholCell"
    private let segueID = "CompleteSegue"
    private var childController : AlcoholChildVC!
    private var pageDistance : CGFloat!
    private var lastContentOffset : CGFloat!
    private var nextPageDistance : CGFloat!
    private var minDistance : CGFloat!
    private var maxDistance : CGFloat!
    private var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPage()
        updateConstraints()
        setupCollectionView()
        setupChildController()
        setupNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup
    private func setupPage() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .Iphone5?:
            self.pageDistance = 45.0
        case .Iphone6_7?:
            self.pageDistance = 51.0
        case .Iphone6_7_plus?, .IphoneX?:
            self.pageDistance = 61.5
        case .IpadMini_Air?:
            self.pageDistance = 102.5
        case .IpadPro10_5?:
            self.pageDistance = 106.5
        case .IpadPro12_9?:
            self.pageDistance = 112.75
        default:
            self.pageDistance = 0
        }
        self.pageControl.numberOfPages = self.viewModel.numberOfCells()
        self.nextButton.isEnabled = false
        self.nextPageDistance = self.pageDistance
        self.minDistance = 0
        self.maxDistance = self.pageDistance * (CGFloat(self.viewModel.numberOfCells()) - 1) * 2
        self.lastContentOffset = 0
       
    }
    private func updateConstraints() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .Iphone5?:
            self.collectionViewTopConstraint.constant = 0
            self.containerViewBottomContstraint.constant = 0
            self.pageControllBottomConstraint.constant = 0
        case .IpadMini_Air?:
            self.collectionViewHeightConstraint = NSLayoutConstraint.changeMultiplier(self.collectionViewHeightConstraint, multiplier: 0.4)
            self.containerViewTopConstraint.constant = 160
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.05)
        case .IpadPro10_5?:
            self.collectionViewHeightConstraint = NSLayoutConstraint.changeMultiplier(self.collectionViewHeightConstraint, multiplier: 0.4)
            self.containerViewTopConstraint.constant = 190
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.05)
        case .IpadPro12_9?:
            self.collectionViewHeightConstraint = NSLayoutConstraint.changeMultiplier(self.collectionViewHeightConstraint, multiplier: 0.4)
            self.containerViewTopConstraint.constant = 280
            self.titleLabelHeightConstraint = NSLayoutConstraint.changeMultiplier(self.titleLabelHeightConstraint, multiplier: 0.045)
        default: return
        }
        self.view.updateConstraintsIfNeeded()
    }
    private func setupChildController() {
        self.childController = self.childViewControllers[0] as! AlcoholChildVC
        self.childController.viewModel = self.viewModel.setChildViewModel()
    }
    private func setupCollectionView() {
        
        let collectionViewCellHeight : CGFloat
        let collectionViewCellWidth : CGFloat
        
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .Iphone5?:
            collectionViewCellHeight = 0.32
            collectionViewCellWidth = 0.22
        case .Iphone6_7?:
            collectionViewCellHeight = 0.35
            collectionViewCellWidth = 0.25
        case .Iphone6_7_plus?, .IphoneX?:
            collectionViewCellHeight = 0.45
            collectionViewCellWidth = 0.30
        case .IpadMini_Air?:
            collectionViewCellHeight = 0.60
            collectionViewCellWidth = 0.50
        case .IpadPro10_5?:
            collectionViewCellHeight = 0.65
            collectionViewCellWidth = 0.52
        case .IpadPro12_9?:
            collectionViewCellHeight = 0.68
            collectionViewCellWidth = 0.55
        default:
            collectionViewCellHeight = 0
            collectionViewCellWidth = 0
        }
        
        
        let gravityLayoutSlider = GravitySliderFlowLayout(with: CGSize(width: self.collectionView.frame.size.height * collectionViewCellWidth,
                                                                       height: self.collectionView.frame.size.height * collectionViewCellHeight))
        self.collectionView.collectionViewLayout = gravityLayoutSlider
    }
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(alcoholCountDidChange(notification:)), name: Notification.Name.alcoholCountDidChange, object: nil)
    }
    @objc private func alcoholCountDidChange(notification: Notification) {
        guard let userInfo = notification.userInfo,
            let alcCount = userInfo["count"] as? Int
            else {
                return
            }
        switch alcCount {
        case 0: self.nextButton.isEnabled = false
        case 1...: self.nextButton.isEnabled = true
        default: return
        }
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
    func setAlcohol(tuple: AlcTuple) {
        let cell = self.collectionView.cellForItem(at: tuple.indexPath) as! AlcoholCell
        let storeDefaultText = cell.alcPercentLabel.text
        cell.alcPercentLabel.text = tuple.percentage
        let alcImageView = UIImageView.init(frame: cell.contentView.frame)
        let newImage = UIImage.mergeLayer(andView: cell)
        alcImageView.image = newImage
        cell.alcPercentLabel.text = storeDefaultText
        self.childController.calculateFrameFor(alcoholImageView: alcImageView)
        self.childController.viewModel.addAlcohol(tuple: tuple)
    }
    
    @IBAction func nextButtonAction(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultVC = segue.destination as? ResultVC {
            resultVC.viewModel = self.childController.viewModel.setResultViewModel()
        }
    }
 
}

extension AlcoholVC {
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.x <= self.minDistance {
            self.nextPageDistance = self.pageDistance
            self.currentPage = 1
            self.pageControl.currentPage = 0
        }
        else if scrollView.contentOffset.x >= self.maxDistance {
            self.currentPage = self.viewModel.numberOfCells()
            self.pageControl.currentPage = self.viewModel.numberOfCells()
        }
        else if scrollView.contentOffset.x > self.lastContentOffset && scrollView.contentOffset.x > self.nextPageDistance && scrollView.contentOffset.x < self.maxDistance && self.pageControl.currentPage != self.currentPage {
            self.pageControl.currentPage += 1
            self.currentPage += 1
            self.nextPageDistance = self.nextPageDistance + self.pageDistance * 2
        }
        else if scrollView.contentOffset.x < self.lastContentOffset && scrollView.contentOffset.x + self.pageDistance * 2 < self.nextPageDistance && scrollView.contentOffset.x < self.maxDistance && self.pageControl.currentPage != self.currentPage {
            
            self.pageControl.currentPage -= 1
            self.currentPage -= 1
            self.nextPageDistance = self.nextPageDistance - self.pageDistance * 2
        }
        self.lastContentOffset = scrollView.contentOffset.x
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.x
    }
    
}
