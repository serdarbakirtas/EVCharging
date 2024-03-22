import SwiftUI

struct ParallaxContentView: View {
    var progress: CGFloat
    var minimumHeaderHeight: CGFloat

    @State private var isTeslaModelXDisplayed = false
    @Namespace private var animation

    private var statusBarHeight: CGFloat {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return 0 }
        return windowScene.statusBarManager?.statusBarFrame.height ?? 0
    }

    var body: some View {
        GeometryReader { geometry in
            parallaxImage(geometry)
        }
    }
}

// MARK: - Child views

extension ParallaxContentView {
    private func parallaxImage(_ geometry: GeometryProxy) -> some View {
        let imageOffsetY = calculateImageOffsetY(geometry)

        return VStack(spacing: 0) {
            if isTeslaModelXDisplayed {
                VStack(spacing: 4) {
                    teslaModelText
                    chargingText
                }
                .padding(EdgeInsets(top: statusBarHeight + 16, leading: 16, bottom: 0, trailing: 16))

            } else {
                VStack(spacing: 4) {
                    helloText
                    chargingSituationText
                }
                .padding(EdgeInsets(top: statusBarHeight + 16, leading: 16, bottom: 0, trailing: 16))
            }

            Asset.Images.tesla.imageView
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .frame(minHeight: 80)
                .offset(x: min(progress, 1) * ((geometry.size.width * 0.5) - (minimumHeaderHeight - 16)))
                .offset(y: (-(geometry.size.height / 2) - (statusBarHeight < 40 ? statusBarHeight : .zero)) * progress)
                .parallaxScaleEffect(progress)

            Text("TIME TO END OF CHARGE: 49 MIN")
                .font(.montserratLight(size: 12))
                .foregroundColor(.jucrSolidGray)
                .parallaxOpacityEffect(progress)
                .offset(y: (-(geometry.size.height / 2)) * progress)
        }
        .onAppear {
            isTeslaModelXDisplayed = imageOffsetY > 0
        }
        .onChange(of: imageOffsetY) { _, newValue in
            withAnimation {
                isTeslaModelXDisplayed = newValue > 0
            }
        }
    }

    private var teslaModelText: some View {
        Text("Tesla Model X")
            .font(.montserratBold(size: 16))
            .foregroundColor(.jucrSolidGray)
            .matchedGeometryEffect(id: "titleText", in: animation)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }

    private var chargingText: some View {
        Text("Charging: 58%")
            .font(.montserratLight(size: 12))
            .foregroundColor(.jucrSolidGray)
            .matchedGeometryEffect(id: "subtitleText", in: animation)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/, alignment: .leading)
    }

    private var helloText: some View {
        Text("Good morning, Billy")
            .font(.montserratLight(size: 12))
            .foregroundColor(.jucrSolidGray)
            .matchedGeometryEffect(id: "titleText", in: animation)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
    }

    private var chargingSituationText: some View {
        Text("Charging your car...")
            .font(.montserratBold(size: 18))
            .foregroundColor(.jucrSolidGray)
            .matchedGeometryEffect(id: "subtitleText", in: animation)
            .frame(maxWidth: /*@START_MENU_TOKEN@*/ .infinity/*@END_MENU_TOKEN@*/)
    }
}

// MARK: - Private Functions

extension ParallaxContentView {
    private func calculateImageOffsetY(_ geometry: GeometryProxy) -> CGFloat {
        let midY = geometry.frame(in: .global).midY
        let bottomPadding: CGFloat = 16
        let resizedOffsetY = (midY - (minimumHeaderHeight - bottomPadding))
        return -resizedOffsetY * progress
    }
}

#Preview {
    ChargingLocationView()
}
