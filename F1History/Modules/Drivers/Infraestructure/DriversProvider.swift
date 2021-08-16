//
//  DriversProvider.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import Foundation
import Combine

protocol DriversProviderProtocol {
    func fetchDrivers(offset: String, completionHandler: @escaping (Result<DriversServerModel, NetworkingError>) -> ())
}

class DriversProviderImpl: DriversProviderProtocol{
    let provider: RequestManagerProtocol = RequestManager()
    var cancellable: Set<AnyCancellable> = []
    
    internal func fetchDrivers(offset: String, completionHandler: @escaping (Result<DriversServerModel, NetworkingError>) -> ()) {
            
        let aux: [CVarArg] = [offset]
        let endpointComplete = String(format: URLEndpoint.endpointDrivers, arguments: aux)
        let request = RequestDTO(params: nil,
                                 method: .get,
                                 endpoint: URLEndpoint.baseUrl+endpointComplete)
        
        self.provider.requestGeneric(requestDto: request, entityClass: DriversServerModel.self)
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
