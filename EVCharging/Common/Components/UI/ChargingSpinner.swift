import SwiftUI

struct ChargingSpinner: View {
    @State private var isLoading = false
    @State private var progress: CGFloat = 0.0

    var body: some View {
        ZStack {
            linearCircle

            iconAndPercentage
        }
    }
}

// MARK: - Child views

extension ChargingSpinner {
    private var linearCircle: some View {
        Circle()
            .trim(from: 0, to: 1)
            .stroke(
                LinearGradient(
                    gradient: Gradient(colors: [Color.jucrSolidGray, Color.jucrSolidGray.opacity(0.1)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                style: StrokeStyle(lineWidth: 6, lineCap: .round)
            )
            .frame(width: 50, height: 50)
            .rotationEffect(Angle(degrees: isLoading ? 360 : 0))
            .onAppear {
                startLoadingAnimation()
            }
    }

    private var iconAndPercentage: some View {
        VStack(spacing: 4) {
            Asset.Icons.energy.imageView
                .resizable()
                .frame(width: 10, height: 10)
                .foregroundColor(.jucrSolidGray)

            Text("\(Int(progress * 100))%")
                .font(.montserrat(size: 12))
                .foregroundColor(.jucrSolidGray)
                .bold()
        }
    }
}

// MARK: - Private Functions

extension ChargingSpinner {
    private func startLoadingAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                isLoading = true
                animateProgress()
            }
        }
    }

    private func animateProgress() {
        let animationIncrement = 0.01

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if progress < 1.0 {
                progress += animationIncrement
                animateProgress()
            }
        }
    }
}

#Preview {
    ChargingSpinner()
}
