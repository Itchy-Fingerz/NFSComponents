//
//  RequiredFieldLabel.swift
//  NFSComponents
//

import SwiftUI

/// Label used above a form field to indicate it is required. Renders as a
/// bold title followed by a red asterisk.
public struct RequiredFieldLabel: View {
    let title: String

    public init(title: String) {
        self.title = title
    }

    public var body: some View {
        Text(title)
            .font(Theme.Typography.custom(iPhone: 14, iPad: 20, weight: .semibold))
        + Text(" *")
            .font(Theme.Typography.custom(iPhone: 14, iPad: 20, weight: .semibold))
            .foregroundColor(.red)
    }
}
