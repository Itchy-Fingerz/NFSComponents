//
//  TextFieldCore.swift
//  NFSComponents
//
//  A configurable, themeable text field that backs every KPK*Field variant.
//  Supports plain text, secure entry, a tap-to-pick date field, a dropdown,
//  OTP boxes and a multi-line long-text editor.
//

import SwiftUI

public enum IconType {
    case systemName, asset
}

public enum IconLocation {
    case left, right
}

public enum PlaceholderType {
    case floating, plain
}

public enum TextfieldType {
    case text, secure, datePicker, dropdown, otp, longText
}

public struct Icon {
    let type: IconType
    let name: String
    var width: CGFloat
    var height: CGFloat
    var location: IconLocation
    var color: Color
    var unfocusedColor: Color

    public init(
        type: IconType,
        name: String,
        width: CGFloat = 20,
        height: CGFloat = 20,
        location: IconLocation = .left,
        color: Color = .nfsSecondary,
        unfocusedColor: Color = .gray
    ) {
        self.type = type
        self.name = name
        self.width = width
        self.height = height
        self.location = location
        self.color = color
        self.unfocusedColor = unfocusedColor
    }
}

public struct TextFieldConfigration {
    var placeholderType: PlaceholderType
    var icon: Icon?
    var height: CGFloat
    var width: CGFloat
    var maxWidth: CGFloat
    var otpFieldHeight: CGFloat
    var otpFieldWidth: CGFloat
    var popoverHeight: CGFloat
    var borderWidth: CGFloat
    var cornerRadius: CGFloat
    var dateFormat: String
    var dropDownConfigration: DropDownConfigration
    var isError: Bool
    var showErrorMsg: Bool
    var errorMessage: String
    var otpSpacing: CGFloat

    public init(
        placeholderType: PlaceholderType = .floating,
        icon: Icon? = nil,
        height: CGFloat = 54.0,
        width: CGFloat = 100.0,
        maxWidth: CGFloat = 560,
        otpFieldHeight: CGFloat = 48,
        otpFieldWidth: CGFloat = 48,
        popoverHeight: CGFloat = 200.0,
        borderWidth: CGFloat = 1.0,
        cornerRadius: CGFloat = 8.0,
        dateFormat: String = "MMMM dd, yyyy",
        dropDownConfigration: DropDownConfigration = .init(),
        isError: Bool = false,
        showErrorMsg: Bool = false,
        errorMessage: String = "This field is required",
        otpSpacing: CGFloat = 10.0
    ) {
        self.placeholderType = placeholderType
        self.icon = icon
        self.height = height
        self.width = width
        self.maxWidth = maxWidth
        self.otpFieldHeight = otpFieldHeight
        self.otpFieldWidth = otpFieldWidth
        self.popoverHeight = popoverHeight
        self.borderWidth = borderWidth
        self.cornerRadius = cornerRadius
        self.dateFormat = dateFormat
        self.dropDownConfigration = dropDownConfigration
        self.isError = isError
        self.showErrorMsg = showErrorMsg
        self.errorMessage = errorMessage
        self.otpSpacing = otpSpacing
    }
}

public struct TextFieldStyle {
    var focusedborderColor: Color
    var unfocusedborderColor: Color
    var fillColor: Color
    var focusedIconColor: Color
    var textColor: Color
    var unfocusedIconColor: Color
    var unfocusedplaceholderTextColor: Color
    var focusedplaceholderTextColor: Color
    var placeholderBackgroundColor: Color
    var calenderAccentColor: Color
    var onErrorBorderColor: Color
    var focusedborderWidth: CGFloat
    var unfocusedborderWidth: CGFloat

