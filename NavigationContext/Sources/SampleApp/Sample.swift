//
//  File.swift
//  
//
//  Created by Gilberto Magno on 24/07/24.
//

import Foundation
import SwiftUI

struct RandomView: View {
    
    var planeCoordinator = ContextCoordinator()
    var starCoordinator = ContextCoordinator()
    var appleCoordinator = ContextCoordinator()
    
    init() {
        planeCoordinator.present(
            .init(sheet: {
                HeartView()
            }, presentStyle: .sheet)
        )
    }
    
    var body: some View {
        TabView {
            NavigationContext {
                PlaneView()
            }
            .environment(\.coordinator, planeCoordinator)
            .tabItem { Label("Plane", systemImage: "airplane") }
            NavigationContext {
                StarView()
            }
            .environment(\.coordinator, starCoordinator)
            .tabItem { Label("Star", systemImage: "star") }
            NavigationContext {
                AppleView()
            }
            .environment(\.coordinator, appleCoordinator)
            .tabItem { Label("Apple", systemImage: "apple.logo") }
        }
    }
}

struct StarView: View {
    
    @Environment(\.coordinator) var coordinator
    
    var body: some View {
        VStack {
            Text("OLHA A ESTRELA")
            Image(systemName: "star")
            Button(action: {
                coordinator.push(LungsView())
            }, label: {
                Label("Lungs", systemImage: "lungs.fill")
            })
            Button(action: {
                coordinator.push(HeartView())
            }, label: {
                Label("Heart", systemImage: "heart.fill")
            })
            Button(action: {
                coordinator.push(PillView())
            }, label: {
                Label("Pill", systemImage: "pill.fill")
            })
        }

    }
}

struct PlaneView: View {
    
    @Environment(\.coordinator) var coordinator
    
    var body: some View {
        VStack {
            Text("OLHA O AVIAO")
            Image(systemName: "airplane")
            Button(action: {
                coordinator.push(LungsView())
            }, label: {
                Label("Lungs", systemImage: "lungs.fill")
            })
            Button(action: {
                coordinator.push(HeartView())
            }, label: {
                Label("Heart", systemImage: "heart.fill")
            })
            Button(action: {
                coordinator.push(PillView())
            }, label: {
                Label("Pill", systemImage: "pill.fill")
            })
        }
    }
}

struct AppleView: View {
    
    @Environment(\.coordinator) var coordinator
    
    var body: some View {
        VStack {
            Text("OLHA a APPLE")
            Image(systemName: "apple")
            Button(action: {
                coordinator
                    .present(
                        .init(sheet: { LungsView() },
                              presentStyle: .fullScreenCover) {
                    print("SAIU DA LUNGS HEART DA APPLE")
                })
            }, label: {
                Label("Lungs", systemImage: "lungs.fill")
            })
            Button(action: {
                coordinator
                    .present(
                        .init(sheet: { HeartView() },
                              presentStyle: .sheet) {
                    print("SAIU DA FULL HEART DA APPLE")
                })
            }, label: {
                Label("Heart", systemImage: "heart.fill")
            })
            Button(action: {
                coordinator.push(PillView())
            }, label: {
                Label("Pill", systemImage: "pill.fill")
            })
        }
    }
}

struct HeartView: View {
    var body: some View {
        VStack {
            Text("OLHA O CORACAO")
            Image(systemName: "heart.fill")
            
        }

    }
}

struct PillView: View {
    var body: some View {
        VStack {
            Text("OLHA A PILULA")
            Image(systemName: "pill.fill")
        }
    }
}

struct LungsView: View {
    
    @Environment(\.coordinator) var coordinator
    
    var body: some View {
        VStack {
            Text("OLHA O PULMAO")
            Image(systemName: "lungs.fill")
            Button("SAIRRRR") {
                coordinator.dismiss()
            }
        }
    }
}

#Preview {
    
    RandomView()
    
}
