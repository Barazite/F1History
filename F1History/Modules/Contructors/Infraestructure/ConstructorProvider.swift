//
//  ConstructorProvider.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import Foundation
import Combine

protocol ConstructorsProviderProtocol {
    func fetchConstructors(offset: String, completionHandler: @escaping (Result<ConstructorsServerModel, NetworkingError>) -> ())
}

class ConstructorsProviderImpl: ConstructorsProviderProtocol{
    let provider: RequestManagerProtocol = RequestManager()
    var cancellable: Set<AnyCancellable> = []
    
    internal func fetchConstructors(offset: String, completionHandler: @escaping (Result<ConstructorsServerModel, NetworkingError>) -> ()) {
            
        let aux: [CVarArg] = [offset]
        let endpointComplete = String(format: URLEndpoint.endpointConstructors, arguments: aux)
        let request = RequestDTO(params: nil,
                                 method: .get,
                                 endpoint: URLEndpoint.baseUrl+endpointComplete)
        
        self.provider.requestGeneric(requestDto: request, entityClass: ConstructorsServerModel.self)
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
