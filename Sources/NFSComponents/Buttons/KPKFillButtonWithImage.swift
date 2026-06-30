//
//  KPKFillButtonWithImage.swift
//  NFSComponents
//

import SwiftUI

public struct KPKFillButtonWithImg: View {
    let label: String
    let image: Image
    var color: Color
    var foregroundColor: Color
    var height: Double
    var width: Double
    var cornerRadius: Double
    var borderWidth: Double
    let onTap: () -> Void

    public init(
        label: String,
        image: Image,
        color: Color = .nfsIcon,
        foregroundColor: Color = .nfsBackgroundElevated,
        height: Double? = nil,
        width: Double = 560.0,
        cornerRadius: Double = 8.0,
        borderWidth: Double? = nil,
        onTap: @escaping () -> Void
    ) {
        self.label = label
        self.image = image
        self.color = color
        self.foregroundColor = foregroundColor
        self.height = height ?? (UIDevice.isIPhone ? 40.0 : 64.0)
        self.width = width
        self.cornerRadius = cornerRadius
        self.borderWidth = borderWidth ?? (UIDevice.isIPhone ? 1.0 : 1.5)
        self.onTap = onTap
    }

    private var iconSize: CGFloat { UIDevice.isIPhone ? 20 : 30 }

    public var body: some View {
        Button(action: onTap) {
            HStack {
                image
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .frame(width: iconSize)

                Text(label)
                    .font(Theme.Typography.labelLarge)
            }
            .foregroundStyle(foregroundColor)
            .frame(height: height)
            .frame(maxWidth: width)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        }
    }
}
