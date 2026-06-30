//
//  Theme+Colors.swift
//  NFSComponents
//

import SwiftUI

extension Theme {
    enum Colors {

        // MARK: - Brand
        static let primary = Color.nfsSecondary
        static let accent  = Color.accentColor

        // MARK: - Surfaces / backgrounds
        static let backgroundElevated = Color.nfsBackgroundElevated
        static let surface            = Color.nfsCardBackground
        static let surfaceMuted       = Color.nfsBackgroundMuted

        // MARK: - Text
        /// Primary text (black in light mode, white in dark mode).
        static let textPrimary     = Color.nfsTextBW
        /// Inverse text (white in light mode, black in dark mode).
        static let textInverse     = Color.nfsTextWB
        static let textPlaceholder = Color.nfsPlaceholder
        static let textOnPrimary   = Color.nfsTextWB

        // MARK: - Icons & strokes
        static let icon        = Color.nfsIcon
        static let border      = Color.nfsBorder
        static let borderFixed = Color.nfsBorderFixed
        static let shadow      = Color.nfsShadow

        // MARK: - Fields / capsules / chips
        static let fieldBackground = Color.nfsFieldBackground
        static let capsule         = Color.nfsCapsule

        // MARK: - Feedback / status
        static let reject = Color.nfsReject

        // MARK: - Toast / feedback
        enum Toast {
            static let info    = Color.nfsToastBlue
            static let success = Color.nfsToastGreen
            static let error   = Color.nfsToastRed
            static let warning = Color.nfsToastYellow
            static let green   = Color.nfsGreen
        }
    }
}
