//
//  CircuitsProvider.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation
import Combine

protocol CircuitsProviderProtocol {
    func fetchCircuits(offset: String, completionHandler: @escaping (Result<CircuitsServerModel, NetworkingError>) -> ())
}

class CircuitsProviderImpl: CircuitsProviderProtocol{
    let provider: RequestManagerProtocol = RequestManager()
    var cancellable: Set<AnyCancellable> = []
    
    internal func fetchCircuits(offset: String, completionHandler: @escaping (Result<CircuitsServerModel, NetworkingError>) -> ()) {
            
        let aux: [CVarArg] = [offset]
        let endpointComplete = String(format: URLEndpoint.endpointCircuits, arguments: aux)
        let request = RequestDTO(params: nil,
                                 method: .get,
                                 endpoint: URLEndpoint.baseUrl+endpointComplete)
        
        self.provider.requestGeneric(requestDto: request, entityClass: CircuitsServerModel.self)
            .sink { [weak self] (completion) in
                guard self != nil else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    completionHandler(.failure(error))
                }
            } receiveValue: { [weak self] response in
                guard self != nil else { return }
                completionHandler(.success(response))
            }.store(in: &cancellable)
    }
}
