//
//  Theme+Colors.swift
//  NFSComponents
//

import SwiftUI

public extension Theme {
    enum Colors {

        // MARK: - Brand
        public static let primary = Color.nfsSecondary
        public static let accent  = Color.accentColor

        // MARK: - Surfaces / backgrounds
        public static let backgroundElevated = Color.nfsBackgroundElevated
        public static let surface            = Color.nfsCardBackground
        public static let surfaceMuted       = Color.nfsBackgroundMuted

        // MARK: - Text
        /// Primary text (black in light mode, white in dark mode).
        public static let textPrimary     = Color.nfsTextBW
        /// Inverse text (white in light mode, black in dark mode).
        public static let textInverse     = Color.nfsTextWB
        public static let textPlaceholder = Color.nfsPlaceholder
        public static let textOnPrimary   = Color.nfsTextWB

        // MARK: - Icons & strokes
        public static let icon        = Color.nfsIcon
        public static let border      = Color.nfsBorder
        public static let borderFixed = Color.nfsBorderFixed
        public static let shadow      = Color.nfsShadow

        // MARK: - Fields / capsules / chips
        public static let fieldBackground = Color.nfsFieldBackground
        public static let capsule         = Color.nfsCapsule

        // MARK: - Feedback / status
        public static let reject = Color.nfsReject

        // MARK: - Toast / feedback
        public enum Toast {
            public static let info    = Color.nfsToastBlue
            public static let success = Color.nfsToastGreen
            public static let error   = Color.nfsToastRed
            public static let warning = Color.nfsToastYellow
            public static let green   = Color.nfsGreen
        }
    }
}
