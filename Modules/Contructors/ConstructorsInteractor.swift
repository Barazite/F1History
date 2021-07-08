//
//  ConstructorsInteractor.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import Foundation

protocol ConstructorsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataConstructorsInteractor(offset: String)
}

class ConstructorsInteractorImpl: BaseInteractor{
    weak var presenter: ConstructorsInteractorOutputProtocol? { return super.basePresenter as? ConstructorsInteractorOutputProtocol}
    var provider: ConstructorsProviderProtocol = ConstructorsProviderImpl()
}

extension ConstructorsInteractorImpl: ConstructorsInteractorInputProtocol{
    func fetchDataConstructorsInteractor(offset: String) {
            self.provider.fetchConstructors(offset: offset){ [weak self] (result) in
                guard self != nil else { return }
                switch result{
                case .success(let response):
                    self?.presenter?.constructorsFromInteractor(data: response.mrData?.constructorTable?.constructors ?? [], total: (response.mrData?.total as! NSString).integerValue, limit: (response.mrData?.limit as! NSString).integerValue)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
}
