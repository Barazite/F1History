//
//  ConstructorPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import Foundation

protocol ConstructorsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func constructorsFromInteractor(data: [Constructor], total: Int, limit: Int)
}

class ConstructorsPresenterImpl: BasePresenter, ObservableObject{
    
    @Published var arrayConstructors: [Constructors] = []
    @Published var finalList: Bool = false
    @Published var data = Data()
    
    var offset: Int = 0
    
    
    var interactor: ConstructorsInteractorInputProtocol? { return super.baseInteractor as? ConstructorsInteractorInputProtocol}
    
    func fetchConstructors(){
        self.interactor?.fetchDataConstructorsInteractor(offset: "\(offset)")
    }
}

extension ConstructorsPresenterImpl: ConstructorsInteractorOutputProtocol{
    func constructorsFromInteractor(data: [Constructor], total: Int, limit: Int){
        self.arrayConstructors.append(contentsOf: data.map{ Constructors(businessModel: $0) })
        self.offset += limit
        if self.arrayConstructors.count == total{
            finalList = true
        }
    }
}
