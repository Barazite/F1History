//
//  SeasonsPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation

protocol SeasonsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func seasonsFromInteractor(data: [Season], total: Int, limit: Int)
}

class SeasonsPresenterImpl: BasePresenter, ObservableObject{
    
    @Published var arraySeasons: [Seasons] = []
    @Published var finalList: Bool = false
    
    var offset: Int = 0
    
    
    var interactor: SeasonsInteractorInputProtocol? { return super.baseInteractor as? SeasonsInteractorInputProtocol}
    
    func fetchSeasons(){
        self.interactor?.fetchDataSeasonsInteractor(offset: "\(offset)")
    }
}

extension SeasonsPresenterImpl: SeasonsInteractorOutputProtocol{
    func seasonsFromInteractor(data: [Season], total: Int, limit: Int){
        self.arraySeasons.append(contentsOf: data.map{ Seasons(businessModel: $0) })
        self.offset += limit
        if self.arraySeasons.count == total{
            finalList = true
        }
    }
}
