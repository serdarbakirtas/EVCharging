import SwiftUI

struct ParallaxContentView: View {
    var progress: CGFloat
    var minimumHeaderHeight: CGFloat

    var body: some View {
        GeometryReader { geometry in
            parallaxImage(geometry)
        }
    }

    private func parallaxImage(_ geometry: GeometryProxy) -> some View {
        let imageOffsetY = calculateImageOffsetY(geometry)

        return Image("tesla")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geometry.size.width, height: geometry.size.height)
            .clipped()
            .parallaxScaleEffect(progress)
            .parallaxOffsetX(progress, geometry)
            .parallaxOffsetY(imageOffsetY, progress)
    }

    private func calculateImageOffsetY(_ geometry: GeometryProxy) -> CGFloat {
        let halfScaledHeight = (geometry.size.height * 0.3) * 0.5
        let midY = geometry.frame(in: .global).midY
        let bottomPadding: CGFloat = 8
        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
        return (-resizedOffsetY - 8) * progress
    }
}

#Preview {
    ChargingLocationView()
}
