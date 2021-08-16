//
//  SeasonsDetailsInteractor.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation
import Alamofire

protocol SeasonsDetailsInteractorInputProtocol: BaseInteractorInputProtocol {
    func fetchSchedulesInteractor(season: String, offset: String)
    func fetchDriversInteractor(season: String, offset: String)
    func fetchConstructorsInteractor(season: String, offset: String)
}

class SeasonsDetailsInteractorImpl: BaseInteractor{
    weak var presenter: SeasonsDetailsInteractorOutputProtocol? { return super.basePresenter as? SeasonsDetailsInteractorOutputProtocol}
}

extension SeasonsDetailsInteractorImpl: SeasonsDetailsInteractorInputProtocol{
    func fetchDriversInteractor(season: String, offset: String) {
        let aux: [CVarArg] = [season, offset]
        let endpointComplete = String(format: URLEndpoint.endpointDriverStandings, arguments: aux)
        
        AF.request(URLEndpoint.baseUrl+endpointComplete).responseDecodable(of: DriverStandingsServerModel.self){ response in
            guard let driversResponse = response.value else
            {
                return
            }
            self.presenter?.driversFromInteractor(data: driversResponse.mrData?.standingsTable?.standingsLists?.first?.driverStandings ?? [], total: ((driversResponse.mrData?.total!)! as NSString).integerValue, limit: ((driversResponse.mrData?.limit!)! as NSString).integerValue)
        }
    }
    
    func fetchConstructorsInteractor(season: String, offset: String) {
        let aux: [CVarArg] = [season, offset]
        let endpointComplete = String(format: URLEndpoint.endpointConstructorStandings, arguments: aux)
        
        AF.request(URLEndpoint.baseUrl+endpointComplete).responseDecodable(of: ConstructorsStandingsServerModel.self){ response in
            guard let constructorsResponse = response.value else
            {
                return
            }
            self.presenter?.constructorsFromInteractor(data: constructorsResponse.mrData?.standingsTable?.standingsLists?.first?.constructorStandings ?? [], total: ((constructorsResponse.mrData?.total!)! as NSString).integerValue, limit: ((constructorsResponse.mrData?.limit!)! as NSString).integerValue)
        }
    }
    
    func fetchSchedulesInteractor(season: String, offset: String) {
        let aux: [CVarArg] = [season, offset]
        let endpointComplete = String(format: URLEndpoint.endpointSchedule, arguments: aux)
        
        AF.request(URLEndpoint.baseUrl+endpointComplete).responseDecodable(of: SchedulesServerModel.self){ response in
            guard let scheduleResponse = response.value else
            {
                return
            }
            self.presenter?.scheduleFromInteractor(data: scheduleResponse.mrData?.raceTable?.races ?? [], total: ((scheduleResponse.mrData?.total!)! as NSString).integerValue, limit: ((scheduleResponse.mrData?.limit!)! as NSString).integerValue)
        }
    }
    
    
}
