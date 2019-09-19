//
//  AlcoholVC.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 02.01.18.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import UIKit

class AlcoholVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AlcoholDetailsDelegate {
    
    @IBOutlet weak var titleLabelHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomContstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel : AlcoholViewModel!
    private let cellID = "AlcoholCell"
    private let segueID = "CompleteSegue"
    private var childController : AlcoholChildVC!
    private var cellHeight : CGFloat!
    private var cellWidth : CGFloat!
    private let cellOffset : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nextButton.isEnabled = false
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
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath = IndexPath(item: 3, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    // MARK: - Setup
  
    private func updateConstraints() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .Iphone5?:
            self.collectionViewTopConstraint.constant = 0
            self.containerViewBottomContstraint.constant = 37
          
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
        self.childController = (self.children[0] as! AlcoholChildVC)
        self.childController.viewModel = self.viewModel.setChildViewModel()
    }
    private func setupCollectionView() {
        let device = Device(rawValue: ScreenSize().size)
        switch device {
        case .IpadMini_Air?, .IpadPro10_5?, .IpadPro12_9?:
            self.cellHeight = (self.collectionView.frame.size.height) - (self.cellOffset * 2)
            self.cellWidth = self.cellHeight
        default:
            self.cellHeight = (self.collectionView.frame.size.height) - (self.cellOffset * 2)
            self.cellWidth = (self.cellHeight - (self.cellOffset * 2)) / 1.5
        }
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
   
    // MARK: - CollectionView Flow Delegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.cellWidth, height: self.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.cellOffset, left: self.cellOffset, bottom: self.cellOffset, right: self.cellOffset)
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
        self.collectionView.reloadData()
    }
}
