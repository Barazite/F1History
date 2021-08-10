//
//  SeasonsDetailsPresenter.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation

protocol SeasonsDetailsInteractorOutputProtocol: BaseInteractorOutputProtocol {
    func scheduleFromInteractor(data: [Race], total: Int, limit: Int)
    func driversFromInteractor(data: [DriverStanding], total: Int, limit: Int)
    func constructorsFromInteractor(data: [ConstructorStanding], total: Int, limit: Int)
}

class SeasonsDetailsPresenterImpl: BasePresenter, ObservableObject{
    
    var season: String = ""
    
    @Published var arraySchedule: [SchedulesModel] = []
    @Published var arrayDrivers: [DriverStandingModel] = []
    @Published var arrayConstructors: [ConstructorsStandingsModel] = []
    @Published var finalScheduleList: Bool = false
    @Published var finalDriverList: Bool = false
    @Published var finalConstructorList: Bool = false
    
    var offsetShedule: Int = 0
    var offsetDriver: Int = 0
    var offsetConstructor: Int = 0
    
    var interactor: SeasonsDetailsInteractorInputProtocol? { return super.baseInteractor as? SeasonsDetailsInteractorInputProtocol}
    
//    func fetchData(){
//        self.interactor?.fetchSchedulesInteractor(season: self.season, offset: "\(offsetShedule)")
//        self.interactor?.fetchDriversInteractor(season: self.season, offset: "\(offsetDriver)")
//        self.interactor?.fetchConstructorsInteractor(season: self.season, offset: "\(offsetConstructor)")
//    }
    
    func fetchSchedules(){
        self.interactor?.fetchSchedulesInteractor(season: self.season, offset: "\(offsetShedule)")
    }
    
    func fetchDrivers(){
        self.interactor?.fetchDriversInteractor(season: self.season, offset: "\(offsetDriver)")
    }
    
    func fetchConstructors(){
        self.interactor?.fetchConstructorsInteractor(season: self.season, offset: "\(offsetConstructor)")
    }
}

extension SeasonsDetailsPresenterImpl: SeasonsDetailsInteractorOutputProtocol{
    func constructorsFromInteractor(data: [ConstructorStanding], total: Int, limit: Int) {
        self.arrayConstructors.append(contentsOf: data.map{ConstructorsStandingsModel(businessModel: $0)})
        self.offsetConstructor += limit
        if self.arrayConstructors.count == total{
            finalConstructorList = true
        }
    }
    
    func driversFromInteractor(data: [DriverStanding], total: Int, limit: Int) {
        self.arrayDrivers.append(contentsOf: data.map{DriverStandingModel(businessModel: $0)})
        self.offsetDriver += limit
        if self.arrayDrivers.count == total{
            finalDriverList = true
        }
    }
    
    func scheduleFromInteractor(data: [Race], total: Int, limit: Int) {
        self.arraySchedule.append(contentsOf: data.map {SchedulesModel(businessModel: $0)})
        self.offsetShedule += limit
        if self.arraySchedule.count == total{
            finalScheduleList = true
        }
    }
    
    
}
