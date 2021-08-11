//
//  DriversPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import Foundation

protocol DriversInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func driversFromInteractor(data: [Driver], total: Int, limit: Int)
}

class DriversPresenterImpl: BasePresenter, ObservableObject{
    
    @Published var arrayDrivers: [Drivers] = []
    @Published var finalList: Bool = false
    
    var offset: Int = 0
    
    
    var interactor: DriversInteractorInputProtocol? { return super.baseInteractor as? DriversInteractorInputProtocol}
    
    func fetchDrivers(){
        self.interactor?.fetchDataDriversInteractor(offset: "\(offset)")
    }
}

extension DriversPresenterImpl: DriversInteractorOutputProtocol{
    func driversFromInteractor(data: [Driver], total: Int, limit: Int){
        self.arrayDrivers.append(contentsOf: data.map{ Drivers(businessModel: $0) })
        self.offset += limit
        if self.arrayDrivers.count == total{
            finalList = true
        }
    }
}
