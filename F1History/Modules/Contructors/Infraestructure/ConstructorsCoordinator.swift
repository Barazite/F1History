//
//  ConstructorsCoordinator.swift
//  F1History
//
//  Created by Adrian Sevilla Diaz on 8/7/21.
//

import Foundation
import SwiftUI

final class ConstructorsCoordinator: BaseCoordinator{
    static func navigation() -> NavigationView<ConstructorsView>{
        let customNavigationView = NavigationView{
            self.buildView()
        }
        return customNavigationView
    }
    static func buildView() -> ConstructorsView{
        var view = ConstructorsView()
        let vip = BaseCoordinator.assembly(presenter: ConstructorsPresenterImpl.self, interactor: ConstructorsInteractorImpl.self)
        view.presenter = vip.presenter
        return view
    }
    
}
