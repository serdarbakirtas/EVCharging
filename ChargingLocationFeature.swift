final class ChargingLocationFeature {
    // Intent Definition
    enum Intent {}

    var viewState = ChargingLocationViewState()

    // Intent Handling
    func reduce(intent: Intent) async {}
}
