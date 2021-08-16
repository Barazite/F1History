//
//  FavoritesManager.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 14/8/21.
//

import Foundation
import SwiftUI

class FavoritesManager{
    
    static let shared = FavoritesManager()
    @AppStorage(Favorites.drivers) var drivers : Data = Data()
    @AppStorage(Favorites.seasons) var seasons : Data = Data()
    @AppStorage(Favorites.circuits) var circuits : Data = Data()
    @AppStorage(Favorites.constructors) var constructors : Data = Data()
    
    // MARK: Favorites Drivers
    func saveDriver(driver: Drivers){
        var favoritesDrivers : [Drivers] = getDrivers() ?? []
        favoritesDrivers.append(driver)
        setDrivers(data: favoritesDrivers)
    }
    
    func deleteDriver(driver: Drivers){
        var favoritesDrivers : [Drivers] = getDrivers() ?? []
        favoritesDrivers.remove(at: (favoritesDrivers.firstIndex(where: {$0.id == driver.id})!))
        setDrivers(data: favoritesDrivers)
    }
    
    func findDriver(driver: Drivers) -> Bool{
        let favoritesDrivers : [Drivers] = getDrivers() ?? []
        let find = (favoritesDrivers.contains(where: {$0.id == driver.id}))
        return find
    }
    
    func getDrivers() -> [Drivers]?{
        var myData: [Drivers] = []
        do{
            myData = try PropertyListDecoder().decode([Drivers].self, from: self.drivers)
        }catch _{
            myData = []
        }
        return myData
    }
    
    func setDrivers(data: [Drivers]){
        do{
            self.drivers = try PropertyListEncoder().encode(data)
        }catch let error{
            print(error)
        }
    }
    
    // MARK: Favorites Seasons
    func saveSeason(season: Seasons){
        var favoritesSeasons : [Seasons] = getSeasons() ?? []
        favoritesSeasons.append(season)
        setSeasons(data: favoritesSeasons)
    }
    
    func deleteSeason(season: Seasons){
        var favoritesSeasons : [Seasons] = getSeasons() ?? []
        favoritesSeasons.remove(at: (favoritesSeasons.firstIndex(where: {$0.id == season.id})!))
        setSeasons(data: favoritesSeasons)
    }
    
    func findSeason(season: Seasons) -> Bool{
        let favoritesSeasons : [Seasons] = getSeasons() ?? []
        let find = (favoritesSeasons.contains(where: {$0.id == season.id}))
        return find
    }
    
    func getSeasons() -> [Seasons]?{
        var myData: [Seasons] = []
        do{
            myData = try PropertyListDecoder().decode([Seasons].self, from: self.seasons)
        }catch _{
            myData = []
        }
        return myData
    }
    
    func setSeasons(data: [Seasons]){
        do{
            self.seasons = try PropertyListEncoder().encode(data)
        }catch let error{
            print(error)
        }
    }
    
    // MARK: Favorites Circuits
    func saveCircuit(circuit: Circuits){
        var favoritesCircuits : [Circuits] = getCircuits() ?? []
        favoritesCircuits.append(circuit)
        setCircuits(data: favoritesCircuits)
    }
    
    func deleteCircuit(circuit: Circuits){
        var favoritesCircuits : [Circuits] = getCircuits() ?? []
        favoritesCircuits.remove(at: (favoritesCircuits.firstIndex(where: {$0.id == circuit.id})!))
        setCircuits(data: favoritesCircuits)
    }
    
    func findCircuit(circuit: Circuits) -> Bool{
        let favoritesCircuits : [Circuits] = getCircuits() ?? []
        let find = (favoritesCircuits.contains(where: {$0.id == circuit.id}))
        return find
    }
    
    func getCircuits() -> [Circuits]?{
        var myData: [Circuits] = []
        do{
            myData = try PropertyListDecoder().decode([Circuits].self, from: self.circuits)
        }catch _{
            myData = []
        }
        return myData
    }
    
    func setCircuits(data: [Circuits]){
        do{
            self.circuits = try PropertyListEncoder().encode(data)
        }catch let error{
            print(error)
        }
    }
    
    // MARK: Favorites Constructors
    
    func saveConstructor(constructor: Constructors){
        var favoritesConstructors : [Constructors] = getConstructors() ?? []
        favoritesConstructors.append(constructor)
        setConstructors(data: favoritesConstructors)
    }
    
    func deleteConstructor(constructor: Constructors){
        var favoritesConstructors : [Constructors] = getConstructors() ?? []
        favoritesConstructors.remove(at: (favoritesConstructors.firstIndex(where: {$0.id == constructor.id})!))
        setConstructors(data: favoritesConstructors)
    }
    
    func findConstructor(constructor: Constructors) -> Bool{
        let favoritesConstructors : [Constructors] = getConstructors() ?? []
        let find = (favoritesConstructors.contains(where: {$0.id == constructor.id}))
        return find
    }
    
    func getConstructors() -> [Constructors]?{
        var myData: [Constructors] = []
        do{
            myData = try PropertyListDecoder().decode([Constructors].self, from: self.constructors)
        }catch _{
            myData = []
        }
        return myData
    }
    
    func setConstructors(data: [Constructors]){
        do{
            self.constructors = try PropertyListEncoder().encode(data)
        }catch let error{
            print(error)
        }
    }
    
}

private extension FavoritesManager{
    struct Favorites {
        static let drivers = "drivers"
        static let circuits = "circuits"
        static let seasons = "seasons"
        static let constructors = "constructors"
    }
}
