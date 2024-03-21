import SwiftUI

struct ParallaxContentView: View {
    var progress: CGFloat
    var minimumHeaderHeight: CGFloat

    @State private var isTeslaModelXDisplayed = false
    @Namespace private var animation

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

        return ZStack {
            Asset.Images.tesla.imageView
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .parallaxOffsetX(progress, geometry)
                .parallaxOffsetY(imageOffsetY, progress)
                .parallaxScaleEffect(progress)

            if isTeslaModelXDisplayed {
                VStack(spacing: 4) {
                    teslaModelText
                    chargingText
                }
                .frame(maxWidth: geometry.size.width, maxHeight: .infinity, alignment: .top)
                .padding(EdgeInsets(top: 56, leading: 16, bottom: 0, trailing: 16))

            } else {
                VStack(spacing: 4) {
                    helloText
                    chargingSituationText
                }
                .frame(maxWidth: geometry.size.width, maxHeight: .infinity, alignment: .top)
                .padding(EdgeInsets(top: 56, leading: 16, bottom: 0, trailing: 16))
            }

            Text("TIME TO END OF CHARGE: 49 MIN")
                .font(.montserratLight(size: 12))
                .foregroundColor(.jucrSolidGray)
                .frame(maxWidth: geometry.size.width, maxHeight: .infinity, alignment: .bottom)
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 32, trailing: 16))
                .parallaxOpacityEffect(progress)
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
