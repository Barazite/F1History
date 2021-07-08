//
//  SeasonsCoordinator.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 5/7/21.
//

import Foundation
import SwiftUI

final class SeasonsCoordinator: BaseCoordinator{
    static func navigation() -> NavigationView<SeasonsView>{
        let customNavigationView = NavigationView{
            self.buildView()
        }
        return customNavigationView
    }
    static func buildView() -> SeasonsView{
        var view = SeasonsView()
        let vip = BaseCoordinator.assembly(presenter: SeasonsPresenterImpl.self, interactor: SeasonsInteractorImpl.self)
        view.presenter = vip.presenter
        return view
    }
    
}

