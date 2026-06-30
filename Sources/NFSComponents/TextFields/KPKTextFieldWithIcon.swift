//
//  KPKTextFieldWithIcon.swift
//  NFSComponents
//

import SwiftUI

public struct KPKTextFieldWithIcon: View {
    @Binding var text: String
    let placeholder: String
    let icon: Icon
    var isError: Bool
    var errorMessage: String

    public init(
        text: Binding<String>,
        placeholder: String,
        icon: Icon,
        isError: Bool = false,
        errorMessage: String = "This field is required"
    ) {
        self._text = text
        self.placeholder = placeholder
        self.icon = icon
        self.isError = isError
        self.errorMessage = errorMessage
    }

    public var body: some View {
        Textfield(
            text: $text,
            placeholder: placeholder,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                icon: icon,
                height: UIDevice.isIPad ? 64 : 56,
                borderWidth: 1,
                cornerRadius: Theme.Radius.lg,
                isError: isError,
                showErrorMsg: isError,
                errorMessage: errorMessage
            ),
            style: TextFieldStyle(
                unfocusedborderColor: Theme.Colors.borderFixed,
                fillColor: Theme.Colors.fieldBackground,
                textColor: Theme.Colors.textPrimary
            )
        )
    }
}
