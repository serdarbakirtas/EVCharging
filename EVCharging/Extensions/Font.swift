import SwiftUI
import UIKit.UIFont

public extension Font {
    static func montserrat(size: CGFloat) -> Font {
        FontFamily.Montserrat.regular.font(size: size)
    }

    static func montserratBold(size: CGFloat) -> Font {
        FontFamily.Montserrat.bold.font(size: size)
    }

    static func montserratSemiBold(size: CGFloat) -> Font {
        FontFamily.Montserrat.semiBold.font(size: size)
    }

    static func montserratLight(size: CGFloat) -> Font {
        FontFamily.Montserrat.light.font(size: size)
    }
}

enum FontFamily {
    enum Montserrat {
        static let regular = FontMeta(name: "Montserrat-Regular", family: "jucr Head", path: "Montserrat-Regular.ttf")
        static let bold = FontMeta(name: "Montserrat-Bold", family: "jucr Head", path: "Montserrat-Bold.ttf")
        static let semiBold = FontMeta(name: "Montserrat-SemiBold", family: "jucr Head", path: "Montserrat-SemiBold.ttf")
        static let light = FontMeta(name: "Montserrat-Light", family: "jucr Head", path: "Montserrat-Light.ttf")
        static let all: [FontMeta] = [regular, bold, semiBold, light]
    }

    static let allCustomFonts: [FontMeta] = [Montserrat.all].flatMap { $0 }
    static func registerAllCustomFonts() {
        allCustomFonts.forEach { $0.register() }
    }
}

struct FontMeta {
    let name: String
    let family: String
    let path: String

    func font(size: CGFloat) -> Font {
        .custom(name, size: size)
    }

    func font(size: CGFloat) -> UIFont {
        guard let font = UIFont(font: self, size: size) else {
            assertionFailure("Unable to initialize font '\(name)' (\(family))")
            return .systemFont(ofSize: size)
        }
        return font
    }

    func register() {
        guard let url else { return }
        CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
    }

    fileprivate var url: URL? {
        BundleToken.bundle.url(forResource: path, withExtension: nil)
    }
}

private extension UIFont {
    convenience init?(font: FontMeta, size: CGFloat) {
        if !UIFont.fontNames(forFamilyName: font.family).contains(font.name) {
            font.register()
        }
        self.init(name: font.name, size: size)
    }
}

private final class BundleToken {
    static let bundle: Bundle = .init(for: BundleToken.self)
}
