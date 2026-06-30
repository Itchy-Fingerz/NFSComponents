//
//  KPKDropDownField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKDropDownField: View {
    @Binding var selectedValue: String
    let placeholder: String
    let dropDownValues: [String]

    public init(selectedValue: Binding<String>, placeholder: String, dropDownValues: [String]) {
        self._selectedValue = selectedValue
        self.placeholder = placeholder
        self.dropDownValues = dropDownValues
    }

    public var body: some View {
        // Resolve colours through Theme so the field/popover render correctly
        // in both light and dark mode.
        let dropDownConfig = DropDownConfigration(
            selectedTextColor: Theme.Colors.accent,
            unselectedTextColor: Theme.Colors.textPrimary,
            selectedhighlightColor: Theme.Colors.accent.opacity(0.1),
            unselectedhighlightColor: .clear
        )
        Textfield(
            selectedValue: $selectedValue,
            placeholder: placeholder,
            dropdownValues: dropDownValues,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                popoverHeight: 160,
                cornerRadius: 8,
                dropDownConfigration: dropDownConfig
            ),
            style: TextFieldStyle(
                unfocusedborderColor: Theme.Colors.border,
                fillColor: Theme.Colors.fieldBackground,
                textColor: Theme.Colors.textPrimary,
                placeholderBackgroundColor: Theme.Colors.backgroundElevated
            )
        )
    }
}
