import SwiftUI

struct SuperchargesItem: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(Color.jucrSolidGray)
            .frame(height: 75)
            .overlay(
                HStack(spacing: 8) {
                    locationDetail
                    location
                }
                .padding()
            )
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

// MARK: - Child views

extension SuperchargesItem {
    private var locationDetail: some View {
        VStack(spacing: 8) {
            Text("Ranchview Dr. Richardson")
                .font(.montserratSemiBold(size: 14))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.jucrSecondary)

            Text("4 / 10 available")
                .font(.montserratLight(size: 12))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(.jucrSecondary)
        }
    }

    private var location: some View {
        VStack(spacing: 8) {
            Asset.Icons.location.imageView
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 29, height: 29)
                .foregroundColor(.jucrSecondary)

            Text("1.2 km")
                .font(.montserratLight(size: 12))
                .frame(alignment: .center)
                .foregroundColor(.jucrSecondary)
        }
    }
}

#Preview {
    SuperchargesItem()
}
