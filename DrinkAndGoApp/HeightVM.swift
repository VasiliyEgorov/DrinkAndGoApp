//
//  HeightVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 23.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct HeightViewModel {
    
    private var model : Interview
    private let ftInCm = 30.48
    private let inchInCm = 2.54
    private let womanHeightCmSelectedRow = "170"
    private let womanHeightFtSelectedRow = "5' 7"
    private let mensHeightCmSelectedRow = "185"
    private let mensHeightFtSelectedRow = "6' 1"
    private let womanHeightCm = [["149", "150", "151", "152", "153", "154", "155", "156", "157", "158", "159", "160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190"], ["Cm"]]
    private let womanHeightFt = [["4' 11", "5' 0", "5' 1", "5' 2", "5' 3", "5' 4", "5' 5", "5' 6", "5' 7", "5' 8", "5' 9", "5' 10", "5' 11", "6' 0", "6' 1", "6' 2", "6' 3"], ["Ft/Inch"]]
    private let mensHeightCm = [["160", "161", "162", "163", "164", "165", "166", "167", "168", "169", "170", "171", "172", "173", "174", "175", "176", "177", "178", "179", "180", "181", "182", "183", "184", "185", "186", "187", "188", "189", "190", "191", "192", "193", "194", "195", "196", "197", "198", "199", "200", "201", "202", "203", "204", "205", "206", "207"], ["Cm"]]
    private let mensHeightFt = [["5' 3", "5' 4", "5' 5", "5' 6", "5' 7", "5' 8", "5' 9", "5' 10", "5' 11", "6' 0", "6' 1", "6' 2", "6' 3", "6' 4", "6' 5", "6' 6", "6' 7", "6' 8", "6' 9"], ["Ft/Inch"]]
    
    private var alcoholViewModel : AlcoholViewModel!
    
    mutating func setDefaultRow(isFt: Bool) -> Int {
        switch (model.gender, isFt) {
        case (.Male, false):
            self.model.height = Int(mensHeightCmSelectedRow)
            return self.mensHeightCm[0].index(of: mensHeightCmSelectedRow)!
        case (.Male, true):
            self.model.height = convertFtToCm(ftString: mensHeightFtSelectedRow)
            return self.mensHeightFt[0].index(of: mensHeightFtSelectedRow)!
        case (.Female, false):
            self.model.height = Int(womanHeightCmSelectedRow)
            return self.womanHeightCm[0].index(of: womanHeightCmSelectedRow)!
        case (.Female, true):
            self.model.height = convertFtToCm(ftString: womanHeightFtSelectedRow)
            return self.womanHeightFt[0].index(of: womanHeightFtSelectedRow)!
        default: return 0
        }
    }
    func numberOfRowsInComponent(component: Int, isFt: Bool) -> Int {
        switch (model.gender, isFt) {
        case (.Male, false): return self.mensHeightCm[component].count
        case (.Male, true): return self.mensHeightFt[component].count
        case (.Female, false): return self.womanHeightCm[component].count
        case (.Female, true): return self.womanHeightFt[component].count
        default: return 0
        }
    }
    func numberOfComponents() -> Int {
        return 2
    }
    func titleForRow(row: Int, component: Int, isFt: Bool) -> String? {
        switch (model.gender, isFt) {
        case (.Male, false): return self.mensHeightCm[component][row]
        case (.Male, true): return self.mensHeightFt[component][row]
        case (.Female, false): return self.womanHeightCm[component][row]
        case (.Female, true): return self.womanHeightFt[component][row]
        default: return nil
        }
    }
    mutating func getSelectedRow(row: Int, component: Int, isFt: Bool) {
        switch (model.gender, isFt) {
        case (.Male, false): self.model.height = Int(self.mensHeightCm[component][row])
        case (.Male, true): self.model.height = convertFtToCm(ftString: self.mensHeightFt[component][row])
        case (.Female, false): self.model.height = Int(self.womanHeightCm[component][row])
        case (.Female, true): self.model.height = convertFtToCm(ftString: self.womanHeightFt[component][row])
        default: return
        }
    }
    private func convertFtToCm(ftString: String) -> Int {
        
        let onlyNumbers = ftString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let firstLetter = onlyNumbers.index(ftString.startIndex, offsetBy: 0)
        let secondLetter = onlyNumbers.index(ftString.startIndex, offsetBy: 1)
        let ft = String(onlyNumbers[firstLetter])
        let inch = String(onlyNumbers[secondLetter...])
        
        if let doubleFt = Double(ft), let doubleInch = Double(inch) {
            let result = (doubleFt * self.ftInCm) + (doubleInch * self.inchInCm)
            return Int(round(result))
        } else {
            return 0
        }
    }
    mutating func setAlcoholViewModel() -> AlcoholViewModel {
        self.alcoholViewModel = AlcoholViewModel.init(model: self.model)
        return self.alcoholViewModel
    }
    mutating func setWeightForModel(weight: Int) {
        self.model.weight = weight
    }
    init(model: Interview) {
        self.model = model
    }
}
