//
//  CircuitDetailsCoordinator.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 9/8/21.
//

import Foundation
import SwiftUI

final class CircuitDetailsCoordinator: BaseCoordinator{
    static func navigation(circuit: Circuits) -> NavigationView<CircuitDetailsView>{
        let customNavigationView = NavigationView{
            self.buildView(circuit: circuit)
        }
        return customNavigationView
    }
    static func buildView(circuit: Circuits) -> CircuitDetailsView{
        var view = CircuitDetailsView()
        let vip = BaseCoordinator.assembly(presenter: CircuitDetailsPresenterImpl.self, interactor: nil)
        view.presenter = vip.presenter
        vip.presenter.circuit = circuit
        return view
    }
}
