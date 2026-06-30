//
//  Fonts.swift
//  NFSComponents
//
//  Custom fonts shipped inside a Swift package are not auto-registered the way
//  app `Info.plist` (`UIAppFonts`) entries are, so we register them with Core
//  Text at runtime. Registration is idempotent and runs lazily the first time
//  any NFSComponents typography is requested.
//

import CoreText
import Foundation

public enum NFSFonts {
    private static let fontFileNames = [
        "NunitoSans-Regular",
        "NunitoSans-Light",
        "NunitoSans-SemiBold",
        "NunitoSans-Bold",
        "NunitoSans-ExtraBold",
        "NunitoSans-Black",
        "NunitoSans_7pt-Italic"
    ]

    /// Registers the bundled Nunito Sans fonts. Safe to call multiple times.
    public static let registerAll: Void = {
        for name in fontFileNames {
            guard let url = Bundle.module.url(forResource: name, withExtension: "ttf") else {
                continue
            }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }()
}
