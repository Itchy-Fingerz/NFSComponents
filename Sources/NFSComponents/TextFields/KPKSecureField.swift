//
//  KPKSecureField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKSecureField: View {
    @Binding var password: String
    let placeholder: String

    public init(password: Binding<String>, placeholder: String) {
        self._password = password
        self.placeholder = placeholder
    }

    public var body: some View {
        Textfield(
            secureText: $password,
            placeholder: placeholder,
            configration: TextFieldConfigration(
                placeholderType: .plain,
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
