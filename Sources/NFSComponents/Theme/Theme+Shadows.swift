//
//  Theme+Shadows.swift
//  NFSComponents
//

import SwiftUI

extension Theme {
    struct ShadowStyle {
        let color: Color
        let radius: CGFloat
        let x: CGFloat
        let y: CGFloat

        init(color: Color, radius: CGFloat, x: CGFloat, y: CGFloat) {
            self.color = color
            self.radius = radius
            self.x = x
            self.y = y
        }
    }

    enum Shadow {
        /// Small — below sticky headers, chips.
        static let subtle = ShadowStyle(
            color: Colors.shadow.opacity(0.06),
            radius: 4, x: 0, y: 1
        )
        /// Medium — cards.
        static let card = ShadowStyle(
            color: Colors.shadow.opacity(0.08),
            radius: 8, x: 0, y: 2
        )
        /// Large — bottom sheets, pop-ups.
        static let overlay = ShadowStyle(
            color: Colors.shadow.opacity(0.16),
            radius: 24, x: 0, y: 8
        )
    }
}

extension View {
    /// Applies one of the canonical elevation shadows.
    func shadow(_ style: Theme.ShadowStyle) -> some View {
        shadow(color: style.color, radius: style.radius, x: style.x, y: style.y)
    }
}
