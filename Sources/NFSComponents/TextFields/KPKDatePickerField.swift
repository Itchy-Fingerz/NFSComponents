//
//  KPKDatePickerField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKDatePickerField: View {
    @Binding var selectedDate: String
    @Binding var inDateFormat: Date
    let placeholder: String

    public init(selectedDate: Binding<String>, inDateFormat: Binding<Date>, placeholder: String) {
        self._selectedDate = selectedDate
        self._inDateFormat = inDateFormat
        self.placeholder = placeholder
    }

    public var body: some View {
        Textfield(
            selectedDate: $selectedDate,
            inDateFormat: $inDateFormat,
            placeholder: placeholder,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                cornerRadius: Theme.Radius.lg,
                dateFormat: "dd/MM/yyyy"
            ),
            style: TextFieldStyle(
                unfocusedborderColor: Theme.Colors.borderFixed,
                fillColor: .clear,
                textColor: Theme.Colors.textPrimary
            )
        )
    }
}
