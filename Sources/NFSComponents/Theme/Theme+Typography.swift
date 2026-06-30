//
//  Theme+Typography.swift
//  NFSComponents
//

import SwiftUI
import CoreGraphics

public extension Theme {
    enum Typography {

        // MARK: - Font families
        public static let regularFontName = "NunitoSans-Regular"
        public static let italicFontName  = "NunitoSans7pt-Italic"

        // MARK: - Custom builder (preferred entry point for off-scale sizes)
        /// Builds a Font with iPhone/iPad responsive sizes. Registers the
        /// bundled fonts on first use so `Font.custom` can resolve them.
        public static func custom(
            iPhone: CGFloat,
            iPad: CGFloat,
            weight: Font.Weight = .regular,
            relativeTo textStyle: Font.TextStyle = .body,
            italic: Bool = false
        ) -> Font {
            _ = NFSFonts.registerAll
            let name = italic ? italicFontName : regularFontName
            let size = UIDevice.isIPhone ? iPhone : iPad
            return Font.custom(name, size: size, relativeTo: textStyle).weight(weight)
        }

        // MARK: - Display — hero numbers, splash
        public static let displayLarge  = custom(iPhone: 36, iPad: 50, weight: .regular, relativeTo: .largeTitle)
        public static let displayMedium = custom(iPhone: 28, iPad: 40, weight: .regular, relativeTo: .largeTitle)
        public static let displaySmall  = custom(iPhone: 24, iPad: 32, weight: .regular, relativeTo: .title)

        // MARK: - Headline — screen titles
        public static let headlineLarge  = custom(iPhone: 24, iPad: 30, weight: .regular, relativeTo: .title)
        public static let headlineMedium = custom(iPhone: 20, iPad: 24, weight: .regular, relativeTo: .title2)
        public static let headlineSmall  = custom(iPhone: 18, iPad: 22, weight: .regular, relativeTo: .title3)

        // MARK: - Title — section headers, sheet titles
        public static let titleLarge  = custom(iPhone: 18, iPad: 22, weight: .regular, relativeTo: .headline)
        public static let titleMedium = custom(iPhone: 16, iPad: 20, weight: .regular, relativeTo: .headline)
        public static let titleSmall  = custom(iPhone: 14, iPad: 18, weight: .regular, relativeTo: .subheadline)

        // MARK: - Body — primary reading content
        public static let bodyLarge  = custom(iPhone: 14, iPad: 16, weight: .regular, relativeTo: .body)
        public static let bodyMedium = custom(iPhone: 13, iPad: 16, weight: .regular, relativeTo: .body)
        public static let bodySmall  = custom(iPhone: 12, iPad: 14, weight: .regular, relativeTo: .body)

        // MARK: - Label — buttons, chips, pills
        public static let labelLarge  = custom(iPhone: 14, iPad: 16, weight: .semibold, relativeTo: .callout)
        public static let labelMedium = custom(iPhone: 13, iPad: 16, weight: .semibold, relativeTo: .callout)
        public static let labelSmall  = custom(iPhone: 12, iPad: 14, weight: .semibold, relativeTo: .footnote)

        // MARK: - Caption — help text, timestamps, metadata
        public static let caption      = custom(iPhone: 12, iPad: 14, weight: .regular, relativeTo: .caption)
        public static let captionSmall = custom(iPhone: 10, iPad: 12, weight: .regular, relativeTo: .caption2)
    }
}
