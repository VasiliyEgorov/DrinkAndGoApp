//
//  AlcoholDetailsVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholDetailsViewModel {
    private let maxMlLenght = 4
    private let maxOunceLenght = 5
    private let maxVolume = 3
    var title : String!
    var alcPercentage : String!
    var indexPath : IndexPath!
    func filterVolume(volume: String, isOunce: Bool) -> String {
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
        if percentage.count < maxVolume {
            guard let _ = percentage.index(of: "%")
                else {
                    switch percentage.count {
                    case 1:  return percentage + "%"
                    default: return percentage
                    }
            }
            let temp = percentage.replacingOccurrences(of: "%", with: "")
            let result = temp + "%"
            return result
        } else {
            let temp = percentage.replacingOccurrences(of: "%", with: "")
            let index = temp.index(temp.startIndex, offsetBy: maxVolume - 1)
            let result = String(temp[..<index]) + "%"
            return result
        }
    }
    func setDefaultPercentage(percentage: String) -> String {
        if percentage.count == 1 {
            return self.alcPercentage
        } else {
            return percentage
        }
    }
    init(alcTitle: String, alcPercentage: String, indexPath: IndexPath) {
        self.title = alcTitle
        self.alcPercentage = alcPercentage + ". Tap here to correct"
        self.indexPath = indexPath
    }
}
