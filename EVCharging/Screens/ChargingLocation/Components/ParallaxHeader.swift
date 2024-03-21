import SwiftUI

struct ParallaxHeader<Content>: View where Content: View {
    // Properties
    private let content: () -> Content
    private let size: CGSize
    private let safeArea: EdgeInsets

    @State private var offsetY: CGFloat = 0

    // Constants
    private let velocityMultiplier: CGFloat = 45
    private let animationResponse: Double = 0.55
    private let animationDampingFraction: CGFloat = 0.65
    private var minimumShapeOffset: CGFloat = 20.0

    init(size: CGSize, safeArea: EdgeInsets, @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self.safeArea = safeArea
        self.content = content
    }

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    header
                        .zIndex(1000)

                    content()
                }
                .id("SCROLLVIEW")
                .background {
                    ScrollDetector { offset in
                        offsetY = -offset
                    } onDraggingEnd: { offset, velocity in
                        handleScrollEnd(offset, velocity, scrollProxy)
                    }
                }
            }
        }
    }

    // MARK: - Child views

    private var header: some View {
        let headerHeight = (size.height * 0.35) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)

        return GeometryReader { geometry in
            ZStack {
                headerBackground(geometry, headerHeight, minimumHeaderHeight)
                ParallaxContentView(progress: progress, minimumHeaderHeight: minimumHeaderHeight)
            }
            .frame(height: calculateHeaderViewHeight(headerHeight, minimumHeaderHeight), alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }

    // MARK: - Private Functions

    @ViewBuilder
    private func headerBackground(_ geometry: GeometryProxy, _ headerHeight: CGFloat, _ minimumHeaderHeight: CGFloat) -> some View {
        Color.jucrPrimary.clipShape(
            CustomShape(xAxis: geometry.size.width / 2)
                .offset(y: calculateBackgroundOffsetY(headerHeight, minimumHeaderHeight))
        )

        let totalOffset = headerHeight + offsetY
        let targetOffset = max(minimumHeaderHeight, minimumHeaderHeight)
        ChargingSpinner()
            .frame(height: totalOffset < targetOffset ? minimumHeaderHeight : headerHeight + offsetY, alignment: .top)
            .offset(y: (calculateBackgroundOffsetY(headerHeight, minimumHeaderHeight) - 20))
    }

    private func calculateBackgroundOffsetY(_ headerHeight: CGFloat, _ minimumHeaderHeight: CGFloat) -> CGFloat {
        let totalOffset = headerHeight + offsetY
        let targetOffset = max(minimumHeaderHeight, minimumHeaderHeight)
        return totalOffset < targetOffset ? targetOffset : totalOffset
    }

    private func handleScrollEnd(_ offset: CGFloat, _ velocity: CGFloat, _ scrollProxy: ScrollViewProxy) {
        let headerHeight = (size.height * 0.35) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let targetEnd = offset + (velocity * velocityMultiplier)

        if targetEnd < (headerHeight - minimumHeaderHeight), targetEnd > 0 {
            withAnimation(
                .interactiveSpring(
                    response: animationResponse,
                    dampingFraction: animationDampingFraction,
                    blendDuration: animationDampingFraction
                )
            ) {
                scrollProxy.scrollTo("SCROLLVIEW", anchor: .top)
            }
        }
    }

    private func calculateHeaderViewHeight(_ headerHeight: CGFloat, _ minimumHeaderHeight: CGFloat) -> CGFloat {
        (headerHeight + offsetY) < minimumHeaderHeight ? minimumHeaderHeight : (headerHeight + offsetY)
    }
}

#Preview {
    ChargingLocationView()
}
