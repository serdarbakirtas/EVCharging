#if os(macOS)
    import AppKit
#elseif os(iOS)
    import UIKit
#elseif os(tvOS) || os(watchOS)
    import UIKit
#endif

import SwiftUI

// MARK: - Asset Catalogs

enum Asset {
    enum Icons {
        static let energy = ImageAsset(name: "Icons/bolt-solid")
    }
}

// MARK: - Implementation Details

struct ImageAsset {
    fileprivate(set) var name: String

    #if os(macOS)
        typealias Image = NSImage
    #elseif os(iOS) || os(tvOS) || os(watchOS)
        typealias Image = UIImage
    #endif

    var image: Image {
        let bundle = BundleToken.bundle
        #if os(iOS) || os(tvOS)
            let image = Image(named: name, in: bundle, compatibleWith: nil)
        #elseif os(macOS)
            let name = NSImage.Name(name)
            let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
        #elseif os(watchOS)
            let image = Image(named: name)
        #endif
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
