//
//  weightVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 30.12.17.
//  Copyright © 2017 VasiliyEgorov. All rights reserved.
//

import Foundation

struct WeightViewModel {
    private var model : Interview
    private let lbsInKg = 0.45
    private let defaultWomanKgSelectedRow = "70"
    private let defaultMensKgSelectedRow = "90"
    private let defaultWomanLbsSelectedRow = "154.3"
    private let defaultMensLbsSelectedRow = "198.4"
    private let womanWeightKg = [["45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100"], ["Kg"]]
    private let womanWeightLbs = [["99.2", "101.4", "103.6", "105.8", "108", "110.2", "112.5", "114.7", "116.8", "119", "121.3", "123.5", "125.7", "127.9", "130.1", "132.3", "134.5", "136.7", "138.9", "141.1", "143.3", "145.5", "147.7", "150", "152.1", "154.3", "156.5", "158.7", "161", "163.2", "165.4", "167.6", "169.8", "172", "174.2", "176.4", "178.6", "180.8", "183", "185.2", "187.4", "189.6", "191.8", "194", "196.2", "198.4", "200.6", "202.8", "205", "207.3", "209.5", "211.7", "213.9", "216", "218.3", "220.5"], ["Lbs"]]
    private let mensWeightKg = [["60", "61", "62", "63", "64", "65", "66", "67", "68", "69", "70", "71", "72", "73", "74", "75", "76", "77", "78", "79", "80", "81", "82", "83", "84", "85", "86", "87", "88", "89", "90", "91", "92", "93", "94", "95", "96", "97", "98", "99", "100", "101", "102", "103", "104", "105", "106", "107", "108", "109", "110", "111", "112", "113", "114", "115", "116", "117", "118", "119", "120"], ["Kg"]]
    private let mensWeightLbs = [["132.3", "134.5", "136.7", "138.9", "141.1", "143.3", "145.5", "147.7", "150", "152.1", "154.3", "156.5", "158.7", "161", "163.2", "165.4", "167.6", "169.8", "172", "174.2", "176.4", "178.6", "180.8", "183", "185.2", "187.4", "189.6", "191.8", "194", "196.2", "198.4", "200.6", "202.8", "205", "207.3", "209.5", "211.7", "213.9", "216", "218.3", "220.5", "222.7", "224.9", "227.1", "229.3", "231.5", "233.7", "236", "238.1", "240.3", "242.5", "244.7", "253.5", "255.7", "258", "260.2", "262.4", "264.5"], ["Lbs"]]
    private var heightViewModel : HeightViewModel!
    var weight : Int!
    
    mutating func setDefaultRow(isLbs: Bool) -> Int {
        switch (model.gender, isLbs) {
        case (.Male, false):
            self.weight = Int(defaultMensKgSelectedRow)
            return self.mensWeightKg[0].index(of: defaultMensKgSelectedRow)!
        case (.Male, true):
            self.weight = Int(defaultMensLbsSelectedRow)
            return self.mensWeightLbs[0].index(of: defaultMensLbsSelectedRow)!
        case (.Female, false):
            self.weight = Int(defaultWomanKgSelectedRow)
            return self.womanWeightKg[0].index(of: defaultWomanKgSelectedRow)!
        case (.Female, true):
            self.weight = Int(defaultWomanLbsSelectedRow)
            return self.womanWeightLbs[0].index(of: defaultWomanLbsSelectedRow)!
        default: return 0
        }
    }
    func numberOfRowsInComponent(component: Int, isLbs: Bool) -> Int {
        switch (model.gender, isLbs) {
        case (.Male, false): return self.mensWeightKg[component].count
        case (.Male, true): return self.mensWeightLbs[component].count
        case (.Female, false): return self.womanWeightKg[component].count
        case (.Female, true): return self.womanWeightLbs[component].count
        default: return 0
        }
    }
    func numberOfComponents() -> Int {
        return 2
    }
    func titleForRow(row: Int, component: Int, isLbs: Bool) -> String? {
        switch (model.gender, isLbs) {
        case (.Male, false): return self.mensWeightKg[component][row]
        case (.Male, true): return self.mensWeightLbs[component][row]
        case (.Female, false): return self.womanWeightKg[component][row]
        case (.Female, true): return self.womanWeightLbs[component][row]
        default: return nil
        }
    }
    mutating func getSelectedRow(row: Int, component: Int, isLbs: Bool) {
        switch (model.gender, isLbs) {
        case (.Male, false): self.weight = Int(self.mensWeightKg[component][row])
        case (.Male, true): self.weight = convertLbsToKg(lbsString: self.mensWeightLbs[component][row])
        case (.Female, false): self.weight = Int(self.womanWeightKg[component][row])
        case (.Female, true): self.weight = convertLbsToKg(lbsString: self.womanWeightLbs[component][row])
        default: return
        }
    }
    private func convertLbsToKg(lbsString: String) -> Int {
        let result = Double(lbsString)! / self.lbsInKg
        return Int(result)
    }
    mutating func setHeightViewModel() -> HeightViewModel {
        self.heightViewModel = HeightViewModel.init(model: self.model)
        return self.heightViewModel
    }
    init(model: Interview) {
        self.model = model
    }
}
