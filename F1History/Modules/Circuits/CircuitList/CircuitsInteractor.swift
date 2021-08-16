//
//  CircuitsInteractor.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation

protocol CircuitsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataCircuitsInteractor(offset: String)
}

class CircuitsInteractorImpl: BaseInteractor{
    weak var presenter: CircuitsInteractorOutputProtocol? { return super.basePresenter as? CircuitsInteractorOutputProtocol}
    var provider: CircuitsProviderProtocol = CircuitsProviderImpl()
}

extension CircuitsInteractorImpl: CircuitsInteractorInputProtocol{
    func fetchDataCircuitsInteractor(offset: String) {
            self.provider.fetchCircuits(offset: offset){ [weak self] (result) in
                guard self != nil else { return }
                switch result{
                case .success(let response):
                    self?.presenter?.circuitsFromInteractor(data: response.mrData?.circuitTable?.circuits ?? [], total: ((response.mrData?.total!)! as NSString).integerValue, limit: ((response.mrData?.limit!)! as NSString).integerValue)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
}
