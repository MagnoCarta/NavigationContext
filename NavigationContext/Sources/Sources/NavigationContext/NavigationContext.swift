// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation
import SwiftUI

struct NavigationContext<Content: View>: View {
    
    @Environment(\.coordinator) var coordinator
    var initialView: () -> Content
    
    var body: some View {
        stackBody
    }
    
    @ViewBuilder var stackBody: some View {
        @Bindable var coordinator = coordinator
        NavigationStack(path: $coordinator.path) {
            initialView()
                .navigation(for: RouterView.self)
                .fullScreenCover(item: $coordinator.fullScreen,
                                 onDismiss: coordinator.fullScreen?.onDismiss,
                                 content: { nav in
                    nav.sheet.view
            })
                .sheet(item: $coordinator.sheet,
                              onDismiss: coordinator.sheet?.onDismiss,
                       content: { nav in
                nav.sheet.view
            })
        }
    }
    
}

extension View {
    
    func navigation(for router: (some Router).Type) -> some View {
        self
            .navigationDestination(for: router, destination: { router in
                router.view
            })
    }
    
    // Não consigo fazer uma iteração normal que nem gente sem utilizar AnyView por conta que esses routers não são faceis de armazenar sem mexer com Pack Parameters por conta do seu nivel de genericidade
    // TODO: Descobrir algum meio de Substituir AnyView ou TupleView.
    func navigation(for forRouters: [(some Router).Type]) -> some View {
        var view: AnyView = AnyView(self)
        var routers = forRouters
        while !routers.isEmpty {
            let router = routers.removeFirst()
            view = AnyView(view.navigation(for: router))
        }
        return view
    }
}

private struct ContextCoordinatorKey: EnvironmentKey {
    static let defaultValue: ContextCoordinator = .init()

}

extension EnvironmentValues {
    var coordinator: ContextCoordinator {
        get { self[ContextCoordinatorKey.self] }
        set { self[ContextCoordinatorKey.self] = newValue }
    }
}

@Observable
class ContextCoordinator: StackCoordinator, PresenterCoordinator {
    var path: NavigationPath
    var fullScreen: Presents? = nil
    var sheet: Presents? = nil
    
    required init(path: NavigationPath = .init()) {
        self.path = path
    }
    
    init(views: [some View]) {
        self.path = .init()
        var views = views
        while !views.isEmpty {
            self.path.append(views.removeFirst().navigationIdentifier)
        }
    }
}
