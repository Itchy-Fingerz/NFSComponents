//
//  KPKOTPField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKOTPField: View {
    @Binding var otp: String
    var isError: Bool

    public init(otp: Binding<String>, isError: Bool = false) {
        self._otp = otp
        self.isError = isError
    }

    public var body: some View {
        Textfield(
            otp: $otp,
            count: 6,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                otpFieldHeight: 64,
                otpFieldWidth: 50,
                borderWidth: 1,
                cornerRadius: 8,
                isError: isError
            ),
            style: TextFieldStyle(
                unfocusedborderColor: .gray.opacity(0.6),
                fillColor: Theme.Colors.fieldBackground,
                textColor: Theme.Colors.textPrimary,
                onErrorBorderColor: Theme.Colors.reject
            )
        )
    }
}
