import SwiftUI

@main
struct EVChargingApp: App {
    let appState = AppState()

    var body: some Scene {
        WindowGroup {
            TabbarView()
                .environment(appState)
                .preferredColorScheme(.dark)
                .background(.white)
        }
    }
}
