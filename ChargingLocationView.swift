import SwiftUI

struct ChargingLocationView: View {
    @State private var feature = ChargingLocationFeature()

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets

            // Create ParallaxHeader with the provided size and safe area
            ParallaxHeader(size: size, safeArea: safeArea) {
                sampleStations // Provide the content for the ParallaxHeader
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

// MARK: - Child views

extension ChargingLocationView {
    private var sampleStations: some View {
        VStack(spacing: 8) {
            ForEach(1 ... 25, id: \.self) { _ in
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 75)
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ChargingLocationView()
}