    public init(
        focusedborderColor: Color = .nfsSecondary,
        unfocusedborderColor: Color = .gray,
        fillColor: Color = .clear,
        focusedIconColor: Color = .nfsSecondary,
        textColor: Color = .nfsTextBW,
        unfocusedIconColor: Color = .gray,
        unfocusedplaceholderTextColor: Color = .gray,
        focusedplaceholderTextColor: Color = .accentColor,
        placeholderBackgroundColor: Color = .white,
        calenderAccentColor: Color = .accentColor,
        onErrorBorderColor: Color = .red,
        focusedborderWidth: CGFloat = 1,
        unfocusedborderWidth: CGFloat = 0.5
    ) {
        self.focusedborderColor = focusedborderColor
        self.unfocusedborderColor = unfocusedborderColor
        self.fillColor = fillColor
        self.focusedIconColor = focusedIconColor
        self.textColor = textColor
        self.unfocusedIconColor = unfocusedIconColor
        self.unfocusedplaceholderTextColor = unfocusedplaceholderTextColor
        self.focusedplaceholderTextColor = focusedplaceholderTextColor
        self.placeholderBackgroundColor = placeholderBackgroundColor
        self.calenderAccentColor = calenderAccentColor
        self.onErrorBorderColor = onErrorBorderColor
        self.focusedborderWidth = focusedborderWidth
        self.unfocusedborderWidth = unfocusedborderWidth
    }
}

public struct DropDownConfigration {
    var selectedTextColor: Color
    var unselectedTextColor: Color
    var selectedhighlightColor: Color
    var unselectedhighlightColor: Color
    var selectedTextFontWeight: Font.Weight
    var unselectedTextFontWeight: Font.Weight
    var selectedTextFont: Font
    var unselectedTextFont: Font

    public init(
        selectedTextColor: Color = .accentColor,
        unselectedTextColor: Color = .black,
        selectedhighlightColor: Color = .accentColor.opacity(0.1),
        unselectedhighlightColor: Color = .clear,
        selectedTextFontWeight: Font.Weight = .bold,
        unselectedTextFontWeight: Font.Weight = .regular,
        selectedTextFont: Font = .subheadline,
        unselectedTextFont: Font = .subheadline
    ) {
        self.selectedTextColor = selectedTextColor
        self.unselectedTextColor = unselectedTextColor
        self.selectedhighlightColor = selectedhighlightColor
        self.unselectedhighlightColor = unselectedhighlightColor
        self.selectedTextFontWeight = selectedTextFontWeight
        self.unselectedTextFontWeight = unselectedTextFontWeight
        self.selectedTextFont = selectedTextFont
        self.unselectedTextFont = unselectedTextFont
    }
}

public struct Textfield: View {
    @Binding var text: String
    let placeholder: String
    let type: TextfieldType
    var dropdownValues: [String]?
    var otpCount: Int?
    let defaultCornerRadius = 8.0
    @Binding var inDateFormat: Date
    @State var isVisible = false
    @State var selectedDate = Date()
    @State var showDropDown = false
    @State var calendarId: UUID = .init()
    var configration: TextFieldConfigration = .init()
    var style: TextFieldStyle = .init()
    @FocusState var isFocus: Bool
    @State private var isOtpFocus = false
    @State private var isLongTextFocused = false
    @State var showErrorMsg = false

    // Text field initializer
    public init(
        text: Binding<String>,
        placeholder: String,
        configration: TextFieldConfigration? = nil,
        style: TextFieldStyle? = nil
    ) {
        self._text = text
        self.placeholder = placeholder
        self.type = .text
        self.configration = configration ?? TextFieldConfigration()
        self.style = style ?? TextFieldStyle()
        _inDateFormat = .constant(Date.now)
    }

    // Long Text field initializer
    public init(
        longText: Binding<String>,
        placeholder: String,
        configration: TextFieldConfigration? = nil,
        style: TextFieldStyle? = nil
    ) {
        self._text = longText
        self.placeholder = placeholder
        self.type = .longText
        self.configration = configration ?? TextFieldConfigration()
        self.style = style ?? TextFieldStyle()
        _inDateFormat = .constant(Date.now)
    }

    // Secure field initializer
    public init(
        secureText: Binding<String>,
        placeholder: String,
        configration: TextFieldConfigration? = nil,
        style: TextFieldStyle? = nil
    ) {
        self._text = secureText
        self.placeholder = placeholder
        self.type = .secure
        self.configration = configration ?? TextFieldConfigration()
        self.style = style ?? TextFieldStyle()
        _inDateFormat = .constant(Date.now)
    }

    // Date picker field initializer
    public init(
        selectedDate: Binding<String>,
        inDateFormat: Binding<Date>,
        placeholder: String,
        configration: TextFieldConfigration? = nil,
        style: TextFieldStyle? = nil
    ) {
        self._text = selectedDate
        self.placeholder = placeholder
        self.type = .datePicker
        self.configration = configration ?? TextFieldConfigration()
        self.style = style ?? TextFieldStyle()
        _inDateFormat = inDateFormat
    }

