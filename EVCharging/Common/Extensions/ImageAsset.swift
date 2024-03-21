import SwiftUI

// MARK: - Asset Catalogs

enum Asset {
    enum Icons {
        static let energy = ImageAsset(name: "Icons/bolt-solid")
        static let battery = ImageAsset(name: "Icons/battery-three-quarters-solid")
        static let carBattery = ImageAsset(name: "Icons/car-battery-solid")
        static let station = ImageAsset(name: "Icons/charging-station-solid")
        static let location = ImageAsset(name: "Icons/location-dot-solid")
    }
    
    enum Images {
        static let tesla = ImageAsset(name: "tesla")
    }
}

// MARK: - Implementation Details

struct ImageAsset {
    fileprivate(set) var name: String

    typealias Image = UIImage

    var image: Image {
        let bundle = BundleToken.bundle
        let image = Image(named: name, in: bundle, compatibleWith: nil)
        guard let result = image else {
            fatalError("Unable to load image asset named \(name).")
        }
        return result
    }

    var imageView: SwiftUI.Image {
        .init(name, bundle: BundleToken.bundle)
    }
}

private final class BundleToken {
    static let bundle: Bundle = .init(for: BundleToken.self)
}
