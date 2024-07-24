//
//  File.swift
//  
//
//  Created by Gilberto Magno on 24/07/24.
//

import Foundation
import SwiftUI

protocol HorizontalCoordinatorInterface {
    func push<Content: View>(_ flow: Content)
    func pop(_ amount: Int)
    func popToRoot()
}

protocol StackCoordinator: HorizontalCoordinatorInterface, AnyObject {
    var path: NavigationPath { get set }
    init(path: NavigationPath)
}

extension StackCoordinator {
    func push<Content: View>(_ flow: Content) {
        self.path.append(flow.navigationIdentifier)
    }

    func pop(_ amount: Int = 1) {
        self.path.removeLast(amount)
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
