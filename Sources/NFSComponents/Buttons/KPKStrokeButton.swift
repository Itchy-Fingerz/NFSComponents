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
        color: Color = .nfsIcon,
        height: Double? = nil,
        width: Double = 560.0,
        cornerRadius: Double = 8.0,
        borderWidth: Double? = nil,
        onTap: @escaping () -> Void
    ) {
        self.label = label
        self.color = color
        self.height = height ?? (UIDevice.isIPhone ? 40.0 : 64.0)
        self.width = width
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth ?? (UIDevice.isIPhone ? 1.0 : 1.5)
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
