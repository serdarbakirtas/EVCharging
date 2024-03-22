import SwiftUI

extension View {
    func parallaxOpacityEffect(_ progress: CGFloat) -> some View {
        opacity(1 - (progress))
    }
    
    func parallaxReverseOpacityEffect(_ progress: CGFloat) -> some View {
        opacity(0 + (progress))
    }
    
    func parallaxScaleEffect(_ progress: CGFloat) -> some View {
        scaleEffect(1 - (progress * 0.10), anchor: .trailing)
    }

    func slideOffsetX(_ progress: CGFloat, _ geometry: GeometryProxy) -> some View {
        offset(x: -(geometry.frame(in: .global).minX) * progress)
    }
    
    func parallaxOffsetX(_ progress: CGFloat, _ geometry: GeometryProxy) -> some View {
        offset(x: -(geometry.frame(in: .global).minX) * progress)
    }

    func parallaxOffsetY(_ offsetY: CGFloat, _ progress: CGFloat) -> some View {
        offset(y: offsetY - progress)
    }
}

#Preview {
    ChargingLocationView()
}
