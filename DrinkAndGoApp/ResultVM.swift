//
//  ResultVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 17.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation


struct ResultViewModel : ResultsTupleProtocol {
    private var model : Interview
    private var alcList : [ResultsTuple]!
    private let mlInOunce = 29.57
    private let eliminationRate = 0.15
    private var seconds : Int!
    private var circularViewModel : CircularViewModel!
    
    private mutating func calculateWithWidmarkFormula() {
      
        var genderCoefficient : Double
        
        switch self.model.gender {
        case .Male: genderCoefficient = 0.7
        case .Female: genderCoefficient = 0.6
        default: genderCoefficient = 0.7
        }
        
        if self.model.didEat {
            genderCoefficient -= 0.1
        }
        var alcConcentrationOverall = 0.0
        var heightCoefficient : Double
        
        switch self.model.height {
        case 145...160: heightCoefficient = 0.9
        case 160...180: heightCoefficient = 0.8
        case 180...: heightCoefficient = 0.75
        default: heightCoefficient = 1.0
        }
        
        for alcohol in self.alcList {
            let volumePercHeight = Double(alcohol.volume) * (Double(alcohol.percentage) / 100) * heightCoefficient
            let kgCoeff = Double(self.model.weight) * genderCoefficient
            let widmarkFormula = volumePercHeight / kgCoeff
            alcConcentrationOverall += widmarkFormula
        }
        self.seconds = Int(alcConcentrationOverall / self.eliminationRate * 3600.0)
    }
   
    func setSecondsForTimer() -> Int {
        return self.seconds
    }
    func convertToHoursMinutesSecondsForLabel() -> String {
        let hours = self.seconds / 3600
        let minutes = (self.seconds % 3600) / 60
        let seconds = self.seconds % 60
        
        return String.init(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    private func convertOunceToMl(alcohol: [ResultsTuple]) -> [ResultsTuple] {
        var temp = [ResultsTuple]()
        for tuple in alcohol {
            if tuple.isOunce {
                let convertedVolume = round(Double(tuple.volume) * self.mlInOunce)
                temp.append((volume: Int(convertedVolume), percentage: tuple.percentage, isOunce: tuple.isOunce))
            } else {
                temp.append(tuple)
            }
        }
        return temp
    }
    
    
    mutating func setCircularViewModel() -> CircularViewModel {
        self.circularViewModel = CircularViewModel.init(seconds: self.seconds)
        return self.circularViewModel
    }
    init(model: Interview, alcList: [ResultsTuple]) {
        self.model = model
        self.alcList = convertOunceToMl(alcohol: alcList)
        calculateWithWidmarkFormula()
    }
}
