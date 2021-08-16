//
//  RequestManager.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation
import Combine

protocol RequestManagerProtocol: AnyObject {
    func requestGeneric<T: Decodable>(requestDto: RequestDTO, entityClass: T.Type) -> AnyPublisher<T, NetworkingError>
}

class RequestManager: RequestManagerProtocol {
    
    internal func requestGeneric<T: Decodable>(requestDto: RequestDTO, entityClass: T.Type) -> AnyPublisher<T, NetworkingError>{
        
        let endpoint = requestDto.endpoint
        let urlRequest = URLRequest(url: URL(string: endpoint)!)
        
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .mapError{ (error) -> NetworkingError in
                NetworkingError(error: error)
            }
            .flatMap { data, response -> AnyPublisher<T, NetworkingError> in
                guard let httpResponse = response as? HTTPURLResponse else {
                    return Fail(error: NetworkingError(status: .badRequest)).eraseToAnyPublisher()
                }
                if (200...299).contains(httpResponse.statusCode){
                    return Just(data)
                        .decode(type: T.self, decoder: JSONDecoder())
                        .mapError { error  in
                            NetworkingError(status: .accepted)
                        }
                        .eraseToAnyPublisher()//Libera la memoria
                } else {
                    let error = ApiError.unknow
                    return Fail(error: NetworkingError(error: error)).eraseToAnyPublisher()
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
