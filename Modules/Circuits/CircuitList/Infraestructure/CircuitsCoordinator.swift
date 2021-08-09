//
//  CircuitsCoordinator.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 20/7/21.
//

import Foundation
import SwiftUI

final class CircuitsCoordinator: BaseCoordinator{
    static func navigation() -> NavigationView<CircuitsView>{
        let customNavigationView = NavigationView{
            self.buildView()
        }
        return customNavigationView
    }
    static func buildView() -> CircuitsView{
        var view = CircuitsView()
        let vip = BaseCoordinator.assembly(presenter: CircuitsPresenterImpl.self, interactor: CircuitsInteractorImpl.self)
        view.presenter = vip.presenter
        return view
    }
    
}
