import SwiftUI

struct ChargingLocationView: View {
    @State private var feature = ChargingLocationFeature()

    var body: some View {
        GeometryReader { geometry in
            let navigationBarHeight = geometry.safeAreaInsets.top
            ParallaxHeader(size: geometry.size, safeArea: geometry.safeAreaInsets, navigationBarHeight: navigationBarHeight) {
                VStack(spacing: 0) {
                    statistics
                    sampleStations
                }
            }
            .ignoresSafeArea(.all, edges: .top)
        }
    }
}

// MARK: - Child views

extension ChargingLocationView {
    private var statistics: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text("Statistic")
                    .font(.montserratBold(size: 16))
                    .frame(alignment: .leading)
                    .foregroundColor(.jucrSecondary)

                Spacer()

                Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                    Asset.Icons.ellipsis.imageView
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 29, height: 29)
                        .foregroundColor(.jucrSecondary)
                })
            }
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
    }

    private var sampleStations: some View {
        VStack(spacing: 8) {
            HStack(spacing: 0) {
                Text("Nearby Supercharges")
                    .font(.montserratBold(size: 16))
                    .frame(alignment: .leading)
                    .foregroundColor(.jucrSecondary)
                    .padding()

                Spacer()

                Button(action: /*@START_MENU_TOKEN@*/ {}/*@END_MENU_TOKEN@*/, label: {
                    Text("View All")
                        .font(.montserratLight(size: 12))
                        .frame(alignment: .trailing)
                        .foregroundColor(.jucrSecondary)
                        .padding()
                })
            }

            ForEach(1 ... 10, id: \.self) { _ in
                SuperchargesItem()
            }
        }
    }
}

// MARK: - Previews

#Preview {
    ChargingLocationView()
}
