//
//  KPKToggleButton.swift
//  NFSComponents
//

import SwiftUI

public struct KPKToggleButton: View {
    @Binding var isTapped: Bool
    let onTap: () -> Bool

    public init(isTapped: Binding<Bool>, onTap: @escaping () -> Bool) {
        self._isTapped = isTapped
        self.onTap = onTap
    }

    private let capsuleWidth: Double   = UIDevice.isIPhone ? 28 : 52
    private let capsuleHeight: Double  = UIDevice.isIPhone ? 16 : 30
    private let circleDiameter: Double = UIDevice.isIPhone ? 8 : 16
    private let borderWidth: Double    = UIDevice.isIPhone ? 1.5 : 2
    private let innerPadding: Double   = UIDevice.isIPhone ? 4 : 6
    private let activeOffset: Double   = UIDevice.isIPhone ? 12 : 24

    public var body: some View {
        Button {
            if isTapped {
                withAnimation { isTapped = false }
            } else {
                withAnimation {
                    if onTap() { isTapped = true }
                }
            }
        } label: {
            ZStack(alignment: .leading) {
                Capsule()
                    .frame(width: capsuleWidth, height: capsuleHeight)
                    .foregroundStyle(isTapped ? Theme.Colors.icon : Theme.Colors.backgroundElevated)
                    .overlay(
                        Capsule().stroke(Theme.Colors.icon, lineWidth: borderWidth)
                    )

                Circle()
                    .frame(width: circleDiameter, height: circleDiameter)
                    .foregroundStyle(Theme.Colors.backgroundElevated)
                    .overlay(
                        Circle().stroke(
                            isTapped ? Theme.Colors.backgroundElevated : Theme.Colors.icon,
                            lineWidth: borderWidth
                        )
                    )
                    .padding(.horizontal, innerPadding)
                    .offset(x: isTapped ? activeOffset : 0)
            }
        }
        .buttonStyle(.plain)
    }
}
