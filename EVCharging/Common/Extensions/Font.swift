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
}

struct FontMeta {
    let name: String
    let family: String
    let path: String

    func font(size: CGFloat) -> Font {
        .custom(name, size: size)
    }
}
