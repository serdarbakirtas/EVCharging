import SwiftUI

struct ParallaxHeader<Content>: View where Content: View {
    private let content: () -> Content
    private let size: CGSize
    private let safeArea: EdgeInsets

    @State private var offsetY: CGFloat = 0

    init(size: CGSize, safeArea: EdgeInsets, @ViewBuilder content: @escaping () -> Content) {
        self.size = size
        self.safeArea = safeArea
        self.content = content
    }

    var body: some View {
        ScrollViewReader { scrollProxy in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    headerView
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
}

// MARK: - Child views

extension ParallaxHeader {
    private var headerView: some View {
        let headerHeight = (size.height * 0.4) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let progress = max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0)

        return GeometryReader { _ in
            ZStack {
                Rectangle()
                    .fill(Color.jucrPrimary)

                VStack(spacing: 8) {
                    ParallaxContentView(progress: progress, minimumHeaderHeight: minimumHeaderHeight)
                        .frame(width: headerHeight, height: headerHeight * 0.4, alignment: .leading)
                }
                .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
            }
            .frame(height: calculateHeaderViewHeight(headerHeight, minimumHeaderHeight),
                   alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
}

// MARK: - Private Functions

extension ParallaxHeader {
    private func handleScrollEnd(_ offset: CGFloat, _ velocity: CGFloat, _ scrollProxy: ScrollViewProxy) {
        let headerHeight = (size.height * 0.4) + safeArea.top
        let minimumHeaderHeight = 65 + safeArea.top
        let targetEnd = offset + (velocity * 45)

        if targetEnd < (headerHeight - minimumHeaderHeight), targetEnd > 0 {
            withAnimation(.interactiveSpring(response: 0.55, dampingFraction: 0.65, blendDuration: 0.65)) {
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
