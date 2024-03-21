import SwiftUI

struct ChargingLocationView: View {
    @State private var feature = ChargingLocationFeature()

    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets

            // Create ParallaxHeader with the provided size and safe area
            ParallaxHeader(size: size, safeArea: safeArea) {
                sampleStations
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

// MARK: - Child views

extension ChargingLocationView {
    private var sampleStations: some View {
        VStack(spacing: 0) {
            VStack(spacing: 8) {
                Text("Statistic")
                    .font(.montserratBold(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        StatisticsItem(
                            imageView: Asset.Icons.carBattery.imageView,
                            color: .jucrPrimary, title: "240 Volt", subtitle: "Voltage"
                        )
                        StatisticsItem(
                            imageView: Asset.Icons.battery.imageView,
                            color: .jucrSecondary, title: "540 Km", subtitle: "Remaining charge"
                        )
                        StatisticsItem(
                            imageView: Asset.Icons.station.imageView,
                            color: .jucrAdditinonal, title: "20 M", subtitle: "Fast charging"
                        )
                    }.padding()
                }
            }

            VStack(spacing: 8) {
                Text("Nearby Supercharges")
                    .font(.montserratBold(size: 20))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                    .padding()

                ForEach(1 ... 10, id: \.self) { _ in
                    SuperchargesItem()
                }
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ChargingLocationView()
}
