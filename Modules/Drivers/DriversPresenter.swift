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
    @Published var data = Data()
    
    var offset: Int = 0
    
    
    var interactor: DriversInteractorInputProtocol? { return super.baseInteractor as? DriversInteractorInputProtocol}
    
    func fetchDrivers(){
        self.interactor?.fetchDataDriversInteractor(offset: "\(offset)")
    }
    
    func getImageFromUrl(){
        guard let url = URL(string: "https://loremflickr.com/100/100/people") else {return}
        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
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
