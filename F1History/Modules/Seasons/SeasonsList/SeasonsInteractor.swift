//
//  SeasonsInteractor.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation

protocol SeasonsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchDataSeasonsInteractor(offset: String)
}

class SeasonsInteractorImpl: BaseInteractor{
    weak var presenter: SeasonsInteractorOutputProtocol? { return super.basePresenter as? SeasonsInteractorOutputProtocol}
    var provider: SeasonsProviderProtocol = SeasonsProviderImpl()
}

extension SeasonsInteractorImpl: SeasonsInteractorInputProtocol{
    func fetchDataSeasonsInteractor(offset: String) {
            self.provider.fetchSeasons(offset: offset){ [weak self] (result) in
                guard self != nil else { return }
                switch result{
                case .success(let response):
                    self?.presenter?.seasonsFromInteractor(data: response.mrData?.seasonTable?.seasons ?? [], total: ((response.mrData?.total!)! as NSString).integerValue, limit: ((response.mrData?.limit!)! as NSString).integerValue)
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                }
            }
        }
}
