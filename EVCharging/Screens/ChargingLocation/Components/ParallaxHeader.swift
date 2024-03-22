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

    private var headerHeight: CGFloat {
        (size.height * 0.35) + safeArea.top
    }

    private var minimumHeaderHeight: CGFloat {
        65 + safeArea.top
    }

    private var progress: CGFloat {
        max(min(-offsetY / (headerHeight - minimumHeaderHeight), 1), 0) // it counts 0...1
    }

    private var calculatedHeaderHeight: CGFloat {
        let totalOffset = headerHeight + offsetY
        return totalOffset < minimumHeaderHeight ? minimumHeaderHeight : totalOffset
    }

    // MARK: - Initializers
    /// - Parameters
    ///   - size: Size of geometry
    ///   - safeArea: Safe area of geometry
    ///   - ViewBuilder: It return view to impelement it under the header view
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
}

// MARK: - Child views

extension ParallaxHeader {
    private var header: some View {
        GeometryReader { geometry in
            ZStack {
                // Background with shape
                Color.jucrPrimary.clipShape(CustomShape(xAxis: geometry.size.width / 2)
                    .offset(y: calculatedHeaderHeight)
                )

                // Spinner
                ChargingSpinner()
                    .frame(height: calculatedHeaderHeight, alignment: .top)
                    .offset(y: calculatedHeaderHeight - 30)
                    .parallaxOpacityEffect(progress)
                
                buttonChevron

                // Display images and texts
                ParallaxContentView(progress: progress, minimumHeaderHeight: minimumHeaderHeight)
            }
            .frame(height: calculatedHeaderHeight, alignment: .bottom)
            .offset(y: -offsetY)
        }
        .frame(height: headerHeight)
    }
    
    private var buttonChevron: some View {
        Button {
            print("Button was tapped")
        } label: {
            Asset.Icons.chevron.imageView
                .resizable()
                .frame(width: 16, height: 16)
                .foregroundColor(.jucrSolidGray)
        }
        .frame(height: calculatedHeaderHeight, alignment: .top)
        .offset(y: calculatedHeaderHeight)
        .parallaxReverseOpacityEffect(progress)
    }
}

// MARK: - Private Functions

extension ParallaxHeader {
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
}

#Preview {
    ChargingLocationView()
}
