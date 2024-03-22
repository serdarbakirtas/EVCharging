import Observation

@Observable class AppState {
    var activeScreen: AppState.Screens = .tabbar

    init() {}
}

extension AppState {
    enum Screens: Hashable {
        case tabbar
    }
}
