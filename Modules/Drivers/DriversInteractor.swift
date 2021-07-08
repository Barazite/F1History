//
//  DriversInteractor.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import Foundation

protocol DriversInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataDriversInteractor(offset: String)
}

class DriversInteractorImpl: BaseInteractor{
    weak var presenter: DriversInteractorOutputProtocol? { return super.basePresenter as? DriversInteractorOutputProtocol}
    var provider: DriversProviderProtocol = DriversProviderImpl()
}

extension DriversInteractorImpl: DriversInteractorInputProtocol{
    func fetchDataDriversInteractor(offset: String) {
            self.provider.fetchDrivers(offset: offset){ [weak self] (result) in
                guard self != nil else { return }
                switch result{
                case .success(let response):
                    self?.presenter?.driversFromInteractor(data: response.mrData?.driverTable?.drivers ?? [], total: (response.mrData?.total as! NSString).integerValue, limit: (response.mrData?.limit as! NSString).integerValue)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
}
