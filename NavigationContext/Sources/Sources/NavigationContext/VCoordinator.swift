//
//  File.swift
//  
//
//  Created by Gilberto Magno on 24/07/24.
//

import Foundation
import SwiftUI

protocol VerticalCoordinatorInterface {
    func present(_ sheet: Presents)
    func dismiss()
}

enum PresentStyle: Hashable {
    case fullScreenCover
    case sheet
}

@Observable
class Presents: Identifiable {
    var sheet: RouterView
    var presentStyle: PresentStyle
    var onDismiss: (() -> Void)?
    
    init(sheet: () -> some View,
         presentStyle: PresentStyle,
         onDismiss: (() -> Void)? = nil) {
        self.sheet = sheet().navigationIdentifier
        self.presentStyle = presentStyle
        self.onDismiss = onDismiss
    }
}

extension Presents: Hashable {
    static func == (lhs: Presents, rhs: Presents) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sheet)
    }
}

protocol PresenterCoordinator: VerticalCoordinatorInterface, AnyObject {
    var fullScreen: Presents? { get set }
    var sheet: Presents? { get set }
}

extension PresenterCoordinator {
    func present(_ sheet: Presents) {
        withAnimation {
            self.dismiss()
            if sheet.presentStyle == .fullScreenCover {
                self.fullScreen = sheet
            } else {
                self.sheet = sheet
            }
        }
    }
    
    func dismiss() {
        withAnimation {
            self.fullScreen = nil
            self.sheet = nil
        }
    }
}
