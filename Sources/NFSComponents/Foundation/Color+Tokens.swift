//
//  Color+Tokens.swift
//  NFSComponents
//
//  Self-contained color palette. These values are baked directly into the
//  package (as light/dark adaptive `0xRRGGBBAA` pairs) so NFSComponents does
//  not depend on any host-app asset catalog. They mirror the design tokens the
//  components were originally built against.
//

import SwiftUI

public extension Color {
    // MARK: - Brand
    static let nfsSecondary  = Color.nfsAdaptive(light: 0x0598CEFF, dark: 0x0598CEFF)

    // MARK: - Text
    static let nfsTextBW     = Color.nfsAdaptive(light: 0x000000FF, dark: 0xFEFFFFFF)
    static let nfsTextWB     = Color.nfsAdaptive(light: 0xFEFFFFFF, dark: 0x000000FF)
    static let nfsPlaceholder = Color.nfsAdaptive(light: 0x718096FF, dark: 0x718096FF)

    // MARK: - Icons & strokes
    static let nfsIcon       = Color.nfsAdaptive(light: 0x1C3968FF, dark: 0xFEFFFFFF)
    static let nfsBorder     = Color.nfsAdaptive(light: 0xD7D7DCFF, dark: 0xD7D7DCFF)
    static let nfsBorderFixed = Color.nfsAdaptive(light: 0xD7D7DCFF, dark: 0xD7D7DCFF)
    static let nfsShadow     = Color.nfsAdaptive(light: 0x1D376414, dark: 0x40455E7A)

    // MARK: - Surfaces
    static let nfsCardBackground   = Color.nfsAdaptive(light: 0xFFFFFFFF, dark: 0x28364BFF)
    static let nfsFieldBackground  = Color.nfsAdaptive(light: 0xFFFFFFFF, dark: 0x28364BFF)
    static let nfsBackgroundElevated = Color.nfsAdaptive(light: 0xFFFFFFFF, dark: 0x15243CFF)
    static let nfsBackgroundMuted  = Color.nfsAdaptive(light: 0xFAFAFAFF, dark: 0xF6F7F81A)
    static let nfsCapsule          = Color.nfsAdaptive(light: 0x1C396814, dark: 0xC4CBD633)

    // MARK: - Feedback / status
    static let nfsReject     = Color.nfsAdaptive(light: 0xDE2910FF, dark: 0xB44C3EFF)
    static let nfsToastRed   = Color.nfsAdaptive(light: 0xFF507AFF, dark: 0xFF507AFF)
    static let nfsToastGreen = Color.nfsAdaptive(light: 0x31C440FF, dark: 0x31C440FF)
    static let nfsToastBlue  = Color.nfsAdaptive(light: 0x1C3968FF, dark: 0xFEFFFFFF)
    static let nfsToastYellow = Color.nfsAdaptive(light: 0xFFC400FF, dark: 0xFFC400FF)
    static let nfsGreen      = Color.nfsAdaptive(light: 0x78C6ACFF, dark: 0x78C6ACFF)
}
