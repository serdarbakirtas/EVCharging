import SwiftUI

struct SuperchargesItem: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10, style: .continuous)
            .fill(Color.jucrSolidGray)
            .frame(height: 75)
            .overlay(
                HStack(spacing: 8) {
                    VStack(spacing: 8) {
                        Text("Ranchview Dr. Richardson")
                            .font(.montserratSemiBold(size: 14))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.jucrSecondary)

                        Text("4/10 available")
                            .font(.montserratLight(size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(.jucrSecondary)
                    }

                    VStack(spacing: 8) {
                        Asset.Icons.location.imageView
                            .resizable()
                            .frame(width: 20, height: 25)
                            .foregroundColor(.jucrSecondary)
                        
                        Text("1.2 km")
                            .font(.montserratLight(size: 12))
                            .frame(alignment: .center)
                            .foregroundColor(.jucrSecondary)
                    }
                    
                }
                .padding()
            )
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

#Preview {
    ChargingLocationView()
}
