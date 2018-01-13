//
//  AlcoholDetailsVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 06.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

struct AlcoholDetailsViewModel {
    private let maxMlLenght = 5
    private let maxOunceLenght = 6
    var title : String!
    var alcPercentage : String!
    
    func filterVolume(volume: String, ml: Bool) -> String {
        if ml {
           return cutVolume(volume: volume, volumeCount: maxMlLenght)
        } else {
            return cutVolume(volume: volume, volumeCount: maxOunceLenght)
        }
    }
    private func cutVolume(volume: String, volumeCount: Int) -> String {
        if volume.count <= volumeCount {
            return volume
        } else {
            let result = String(volume[..<volume.endIndex])
            return result
        }
    }
    func filterPercentage(percentage: String) -> String {
        let startRange = NSRange.init(location: 0, length: 1)
        guard let range = Range.init(startRange, in: percentage) else { return "" }
        let result = percentage.replacingCharacters(in: range, with: "%")
        return result
    }
    init(alcTitle: String, alcPercentage: String) {
        self.title = alcTitle
        self.alcPercentage = alcPercentage + " tap here to correct"
    }
}
