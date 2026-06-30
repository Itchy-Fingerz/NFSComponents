//
//  KPKTextField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKTextField: View {
    @Binding var text: String
    let placeholder: String

    public init(text: Binding<String>, placeholder: String) {
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        Textfield(
            text: $text,
            placeholder: placeholder,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                height: UIDevice.isIPad ? 64 : 56,
                borderWidth: 1,
                cornerRadius: 16
            ),
            style: TextFieldStyle(
                unfocusedborderColor: .gray.opacity(0.3),
                fillColor: Theme.Colors.fieldBackground,
                textColor: Theme.Colors.textPrimary
            )
        )
    }
}
