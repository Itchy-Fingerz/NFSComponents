//
//  KPKBackButton.swift
//  NFSComponents
//

import SwiftUI

public struct KPKBackButton: View {
    @Environment(\.dismiss) private var dismiss
    var onAction: () -> Void

    public init(onAction: @escaping () -> Void = {}) {
        self.onAction = onAction
    }

    private var buttonSize: CGFloat { UIDevice.isIPhone ? 40 : 60 }

    public var body: some View {
        Button {
            onAction()
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
                .renderingMode(.template)
                .frame(width: buttonSize, height: buttonSize)
                .background(Theme.Colors.surfaceMuted)
                .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.sm, style: .continuous))
                .foregroundStyle(Theme.Colors.textPrimary)
        }
    }
}
