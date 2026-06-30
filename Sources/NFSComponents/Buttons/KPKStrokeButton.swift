//
//  KPKStrokeButton.swift
//  NFSComponents
//

import SwiftUI

public struct KPKStrokeButton: View {
    let label: String
    var color: Color
    var height: Double
    var width: Double
    var cornerRadius: Double
    var borderWidth: Double
    let onTap: () -> Void

    public init(
        label: String,
        color: Color = Theme.Colors.icon,
        height: Double = UIDevice.isIPhone ? 40.0 : 64.0,
        width: Double = 560.0,
        cornerRadius: Double = Theme.Radius.sm,
        borderWidth: Double = UIDevice.isIPhone ? 1.0 : 1.5,
        onTap: @escaping () -> Void
    ) {
        self.label = label
        self.color = color
        self.height = height
        self.width = width
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(Theme.Typography.labelLarge)
                .frame(height: height)
                .frame(maxWidth: width)
                .foregroundStyle(color)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                        .stroke(color, lineWidth: borderWidth)
                )
        }
    }
}
