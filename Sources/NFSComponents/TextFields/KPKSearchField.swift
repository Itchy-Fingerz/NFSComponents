//
//  KPKSearchField.swift
//  NFSComponents
//

import SwiftUI

public struct KPKSearchField: View {
    @Binding var searchText: String
    let placeholder: String

    public init(searchText: Binding<String>, placeholder: String) {
        self._searchText = searchText
        self.placeholder = placeholder
    }

    public var body: some View {
        Textfield(
            text: $searchText,
            placeholder: placeholder,
            configration: TextFieldConfigration(
                placeholderType: .plain,
                icon: Icon(type: .systemName, name: "magnifyingglass", color: .gray, unfocusedColor: .gray),
                height: UIDevice.isIPhone ? 40 : 56,
                maxWidth: .infinity,
                borderWidth: 1,
                cornerRadius: 12
            ),
            style: TextFieldStyle(
                unfocusedborderColor: Theme.Colors.surface,
                fillColor: Theme.Colors.surface,
                textColor: Theme.Colors.textPrimary
            )
        )
        .shadow(color: .black.opacity(0.10), radius: 10, x: 0, y: 5)
    }
}
