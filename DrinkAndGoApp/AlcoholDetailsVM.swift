//
//  AlcoholDetailsVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholDetailsViewModel : AlcTupleProtocol {
    private let maxMlLenght = 4
    private let maxOunceLenght = 3
    private let maxVolume = 3
    private var tempPercentage : String!
    private let defaultPercentage : String
    var title : String!
    let alcPercentageEdited : String!
    var indexPath : IndexPath!
    var alcDetails : AlcTuple!
    
    func filterVolume(volume: String, isOunce: Bool) -> String {
        
        let unfiltered = volume.unicodeScalars.filter { (char) -> Bool in
            return String(char).rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        }
        let volume = String(unfiltered)
        if isOunce {
           return cutVolume(volume: volume, volumeCount: maxOunceLenght)
        } else {
            return cutVolume(volume: volume, volumeCount: maxMlLenght)
        }
    }
    private func cutVolume(volume: String, volumeCount: Int) -> String {
        if volume.count <= volumeCount {
            return volume
        } else {
            let index = volume.index(volume.startIndex, offsetBy: volumeCount)
            let result = String(volume[..<index])
            return result
        }
    }
    func filterPercentage(percentage: String) -> String {
        
        let unfiltered = percentage.unicodeScalars.filter { (char) -> Bool in
            return String(char).rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
        }
        let perc = String(unfiltered)
        print(perc)
        if perc.count < maxVolume {
            guard let _ = perc.index(of: "%") else { return perc + "%" }
            let temp = perc.replacingOccurrences(of: "%", with: "")
            let result = temp + "%"
            return result
        } else {
            let temp = perc.replacingOccurrences(of: "%", with: "")
            let index = temp.index(temp.startIndex, offsetBy: maxVolume - 1)
            let result = String(temp[..<index]) + "%"
            return result
        }
    }
    func setDefaultPercentage(percentage: String?) -> String? {
        if let text = percentage {
            if text.count == 1 {
                return self.tempPercentage
            } else {
                return percentage
            }
        } else {
            return percentage
        }
    }
    func setDefaultPercentageForExit(text: String) -> String {
        if text.isEmpty {
            return self.defaultPercentage
        }
        return text.replacingOccurrences(of: "%", with: " %")
    }
    mutating func correctAlcBeforeExit(volume: String?, percentage: String?, isOunce: Bool, indexPath: IndexPath) -> AlcTuple {
        if let perc = percentage {
            if perc.isEmpty {
                self.alcDetails = AlcTuple(volume: volume, percentage: self.defaultPercentage, isOunce: isOunce,indexPath: indexPath)
            } else {
                self.alcDetails = AlcTuple(volume: volume, percentage: perc.replacingOccurrences(of: "%", with: " %"), isOunce: isOunce,indexPath: indexPath)
            }
        }
        
        return self.alcDetails
    }
    init(alcTitle: String, alcPercentage: String, indexPath: IndexPath) {
        self.title = alcTitle
        self.defaultPercentage = alcPercentage
        self.alcPercentageEdited = alcPercentage + ". Tap here to correct"
        self.tempPercentage = alcPercentage.replacingOccurrences(of: " ", with: "")
        self.indexPath = indexPath
    }
}
