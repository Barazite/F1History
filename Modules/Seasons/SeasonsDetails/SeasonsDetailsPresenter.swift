//
//  SeasonsDetailsPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

protocol SeasonsDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func scheduleFromInteractor(data: [Race])
    func driversFromInteractor(data: [DriverStanding])
    func constructorsFromInteractor(data: [ConstructorStanding])
}

class SeasonsDetailsPresenterImpl: BasePresenter, ObservableObject{
    
    var season: String = ""
    
    @Published var arraySchedule: [SchedulesModel] = []
    @Published var arrayDrivers: [DriverStandingModel] = []
    @Published var arrayConstructors: [ConstructorsStandingsModel] = []
    @Published var finalList: Bool = false
    
    var interactor: SeasonsDetailsInteractorInputProtocol? { return super.baseInteractor as? SeasonsDetailsInteractorInputProtocol}
    
    func fetchData(){
        self.interactor?.fetchSchedulesInteractor(season: self.season)
        self.interactor?.fetchDriversInteractor(season: self.season)
        self.interactor?.fetchConstructorsInteractor(season: self.season)
    }
}

extension SeasonsDetailsPresenterImpl: SeasonsDetailsInteractorOutputProtocol{
    func constructorsFromInteractor(data: [ConstructorStanding]) {
        self.arrayConstructors.removeAll()
        self.arrayConstructors = data.map{ConstructorsStandingsModel(businessModel: $0)}
    }
    
    func driversFromInteractor(data: [DriverStanding]) {
        self.arrayDrivers.removeAll()
        self.arrayDrivers = data.map{DriverStandingModel(businessModel: $0)}
    }
    
    func scheduleFromInteractor(data: [Race]) {
        self.arraySchedule.removeAll()
        self.arraySchedule = data.map {SchedulesModel(businessModel: $0)}
    }
    
    
}
