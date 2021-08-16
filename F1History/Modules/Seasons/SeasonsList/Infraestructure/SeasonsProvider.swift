//
//  SeasonsProvider.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation
import Combine

protocol SeasonsProviderProtocol {
    func fetchSeasons(offset: String, completionHandler: @escaping (Result<SeasonsServerModel, NetworkingError>) -> ())
}

class SeasonsProviderImpl: SeasonsProviderProtocol{
    let provider: RequestManagerProtocol = RequestManager()
    var cancellable: Set<AnyCancellable> = []
    
    internal func fetchSeasons(offset: String, completionHandler: @escaping (Result<SeasonsServerModel, NetworkingError>) -> ()) {
            
        let aux: [CVarArg] = [offset]
        let endpointComplete = String(format: URLEndpoint.endpointSeasons, arguments: aux)
        let request = RequestDTO(params: nil,
                                 method: .get,
                                 endpoint: URLEndpoint.baseUrl+endpointComplete)
        
        self.provider.requestGeneric(requestDto: request, entityClass: SeasonsServerModel.self)
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
