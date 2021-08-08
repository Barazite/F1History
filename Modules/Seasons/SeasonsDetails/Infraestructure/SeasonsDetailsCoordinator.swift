//
//  SeasonsDetailsCoordinator.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/8/21.
//

import Foundation
import SwiftUI

final class SeasonsDetailsCoordinator: BaseCoordinator{
    static func navigation(season: String) -> NavigationView<SeasonsDetailsView>{
        let customNavigationView = NavigationView{
            self.buildView(season: season)
        }
        return customNavigationView
    }
    static func buildView(season: String) -> SeasonsDetailsView{
        var view = SeasonsDetailsView()
        let vip = BaseCoordinator.assembly(presenter: SeasonsDetailsPresenterImpl.self, interactor: SeasonsDetailsInteractorImpl.self)
        view.presenter = vip.presenter
        vip.presenter.season = season
        return view
    }
    
}
