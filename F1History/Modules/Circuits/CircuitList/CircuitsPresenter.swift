//
//  CircuitsPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation

protocol CircuitsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func circuitsFromInteractor(data: [Circuit], total: Int, limit: Int)
}

class CircuitsPresenterImpl: BasePresenter, ObservableObject{
    
    @Published var arrayCircuits: [Circuits] = []
    @Published var finalList: Bool = false
    
    var offset: Int = 0
    
    
    var interactor: CircuitsInteractorInputProtocol? { return super.baseInteractor as? CircuitsInteractorInputProtocol}
    
    func fetchCircuits(){
        self.interactor?.fetchDataCircuitsInteractor(offset: "\(offset)")
    }
}

extension CircuitsPresenterImpl: CircuitsInteractorOutputProtocol{
    func circuitsFromInteractor(data: [Circuit], total: Int, limit: Int){
        self.arrayCircuits.append(contentsOf: data.map{ Circuits(businessModel: $0) })
        self.offset += limit
        if self.arrayCircuits.count == total{
            finalList = true
        }
    }
}
