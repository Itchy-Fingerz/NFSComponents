//
//  Font+Extensions.swift
//  NFSComponents
//
//  Convenience aliases onto the Theme typography scale. Kept for the internal
//  text-field implementation; the semantic `Theme.Typography` tokens are the
//  preferred entry point at new call sites.
//

import SwiftUI

extension Font {
    static var custom_font_m12_t14_en: Font { Theme.Typography.caption }
    static var custom_font_m13_t16_en: Font { Theme.Typography.bodyMedium }
    static var custom_font_m14_t16_en: Font { Theme.Typography.bodyLarge }
    static var custom_font_m14_t18_en: Font { Theme.Typography.titleSmall }
    static var custom_font_m18_t22_en: Font { Theme.Typography.titleLarge }
}
