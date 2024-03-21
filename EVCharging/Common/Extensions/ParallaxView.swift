import SwiftUI

extension View {
    func parallaxOpacityEffect(_ progress: CGFloat) -> some View {
        opacity(1 - (progress))
    }
    
    func parallaxScaleEffect(_ progress: CGFloat) -> some View {
        scaleEffect(1 - (progress * 0.5), anchor: .trailing)
    }

    func slideOffsetX(_ progress: CGFloat, _ geometry: GeometryProxy) -> some View {
        offset(x: -(geometry.frame(in: .global).minX - 8) * progress)
    }
    
    func parallaxOffsetX(_ progress: CGFloat, _ geometry: GeometryProxy) -> some View {
        offset(x: -(geometry.frame(in: .global).minX - 8) * progress)
    }

    func parallaxOffsetY(_ offsetY: CGFloat, _: CGFloat) -> some View {
        offset(y: offsetY)
    }
}

#Preview {
    ChargingLocationView()
}
