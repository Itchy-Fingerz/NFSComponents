//
//  KPKCheckButton.swift
//  NFSComponents
//

import SwiftUI

public struct KPKCheckButton: View {
    @Binding var isTrue: Bool
    let label: String
    let onTap: () -> Void

    public init(isTrue: Binding<Bool>, label: String, onTap: @escaping () -> Void) {
        self._isTrue = isTrue
        self.label = label
        self.onTap = onTap
    }

    public var body: some View {
        HStack(spacing: Theme.Spacing.sm) {
            Button {
                withAnimation { isTrue.toggle() }
                onTap()
            } label: {
                Image(systemName: isTrue ? "checkmark.square.fill" : "square")
                    .foregroundStyle(Theme.Colors.icon)
                    .font(Theme.Typography.custom(iPhone: 18, iPad: 28, relativeTo: .title))
            }

            Text(label)
                .font(Theme.Typography.labelLarge)
        }
    }
}
