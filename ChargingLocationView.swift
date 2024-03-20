import SwiftUI

struct ChargingLocationView: View {
    @State private var feature = ChargingLocationFeature()

    var body: some View {
        Text("ChargingLocationView")
    }
}

// MARK: - Previews

#Preview {
    ChargingLocationView()
}
