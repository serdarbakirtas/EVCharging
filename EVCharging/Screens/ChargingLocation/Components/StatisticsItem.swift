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
                .frame(width: 140, height: 150)
                .overlay(
                    HStack {
                        VStack(spacing: 16) {
                            icon
                            VStack(spacing: 8) {
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
                        .frame(width: 30, height: 30) // Icon size
                        .foregroundColor(color)
                )
            Spacer()
        }
    }

    private var titleView: some View {
        Text(title)
            .font(.montserratBold(size: 16))
            .foregroundColor(.jucrSecondary)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var subtitleView: some View {
        Text(subtitle)
            .font(.montserratLight(size: 12))
            .foregroundColor(.secondary)
            .bold()
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
