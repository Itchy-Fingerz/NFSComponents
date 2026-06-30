//
//  ToastNotificationCore.swift
//  NFSComponents
//
//  A lightweight floating toast/banner. Attach `.toastBanner()` once near the
//  root of your view hierarchy and drive it from anywhere with
//  `ToastState.show(...)`.
//

import SwiftUI

public final class ToastState: ObservableObject {
    @Published public var toggle: Bool = false
    @Published public var type: BannerType
    @Published public var style: BannerStyle
    @Published public var heading: String
    @Published public var body: String
    @Published public var timeout = 4

    public static let shared = ToastState(type: .info, heading: "", body: "")

    public init(type: BannerType, heading: String, body: String) {
        self.type = type
        self.style = .longFloating
        self.heading = heading
        self.body = body
    }

    public init(type: BannerType, body: String) {
        self.type = type
        self.style = .shortFloating
        self.heading = ""
        self.body = body
    }

    public func setData(data: ToastState) {
        self.type = data.type
        self.style = data.style
        self.heading = data.heading
        self.body = data.body
    }

    /// Presents the shared toast. Pass a `heading` for the larger two-line
    /// style, omit it for the compact single-line style.
    public static func show(
        type: BannerType,
        heading: String? = nil,
        body: String,
        timeout: Int = 4
    ) {
        shared.type = type
        shared.style = (heading?.isEmpty ?? true) ? .shortFloating : .longFloating
        shared.heading = heading ?? ""
        shared.body = body
        shared.timeout = timeout
        shared.toggle = true
    }
}

public enum BannerStyle {
    case shortFloating, longFloating
}

public enum BannerType {
    case info, success, failure, warning

    var icon: String {
        switch self {
        case .failure: return "xmark.octagon.fill"
        case .success: return "checkmark.circle.fill"
        case .info:    return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        }
    }

    var color: Color {
        switch self {
        case .failure: return Theme.Colors.Toast.error
        case .success: return Theme.Colors.Toast.success
        case .info:    return Theme.Colors.Toast.green
        case .warning: return .orange
        }
    }

    var backgroundColor: Color {
        switch self {
        case .failure, .success, .warning: return .white
        case .info: return Theme.Colors.backgroundElevated
        }
    }
}

public struct ToastContainer: View {
    @ObservedObject var data = ToastState.shared

    public init() {}

    public var body: some View {
        ZStack {
            if data.toggle {
                switch data.style {
                case .shortFloating: shortFloatingBanner
                case .longFloating:  longFloatingBanner
                }
            }
        }
        .ignoresSafeArea()
        .padding(.top)
    }

    private var shortFloatingBanner: some View {
        HStack(spacing: Theme.Spacing.sm) {
            bannerIcon
            Text(data.body)
                .font(Theme.Typography.bodyMedium)
        }
        .padding(.horizontal, Theme.Spacing.lg)
        .padding(.vertical, Theme.Spacing.sm)
        .background(Theme.Colors.backgroundElevated)
        .clipShape(Capsule())
        .shadow(Theme.Shadow.subtle)
    }

    private var longFloatingBanner: some View {
        HStack(spacing: 0) {
            Rectangle()
                .fill(data.type.color)
                .frame(width: 10)

            VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                HStack(spacing: Theme.Spacing.sm) {
                    bannerIcon
                    Text(data.heading)
                        .font(Theme.Typography.custom(iPhone: 14, iPad: 20, weight: .semibold))
                }
                Text(data.body)
                    .font(Theme.Typography.titleSmall)
            }
            .padding()

            Spacer(minLength: 0)
        }
        .fixedSize(horizontal: false, vertical: true)
        .background(Theme.Colors.backgroundElevated)
        .clipShape(RoundedRectangle(cornerRadius: Theme.Radius.sm, style: .continuous))
        .shadow(color: Theme.Colors.textPrimary.opacity(0.3), radius: 6, x: 2, y: 2)
        .padding([.horizontal, .bottom])
        .frame(maxWidth: 600)
    }

    private var bannerIcon: some View {
        Image(systemName: data.type.icon)
            .resizable()
            .renderingMode(.template)
            .scaledToFit()
            .frame(width: UIDevice.isIPhone ? 26 : 32)
            .foregroundStyle(data.type.color)
    }
}

public struct BannerModifier: AnimatableModifier {
    @ObservedObject var data = ToastState.shared
    @State private var opacity = 0.0
    @State private var showToggle = false

    public init() {}

    public func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            content

            ToastContainer()
                .opacity(opacity)
                .transition(.move(edge: .top))
                .onChange(of: data.toggle) { val in
                    if val {
                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(data.timeout)) {
                            withAnimation {
                                showToggle = false
                                opacity = 0.0
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                    data.toggle = false
                                }
                            }
                        }
                    }
                }
                .offset(y: showToggle ? 0 : -UIScreen.screenHeight)
        }
        .animation(.easeInOut(duration: 0.7), value: data.toggle)
        .onChange(of: data.toggle) { val in
            if val {
                withAnimation(.easeInOut(duration: 0.7)) {
                    showToggle = val
                    opacity = 1.0
                }
            }
        }
    }
}

public extension View {
    /// Attaches the floating toast host. Apply once near the root of your view
    /// tree; trigger it anywhere via `ToastState.show(...)`.
    func toastBanner() -> some View {
        modifier(BannerModifier())
    }
}

extension UIScreen {
    static var topSafeArea: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .first(where: { $0.activationState == .foregroundActive })?
            .windows
            .first(where: \.isKeyWindow)?
            .safeAreaInsets.top ?? 0
    }
}
