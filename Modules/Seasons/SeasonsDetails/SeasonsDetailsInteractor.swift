//
//  SeasonsDetailsInteractor.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation
import Alamofire

protocol SeasonsDetailsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchSchedulesInteractor(season: String)
    func fetchDriversInteractor(season: String)
    func fetchConstructorsInteractor(season: String)
}

class SeasonsDetailsInteractorImpl: BaseInteractor{
    weak var presenter: SeasonsDetailsInteractorOutputProtocol? { return super.basePresenter as? SeasonsDetailsInteractorOutputProtocol}
}

extension SeasonsDetailsInteractorImpl: SeasonsDetailsInteractorInputProtocol{
    func fetchDriversInteractor(season: String) {
        let aux: [CVarArg] = [season]
        let endpointComplete = String(format: URLEndpoint.endpointDriverStandings, arguments: aux)
        
        AF.request(URLEndpoint.baseUrl+endpointComplete).responseDecodable(of: DriverStandingsServerModel.self){ response in
            guard let driversResponse = response.value else
            {
                return
            }
            self.presenter?.driversFromInteractor(data: driversResponse.mrData?.standingsTable?.standingsLists?.first?.driverStandings ?? [])
        }
    }
    
    func fetchConstructorsInteractor(season: String) {
        let aux: [CVarArg] = [season]
        let endpointComplete = String(format: URLEndpoint.endpointConstructorStandings, arguments: aux)
        
        AF.request(URLEndpoint.baseUrl+endpointComplete).responseDecodable(of: ConstructorsStandingsServerModel.self){ response in
            guard let constructorsResponse = response.value else
            {
                return
            }
            self.presenter?.constructorsFromInteractor(data: constructorsResponse.mrData?.standingsTable?.standingsLists?.first?.constructorStandings ?? [])
        }
    }
    
    func fetchSchedulesInteractor(season: String) {
        let aux: [CVarArg] = [season]
        let endpointComplete = String(format: URLEndpoint.endpointSchedule, arguments: aux)
        
        AF.request(URLEndpoint.baseUrl+endpointComplete).responseDecodable(of: SchedulesServerModel.self){ response in
            guard let scheduleResponse = response.value else
            {
                return
            }
            self.presenter?.scheduleFromInteractor(data: scheduleResponse.mrData?.raceTable?.races ?? [])
        }
    }
    
    
}
