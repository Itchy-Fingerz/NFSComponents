//
//  Theme+Radii.swift
//  NFSComponents
//

import CoreGraphics

extension Theme {
    enum Radius {
        /// 0 — sharp corners
        static let none: CGFloat = 0
        /// 4 — hairline rounding (chips)
        static let xs: CGFloat = 4
        /// 8 — input fields, small cards
        static let sm: CGFloat = 8
        /// 12 — default card / sheet corner
        static let md: CGFloat = 12
        /// 16 — large card, modal sheet
        static let lg: CGFloat = 16
        /// 20 — hero card
        static let xl: CGFloat = 20
        /// 24 — pop-up
        static let xxl: CGFloat = 24
        /// Pill — for capsules / fully rounded buttons.
        static let pill: CGFloat = 999
    }
}
