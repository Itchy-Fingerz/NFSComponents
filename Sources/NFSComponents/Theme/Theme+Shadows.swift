//
//  Theme+Shadows.swift
//  NFSComponents
//

import SwiftUI

public extension Theme {
    struct ShadowStyle {
        public let color: Color
        public let radius: CGFloat
        public let x: CGFloat
        public let y: CGFloat

        public init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }

    enum Shadow {
        /// Small — below sticky headers, chips.
        public static let subtle = ShadowStyle(
            color: Colors.shadow.opacity(0.06),
            radius: 4, x: 0, y: 1
        )
        /// Medium — cards.
        public static let card = ShadowStyle(
            color: Colors.shadow.opacity(0.08),
            radius: 8, x: 0, y: 2
        )
        /// Large — bottom sheets, pop-ups.
        public static let overlay = ShadowStyle(
            color: Colors.shadow.opacity(0.16),
            radius: 24, x: 0, y: 8
        )
    }
}

public extension View {
    /// Applies one of the canonical elevation shadows.
    func shadow(_ style: Theme.ShadowStyle) -> some View {
        shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}
