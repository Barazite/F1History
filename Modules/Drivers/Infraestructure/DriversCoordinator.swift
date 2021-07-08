//
//  DriversCoordinator.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 7/7/21.
//

import Foundation
import SwiftUI

final class DriversCoordinator: BaseCoordinator{
    static func navigation() -> NavigationView<DriversView>{
        let customNavigationView = NavigationView{
            self.buildView()
        }
        return customNavigationView
    }
    static func buildView() -> DriversView{
        var view = DriversView()
        let vip = BaseCoordinator.assembly(presenter: DriversPresenterImpl.self, interactor: DriversInteractorImpl.self)
        view.presenter = vip.presenter
        return view
    }
    
}
