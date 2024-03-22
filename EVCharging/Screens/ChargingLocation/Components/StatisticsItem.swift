import SwiftUI

struct StatisticsItem: View {
    let imageView: Image
    let color: Color
    let title: String
    let subtitle: String

    init(imageView: Image, color: Color, title: String, subtitle: String) {
        self.imageView = imageView
        self.color = color
        self.title = title
        self.subtitle = subtitle
    }

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                .frame(width: 140, height: 140)
                .overlay(
                    HStack {
                        VStack(spacing: 20) {
                            icon
                            VStack(spacing: 4) {
                                titleView
                                subtitleView
                            }
                        }
                        Spacer()
                    }
                    .padding()
                )
        }
    }
}

// MARK: - Child views

extension StatisticsItem {
    private var icon: some View {
        HStack(spacing: 0) {
            Circle()
                .fill(color.opacity(0.2))
                .frame(width: 50, height: 50) // Circle background size
                .overlay(
                    imageView
                        .resizable()
                        .frame(width: 24, height: 24) // Icon size
                        .foregroundColor(color)
                )
            Spacer()
        }
    }

    private var titleView: some View {
        Text(title)
            .font(.montserratBold(size: 14))
            .foregroundColor(.jucrSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var subtitleView: some View {
        Text(subtitle)
            .font(.montserratLight(size: 10))
            .foregroundColor(.jucrSecondary)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    StatisticsItem(
        imageView: Asset.Icons.carBattery.imageView,
        color: .jucrAdditinonal,
        title: "240 Volt",
        subtitle: "Voltage"
    )
}
