//
//  CircuitDetailsPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 9/8/21.
//

import Foundation

protocol CircuitDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    
}

class CircuitDetailsPresenterImpl: BasePresenter, ObservableObject{
    
    var circuit: Circuits?
    
}

extension CircuitDetailsPresenterImpl: CircuitDetailsInteractorOutputProtocol{
}
