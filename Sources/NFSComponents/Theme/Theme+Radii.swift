//
//  Theme+Radii.swift
//  NFSComponents
//

import CoreGraphics

public extension Theme {
    enum Radius {
        /// 0 — sharp corners
        public static let none: CGFloat = 0
        /// 4 — hairline rounding (chips)
        public static let xs: CGFloat = 4
        /// 8 — input fields, small cards
        public static let sm: CGFloat = 8
        /// 12 — default card / sheet corner
        public static let md: CGFloat = 12
        /// 16 — large card, modal sheet
        public static let lg: CGFloat = 16
        /// 20 — hero card
        public static let xl: CGFloat = 20
        /// 24 — pop-up
        public static let xxl: CGFloat = 24
        /// Pill — for capsules / fully rounded buttons.
        public static let pill: CGFloat = 999
    }
}
