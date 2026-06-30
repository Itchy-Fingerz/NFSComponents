//
//  KPKFillButton.swift
//  NFSComponents
//

import SwiftUI

public struct KPKFillButton: View {
    let label: String
    var backgroundColor: Color
    var foregroundColor: Color
    var height: Double
    var width: Double
    var cornerRadius: Double
    let onTap: () -> Void

    public init(
        label: String,
        backgroundColor: Color = .nfsIcon,
        foregroundColor: Color = .nfsTextWB,
        height: Double? = nil,
        width: Double = 560.0,
        cornerRadius: Double = 8.0,
        onTap: @escaping () -> Void
    ) {
        self.label = label
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.height = height ?? (UIDevice.isIPhone ? 40.0 : 64.0)
        self.width = width
        self.cornerRadius = cornerRadius
        self.onTap = onTap
    }

    public var body: some View {
        Button(action: onTap) {
            Text(label)
                .font(Theme.Typography.labelLarge)
                .frame(height: height)
                .frame(maxWidth: width)
                .foregroundStyle(foregroundColor)
                .background(backgroundColor)
                .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
}