    // Dropdown field initializer
    public init(
        selectedValue: Binding<String>,
        placeholder: String,
        dropdownValues: [String],
        configration: TextFieldConfigration? = nil,
        style: TextFieldStyle? = nil
    ) {
        self._text = selectedValue
        self.placeholder = placeholder
        self.type = .dropdown
        self.dropdownValues = dropdownValues
        self.configration = configration ?? TextFieldConfigration()
        self.style = style ?? TextFieldStyle()
        _inDateFormat = .constant(Date.now)
    }

    // otp field initlizer
    public init(
        otp: Binding<String>,
        count: Int,
        configration: TextFieldConfigration? = nil,
        style: TextFieldStyle? = nil
    ) {
        self._text = otp
        self.configration = configration ?? TextFieldConfigration()
        self.style = style ?? TextFieldStyle()
        self.placeholder = ""
        self.type = .otp
        self.otpCount = count
        _inDateFormat = .constant(Date.now)
    }

    public var body: some View {
        ZStack {
            switch type {
            case .text:
                textfield()
            case .secure:
                secureField()
            case .datePicker:
                datePickerField()
            case .dropdown:
                dropDownField()
            case .otp:
                otp()
            case .longText:
                longText()
            }
        }
    }
}

struct GenerateDropDownList: View {
    let data: [String]
    @Binding var selectedValue: String
    @Binding var toggle: Bool
    let configration: DropDownConfigration

    var body: some View {
        VStack {
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(data, id: \.self) { value in
                        Button(action: {
                            selectedValue = value
                            toggle.toggle()
                        }, label: {
                            Text(value)
                                .fontWeight(value == selectedValue ? configration.selectedTextFontWeight : configration.unselectedTextFontWeight)
                                .font(.subheadline)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading)
                                .background(value == selectedValue ? configration.selectedhighlightColor : configration.unselectedhighlightColor)
                                .cornerRadius(Theme.Radius.sm)
                                .foregroundColor(value == selectedValue ? configration.selectedTextColor : configration.unselectedTextColor)
                                .contentShape(RoundedRectangle(cornerRadius: Theme.Radius.sm))
                        }).buttonStyle(.plain)
                    }
                }
            }.frame(maxHeight: 200)
                .padding(4)
        }
    }
}

extension Textfield {

