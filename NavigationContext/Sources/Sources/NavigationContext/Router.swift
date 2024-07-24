//
//  File.swift
//  
//
//  Created by Gilberto Magno on 24/07/24.
//

import Foundation
import SwiftUI

// The Router Basically is Anything that can hold an View and be Hashable
protocol Router: Hashable, Identifiable {
    associatedtype Content: View
    
    var view: Content { get }
    var id: UUID { get }
}
extension Router {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// RouterView is an Generic View to deal with the weak swift Pack Value treatment.
// it will be change only when Swift increment its features of dealing with Pack Value like
// Iterations of Generic , GenericCollections or something in this way
struct RouterView: Router {
    static func == (lhs: RouterView, rhs: RouterView) -> Bool {
        lhs.id == rhs.id
    }
    
    init(view: some View,
         id: UUID = .init()) {
        self.view = AnyView(view)
        self.id = id
    }
    
    var view: AnyView
    var id: UUID = .init()
}

extension View {
    var navigationIdentifier: RouterView {
        .init(view: self,
              id: .init())
    }
}
