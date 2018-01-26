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
    private let staticDistance = { () -> CGFloat in
        let device = Device(rawValue: UIScreen.main.bounds.size.height)!
        switch device {
        case .Iphone5: return 74.5
        case .Iphone6_7: return 0
        case .Iphone6_7_plus: return 0
        case .IphoneX: return 0
        }
    }
    private var lastContentOffset : CGFloat!
    private var actualDistance : CGFloat!
    private var minDistance : CGFloat!
    private var maxDistance : CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMisc()
        updateConstraints()
        setupCollectionView()
        setupChildController()
        setupNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    // MARK: - Setup
    private func setupMisc() {
        self.pageControl.numberOfPages = self.viewModel.numberOfCells()
        self.nextButton.isEnabled = false
        self.actualDistance = self.staticDistance()
        self.minDistance = 0
        self.maxDistance = self.staticDistance() * (CGFloat(self.viewModel.numberOfCells()) - 1)
        self.lastContentOffset = 0
    }
    private func updateConstraints() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .Iphone5?:
            self.collectionViewTopConstraint.constant = 0
            self.containerViewBottomContstraint.constant = 0
            self.pageControllBottomConstraint.constant = 0
            self.view.updateConstraintsIfNeeded()
        default: return
        }
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
            collectionViewCellHeight = 0.55
            collectionViewCellWidth = 0.35
        default:
            collectionViewCellHeight = 0.85
            collectionViewCellWidth = 0.55
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
            self.actualDistance = self.staticDistance()
            self.lastContentOffset = self.minDistance
            pageControl.currentPage = 0
        }
        else if scrollView.contentOffset.x >= self.maxDistance {
            self.actualDistance = self.maxDistance
            self.lastContentOffset = self.maxDistance
            pageControl.currentPage = self.viewModel.numberOfCells()
        }
        else if scrollView.contentOffset.x > self.lastContentOffset && scrollView.contentOffset.x >= self.actualDistance {
            pageControl.currentPage += 1
            self.actualDistance = self.actualDistance + self.staticDistance()
            self.lastContentOffset = scrollView.contentOffset.x
        }
        else if scrollView.contentOffset.x < self.lastContentOffset && scrollView.contentOffset.x <= self.actualDistance {
            pageControl.currentPage -= 1
            self.actualDistance = self.actualDistance - self.staticDistance()
            self.lastContentOffset = scrollView.contentOffset.x
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.x
    }
    
}
