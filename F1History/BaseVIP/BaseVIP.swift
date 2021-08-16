//
//  BaseVIP.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation

protocol BaseInteractorInputProtocol: AnyObject{
    
}

protocol BaseInteractorOutputProtocol: AnyObject {
    
}

class BasePresenter{
    internal var baseInteractor: BaseInteractorInputProtocol?
    required init() {}
}

class BaseInteractor{
    internal weak var basePresenter: BaseInteractorOutputProtocol?
    required init() {}
}

class BaseCoordinator{
    
    static func assembly<Presenter: BasePresenter, Interactor: BaseInteractor>(presenter: Presenter.Type, interactor: Interactor.Type?) -> (presenter: Presenter, interactor: Interactor){
        let basePresenter = Presenter()
        let baseInteractor = Interactor()
        basePresenter.baseInteractor = baseInteractor as? BaseInteractorInputProtocol
        baseInteractor.basePresenter = basePresenter as? BaseInteractorOutputProtocol
        return (basePresenter, baseInteractor)
    }
}
