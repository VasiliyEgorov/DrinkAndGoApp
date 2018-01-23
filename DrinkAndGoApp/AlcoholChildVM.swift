//
//  AlcoholChildVM.swift
//  DrinkAndGoApp
//
//  Created by Vasiliy Egorov on 18.01.2018.
//  Copyright © 2018 VasiliyEgorov. All rights reserved.
//

import Foundation

protocol ResultsTupleProtocol {
    typealias ResultsTuple = (volume: Int, percentage: Int, isOunce: Bool)
}

struct AlcoholChildViewModel : AlcTupleProtocol, ResultsTupleProtocol {
    
    private var model: Interview
    private var alcCollection = [ResultsTuple]()
    private var resultViewModel : ResultViewModel!
    private var alcImagesArray = [Data]()
    
    func numberOfCells() -> Int {
        return self.alcImagesArray.count
    }
    mutating func removeItemAt(index: Int) {
        self.alcImagesArray.remove(at: index)
        self.alcCollection.remove(at: index)
    }
    mutating func addNewImage(image: Data?) {
        if let data = image {
        self.alcImagesArray.append(data)
        }
    }
    func setImageToCellAt(index: Int) -> Data {
        return self.alcImagesArray[index]
    }
    mutating func addAlcohol(tuple: AlcTuple) {
        if let vol = tuple.volume, let perc = tuple.percentage {
            let res = perc.replacingOccurrences(of: " %", with: "")
            if let volInt = Int(vol), let percInt = Int(res) {
                self.alcCollection.append((volInt, percInt, tuple.isOunce))
            }
        }
    }
    mutating func setResultViewModel() -> ResultViewModel {
        self.resultViewModel = ResultViewModel.init(model: self.model, alcList: self.alcCollection)
        return self.resultViewModel
    }
    init(model: Interview) {
        self.model = model
    }
}