    @ViewBuilder
    func dropDownField() -> some View {
        GeometryReader { proxy in
            ZStack {
                WithPopover(
                    showPopover: $showDropDown,
                    popoverSize: CGSize(width: proxy.size.width, height: configration.popoverHeight),
                    arrowDirections: [.up, .down],
                    showArrow: false, content: {
                        HStack {
                            if let icon = configration.icon {
                                if icon.location == .left {
                                    switch icon.type {
                                    case .asset:
                                        Image(icon.name)
                                            .resizable()
                                            .frame(width: icon.width, height: icon.height)
                                            .foregroundStyle(showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                                    case .systemName:
                                        Image(systemName: icon.name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: icon.width, height: icon.height)
                                            .foregroundStyle(showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                                    }
                                }
                            }
                            Text(text)
                            Spacer()
                            Image(systemName: "chevron.down")
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: configration.maxWidth, maxHeight: configration.height)
                        .frame(minWidth: configration.width, minHeight: configration.height)
                        .mask(RoundedRectangle(cornerRadius: configration.cornerRadius))
                        .overlay(
                            RoundedRectangle(cornerRadius: configration.cornerRadius)
                                .stroke(
                                    style.unfocusedborderColor.opacity(0.6),
                                    lineWidth: configration.borderWidth
                                )
                        )
                        .placeholder(
                            when: text.isEmpty,
                            xOffset: configration.icon != nil ? configration.icon?.width ?? 0 : 0,
                            yOffset: configration.height,
                            focusColor: isFocus ? style.focusedborderColor : style.unfocusedborderColor,
                            type: configration.placeholderType
                        ) {
                            Text(placeholder)
                                .font(text.isEmpty ? .subheadline : .footnote)
                                .fontWeight(text.isEmpty ? .regular : .semibold)
                                .padding(.horizontal, text.isEmpty ? 0 : 4)
                                .background(configration.placeholderType == .floating ? AnyView(style.placeholderBackgroundColor.frame(height: 12)) : AnyView(Color.clear))
                                .padding(.leading)
                        }
                        .background(style.fillColor)
                        .contentShape(RoundedRectangle(cornerRadius: configration.cornerRadius))
                        .onTapGesture {
                            withAnimation {
                                if !(dropdownValues?.isEmpty ?? true) {
                                    showDropDown = true
                                }
                            }
                        }
                    },
                    popoverContent: {
                        GenerateDropDownList(
                            data: dropdownValues ?? [],
                            selectedValue: $text,
                            toggle: $showDropDown,
                            configration: configration.dropDownConfigration
                        )
                    }
                )
            }
        }.frame(height: configration.height)
    }

    @ViewBuilder
    func datePickerField() -> some View {
        VStack {
            HStack {
                if let icon = configration.icon {
                    if icon.location == .left {
                        switch icon.type {
                        case .asset:
                            Image(icon.name)
                                .resizable()
                                .frame(width: icon.width, height: icon.height)
                                .foregroundStyle(showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                                .padding(.leading)
                        case .systemName:
                            Image(systemName: icon.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: icon.width, height: icon.height)
                                .foregroundStyle(showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                                .padding(.leading)
                        }
                    }
                }
                Text(text)
                    .padding(.leading)
                Spacer()
                Image(systemName: "calendar")
                    .renderingMode(.template)
                    .padding(.trailing)
                    .foregroundColor(style.unfocusedIconColor)
            }
            .frame(maxWidth: configration.maxWidth, maxHeight: configration.height)
            .frame(minWidth: configration.width, minHeight: configration.height)
            .mask(RoundedRectangle(cornerRadius: configration.cornerRadius))
            .overlay(RoundedRectangle(cornerRadius: configration.cornerRadius)
                .stroke(configration.isError ? style.onErrorBorderColor : (isFocus ? style.focusedborderColor : style.unfocusedborderColor.opacity(0.6)), lineWidth: configration.borderWidth))
            .placeholder(when: text.isEmpty,
                         xOffset: configration.icon != nil ? configration.icon?.width ?? 0 : 0,
                         yOffset: configration.height,
                         focusColor: showErrorMsg ? style.onErrorBorderColor : isFocus ? style.focusedplaceholderTextColor : style.unfocusedplaceholderTextColor,
                         type: configration.placeholderType)
            {
                Text(placeholder)
                    .font(text.isEmpty ? .subheadline : .footnote)
                    .fontWeight(text.isEmpty ? .regular : .semibold)
                    .padding(.horizontal, text.isEmpty ? 0 : 4)
                    .background(configration.placeholderType == .floating ? AnyView(style.placeholderBackgroundColor.frame(height: 12)) : AnyView(Color.clear))
                    .padding(.leading)
            }
            .background(style.fillColor)
            .contentShape(RoundedRectangle(cornerRadius: configration.cornerRadius, style: .continuous))
            .overlay(
                DatePicker(
                    "",
                    selection: $selectedDate,
                    in: Date.distantPast ... Date.distantFuture,
                    displayedComponents: [.date]
                )
                .id(calendarId)
                .accentColor(style.calenderAccentColor)
                .blendMode(.destinationOver)
                .onTapGesture(count: 99, perform: {
                    // overrides tap gesture to fix ios 17.1 bug
                })
                .onChange(of: selectedDate, perform: { value in
                    text = DateToStr(date: value, format: configration.dateFormat)
                    inDateFormat = selectedDate
                    calendarId = UUID()
                })
            )
            if showErrorMsg {
                Text(configration.errorMessage)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(style.onErrorBorderColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onChange(of: configration.isError) { val in
            if val && configration.showErrorMsg {
                withAnimation { showErrorMsg = true }
            } else {
                withAnimation { showErrorMsg = false }
            }
        }
    }

    @ViewBuilder
    func secureField() -> some View {
        VStack {
            HStack {
                if let icon = configration.icon {
                    if icon.location == .left {
                        switch icon.type {
                        case .asset:
                            Image(icon.name)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: icon.width, height: icon.height)
                                .foregroundStyle(showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                                .padding(.leading)
                        case .systemName:
                            Image(systemName: icon.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: icon.width, height: icon.height)
                                .foregroundStyle(showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                                .padding(.leading)
                        }
                    }
                }

                ZStack {
                    switch isVisible {
                    case true:
                        TextField("", text: $text)
                            .focused($isFocus)
                            .autocapitalization(.none)
                            .accentColor(style.textColor)
                            .font(.custom_font_m14_t18_en)
                            .submitLabel(.done)
                            .onSubmit { isFocus = false }
                    case false:
                        SecureField("", text: $text)
                            .focused($isFocus)
                            .autocapitalization(.none)
                            .accentColor(style.textColor)
                            .font(.custom_font_m14_t18_en)
                            .submitLabel(.done)
                            .onSubmit { isFocus = false }
                    }
                }
                Button(action: {
                    DispatchQueue.main.async { isVisible.toggle() }
                }, label: {
                    Image(systemName: self.isVisible ? "eye.slash" : "eye")
                        .renderingMode(.template)
                        .foregroundStyle(self.isFocus ? style.focusedIconColor : style.unfocusedIconColor)
                        .padding(.horizontal, 10)
                }).buttonStyle(.plain)
            }
            .frame(maxWidth: configration.maxWidth, maxHeight: configration.height)
            .frame(minWidth: configration.width, minHeight: configration.height)
            .mask(RoundedRectangle(cornerRadius: configration.cornerRadius))
            .overlay(RoundedRectangle(cornerRadius: configration.cornerRadius)
                .stroke(configration.isError ? style.onErrorBorderColor : (isFocus ? style.focusedborderColor : style.unfocusedborderColor), lineWidth: configration.borderWidth))
            .animation(.easeInOut(duration: 0.3), value: isFocus)
            .placeholder(
                when: text.isEmpty,
                xOffset: configration.icon != nil ? configration.icon?.width ?? 0 : 0,
                yOffset: configration.height,
                focusColor: showErrorMsg ? style.onErrorBorderColor : isFocus ? style.focusedplaceholderTextColor : style.unfocusedplaceholderTextColor,
                type: configration.placeholderType
            ) {
                Text(placeholder)
                    .font(.custom_font_m14_t18_en)
                    .fontWeight(text.isEmpty ? .regular : .semibold)
                    .padding(.horizontal, text.isEmpty ? 0 : 4)
                    .background(configration.placeholderType == .floating ? AnyView(style.placeholderBackgroundColor.frame(height: 12)) : AnyView(Color.clear))
                    .padding(.leading)
            }
            .background(style.fillColor)
            .padding(1)
            .clipShape(RoundedRectangle(cornerRadius: configration.cornerRadius))
            if configration.showErrorMsg {
                Text(configration.errorMessage)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(style.onErrorBorderColor)
                    .frame(maxWidth: configration.maxWidth, alignment: .leading)
            }
        }
        .onChange(of: configration.isError) { val in
            if val && configration.showErrorMsg {
                withAnimation { showErrorMsg = true }
            } else {
                withAnimation { showErrorMsg = false }
            }
        }
    }

    @ViewBuilder
    func textfield() -> some View {
        VStack {
            HStack {
                if let icon = configration.icon {
                    if icon.location == .left {
                        switch icon.type {
                        case .asset:
                            Image(icon.name)
                                .resizable()
                                .renderingMode(.template)
                                .frame(width: icon.width, height: icon.height)
                                .foregroundColor(configration.showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                        case .systemName:
                            Image(systemName: icon.name)
                                .resizable()
                                .scaledToFit()
                                .frame(width: icon.width, height: icon.height)
                                .foregroundColor(configration.showErrorMsg ? style.onErrorBorderColor : isFocus ? icon.color : icon.unfocusedColor)
                        }
                    }
                }
                TextField("", text: $text)
                    .focused($isFocus)
                    .autocapitalization(.none)
                    .foregroundStyle(style.textColor)
                    .accentColor(style.textColor)
                    .font(.custom_font_m14_t18_en)
                    .submitLabel(.done)
                    .onSubmit { isFocus = false }
            }
            .padding(.leading)
            .frame(maxWidth: configration.maxWidth, maxHeight: configration.height)
            .frame(minWidth: configration.width, minHeight: configration.height)
            .overlay(RoundedRectangle(cornerRadius: configration.cornerRadius)
                .stroke(configration.isError ? style.onErrorBorderColor : (isFocus ? style.focusedborderColor : style.unfocusedborderColor), lineWidth: configration.borderWidth))
            .placeholder(
                when: text.isEmpty,
                xOffset: configration.icon != nil ? configration.icon?.width ?? 0 : 0,
                yOffset: configration.height,
                focusColor: showErrorMsg ? style.onErrorBorderColor : isFocus ? style.focusedplaceholderTextColor : style.unfocusedplaceholderTextColor,
                type: configration.placeholderType
            ) {
                Text(placeholder)
                    .font(.custom_font_m14_t18_en)
                    .fontWeight(text.isEmpty ? .regular : .semibold)
                    .padding(.leading, configration.icon != nil ? 6 : 0)
                    .padding(.horizontal, text.isEmpty ? 0 : 4)
                    .background(configration.placeholderType == .floating ? AnyView(style.placeholderBackgroundColor.frame(height: 12)) : AnyView(Color.clear))
                    .padding(.leading, 10)
            }
            .padding(1)
            .background(style.fillColor)
            .mask(RoundedRectangle(cornerRadius: configration.cornerRadius))

            if configration.showErrorMsg {
                Text(configration.errorMessage)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(style.onErrorBorderColor)
                    .frame(maxWidth: configration.maxWidth, alignment: .leading)
            }
        }
        .onChange(of: configration.isError) { val in
            if val && configration.showErrorMsg {
                withAnimation { showErrorMsg = true }
            } else {
                withAnimation { showErrorMsg = false }
            }
        }
    }

    @ViewBuilder
    func longText() -> some View {
        VStack {
            VStack {
                DoneToolbarTextEditor(text: $text, isFocused: $isLongTextFocused)
                    .foregroundColor(.nfsTextBW)
                    .onChange(of: isLongTextFocused) { newValue in
                        isFocus = newValue
                    }
                    .onChange(of: isFocus) { newValue in
                        if isLongTextFocused != newValue {
                            isLongTextFocused = newValue
                        }
                    }
                    .overlay(content: {
                        VStack {
                            HStack {
                                Text(placeholder)
                                    .font(text.isEmpty ? .subheadline : .footnote)
                                    .fontWeight(text.isEmpty ? .regular : .semibold)
                                    .foregroundStyle(.gray)
                                    .padding(.horizontal, text.isEmpty ? 0 : 4)
                                    .padding(.top, 10)
                                    .padding(.leading, 4)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .opacity(text.isEmpty ? 1 : 0)
                                Spacer()
                            }
                            Spacer()
                        }
                        .allowsHitTesting(text.isEmpty && !isLongTextFocused)
                        .onTapGesture {
                            isLongTextFocused = true
                        }
                    })
            }
            .padding(.leading, 8)
            .frame(maxWidth: configration.maxWidth, maxHeight: configration.height)
            .frame(minWidth: configration.width, minHeight: configration.height)
            .mask(RoundedRectangle(cornerRadius: configration.cornerRadius))
            .overlay(RoundedRectangle(cornerRadius: configration.cornerRadius)
                .stroke(configration.isError ? style.onErrorBorderColor : (isFocus ? style.focusedborderColor : style.unfocusedborderColor), lineWidth: configration.borderWidth))
            .background(style.fillColor)
            .padding(1)
            .clipShape(RoundedRectangle(cornerRadius: configration.cornerRadius))
            if showErrorMsg {
                Text(configration.errorMessage)
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(style.onErrorBorderColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: isFocus)
        .onChange(of: configration.isError) { val in
            if val && configration.showErrorMsg {
                withAnimation { showErrorMsg = true }
            } else {
                withAnimation { showErrorMsg = false }
            }
        }
    }

    @ViewBuilder
    func otp() -> some View {
        ZStack {
            OTPUIKitTextField(text: $text.limit(otpCount ?? 6), isFirstResponder: $isOtpFocus)
                .frame(width: 1, height: 1)
                .opacity(0.01)

            HStack(spacing: configration.otpSpacing) {
                ForEach(0 ..< (otpCount ?? 0), id: \.self) { i in
                    OTPTextBox(i)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isOtpFocus = true
            }
        }
    }

    // OTP Text box
    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if self.text.count > index {
                let startIndex = self.text.startIndex
                let charIndex = self.text.index(startIndex, offsetBy: index)
                let charString = String(text[charIndex])
                Text(charString)
                    .font(.headline)
            } else {}
        }.frame(width: configration.otpFieldWidth, height: configration.otpFieldHeight)
            .background(
                RoundedRectangle(cornerRadius: configration.cornerRadius, style: .continuous)
                    .stroke(configration.isError ? style.onErrorBorderColor : ((isOtpFocus && text.count == index) ? style.focusedborderColor : style.unfocusedborderColor), lineWidth: (isOtpFocus && text.count == index) ? style.focusedborderWidth : style.unfocusedborderWidth)
            )
    }

    func DateToStr(date: Date, format: String) -> String {
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale.current
        timeFormatter.timeZone = TimeZone.current
        timeFormatter.dateFormat = format
        let nowTimestr = timeFormatter.string(from: date)
        return nowTimestr
    }
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        xOffset: CGFloat,
        yOffset: CGFloat,
        focusColor: Color,
        alignment: Alignment = .leading,
        type: PlaceholderType,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder()
                .foregroundColor(shouldShow ? .gray : focusColor)
                .offset(x: shouldShow ? xOffset + 7 : 0, y: shouldShow ? 0 : type == .floating ? -(yOffset / 2) : 0)
                .animation(type == .floating ? .easeInOut : .none, value: shouldShow)
                .zIndex(shouldShow ? 0 : 2)
                .opacity((type == .plain && !shouldShow) ? 0 : 1)
            self
        }
    }
}

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if wrappedValue.count > length {
            wrappedValue = String(wrappedValue.prefix(length))
        }
        return self
    }
}

// MARK: - OTP UIKit field

class OTPUITextField: UITextField {
    var onDone: (() -> Void)?

    override var canBecomeFirstResponder: Bool { true }

    func addDoneToolbar(onDone: @escaping () -> Void) {
        self.onDone = onDone
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneTapped))
        doneButton.tintColor = UIColor.systemBlue
        toolbar.items = [flexSpace, doneButton]
        self.inputAccessoryView = toolbar
    }

    @objc private func doneTapped() {
        self.resignFirstResponder()
        onDone?()
    }
}

struct OTPUIKitTextField: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFirstResponder: Bool

    func makeUIView(context: Context) -> OTPUITextField {
        let textField = OTPUITextField()
        textField.keyboardType = .numberPad
        textField.textContentType = .oneTimeCode
        textField.delegate = context.coordinator
        textField.isHidden = true
        textField.addDoneToolbar {
            isFirstResponder = false
        }
        return textField
    }

    func updateUIView(_ uiView: OTPUITextField, context: Context) {
        uiView.text = text
        if isFirstResponder && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFirstResponder && uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator { Coordinator(self) }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: OTPUIKitTextField
        init(_ parent: OTPUIKitTextField) { self.parent = parent }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            parent.text = textField.text ?? ""
        }
    }
}

// MARK: - DoneToolbarTextEditor (multi-line long text)

struct DoneToolbarTextEditor: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool

    func makeUIView(context: Context) -> UITextView {
        _ = NFSFonts.registerAll
        let textView = UITextView()
        textView.delegate = context.coordinator
        textView.backgroundColor = .clear
        textView.isScrollEnabled = true
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        textView.textContainer.lineFragmentPadding = 0
        let fontSize: CGFloat = UIDevice.current.userInterfaceIdiom == .phone ? 13 : 16
        textView.font = UIFont(name: Theme.Typography.regularFontName, size: fontSize)

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: textView, action: #selector(UIResponder.resignFirstResponder))
        done.tintColor = .systemBlue
        toolbar.items = [flex, done]
        textView.inputAccessoryView = toolbar

        return textView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
        if isFocused && !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        } else if !isFocused && uiView.isFirstResponder {
            uiView.resignFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextViewDelegate {
        var parent: DoneToolbarTextEditor

        init(_ parent: DoneToolbarTextEditor) {
            self.parent = parent
        }

        func textViewDidChange(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.text = textView.text
            }
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isFocused = true
            }
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            DispatchQueue.main.async {
                self.parent.isFocused = false
            }
        }
    }
}
