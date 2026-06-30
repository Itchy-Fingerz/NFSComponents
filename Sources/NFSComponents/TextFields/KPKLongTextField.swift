//
//  KPKLongTextField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKLongTextField: View {
    @Binding var longText: String
    let placeholder: String
    var height: CGFloat?

    public init(longText: Binding<String>, placeholder: String, height: CGFloat? = nil) {
        self._longText = longText
        self.placeholder = placeholder
        self.height = height
    }

    public var body: some View {
        Textfield(
            longText: $longText,
            placeholder: placeholder,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                height: height ?? 330,
                maxWidth: .infinity,
                borderWidth: 1,
                cornerRadius: 8
            ),
            style: TextFieldStyle(
                unfocusedborderColor: Theme.Colors.border,
                fillColor: Theme.Colors.surface,
                textColor: Theme.Colors.textPrimary
            )
        )
    }
}
