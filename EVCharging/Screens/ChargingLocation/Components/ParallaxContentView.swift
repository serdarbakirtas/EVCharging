import SwiftUI

struct ParallaxContentView: View {
    var progress: CGFloat
    var minimumHeaderHeight: CGFloat

    var body: some View {
        GeometryReader { imageGeometry in
            Image("tesla")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: imageGeometry.size.width, height: imageGeometry.size.height)
                .clipped()
                .scaleEffect(1 - (progress * 0.5), anchor: .trailing)
                .offset(x: -(imageGeometry.frame(in: .global).minX - 15) * progress,
                        y: calculateImageOffsetY(imageGeometry, progress, minimumHeaderHeight))
        }
    }

    private func calculateImageOffsetY(_ geometry: GeometryProxy, _ progress: CGFloat, _ minimumHeaderHeight: CGFloat) -> CGFloat {
        let halfScaledHeight = (geometry.size.height * 0.3) * 0.5
        let midY = geometry.frame(in: .global).midY
        let bottomPadding: CGFloat = 8
        let resizedOffsetY = (midY - (minimumHeaderHeight - halfScaledHeight - bottomPadding))
        return (-resizedOffsetY - 8) * progress
    }
}
