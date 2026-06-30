//
//  WithPopOver.swift
//  NFSComponents
//
//  UIKit-popover bridge used by the dropdown text field to anchor a popover
//  list to the field on both iPhone and iPad.
//

import SwiftUI

class CustomPopoverBackgroundView: UIPopoverBackgroundView {
    private var arrowView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(arrowView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubview(arrowView)
    }

    override class func arrowBase() -> CGFloat { 0.0 }

    override class func arrowHeight() -> CGFloat { 10.0 }

    override func layoutSubviews() {
        super.layoutSubviews()

        let arrowSize = CGSize(width: CustomPopoverBackgroundView.arrowBase(), height: CustomPopoverBackgroundView.arrowHeight())
        arrowView.frame = CGRect(origin: CGPoint(x: bounds.midX - arrowSize.width / 2, y: bounds.maxY - arrowSize.height), size: arrowSize)

        let arrowLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: arrowSize.width / 2, y: 0))
        path.addLine(to: CGPoint(x: 0, y: arrowSize.height))
        path.addLine(to: CGPoint(x: arrowSize.width, y: arrowSize.height))
        path.close()

        arrowLayer.path = path.cgPath
        arrowLayer.fillColor = UIColor.white.cgColor
        arrowView.layer.addSublayer(arrowLayer)

        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 0.0
        layer.shadowRadius = 0.0
    }

    override static func contentViewInsets() -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override var arrowOffset: CGFloat {
        get { 0 }
        set {}
    }

    override var arrowDirection: UIPopoverArrowDirection {
        get { .down }
        set {}
    }

    var showArrow: Bool {
        get { true }
        set {}
    }
}

struct WithPopover<Content: View, PopoverContent: View>: View {

    @Binding var showPopover: Bool
    var popoverSize: CGSize? = nil
    var arrowDirections: UIPopoverArrowDirection = [.any]
    var showArrow: Bool = true
    let content: () -> Content
    let popoverContent: () -> PopoverContent

    var body: some View {
        content()
            .background(
                Wrapper(showPopover: $showPopover, arrowDirections: arrowDirections, popoverSize: popoverSize, showArrow: showArrow, popoverContent: popoverContent)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
    }

    struct Wrapper<CustomPopoverContent: View>: UIViewControllerRepresentable {

        @Binding var showPopover: Bool
        var arrowDirections: UIPopoverArrowDirection
        let popoverSize: CGSize?
        let showArrow: Bool
        let popoverContent: () -> CustomPopoverContent

        func makeUIViewController(context: UIViewControllerRepresentableContext<Wrapper<CustomPopoverContent>>) -> WrapperViewController<CustomPopoverContent> {
            WrapperViewController(
                popoverSize: popoverSize,
                permittedArrowDirections: arrowDirections, showArrow: showArrow,
                popoverContent: popoverContent
            ) {
                self.showPopover = false
            }
        }

        func updateUIViewController(_ uiViewController: WrapperViewController<CustomPopoverContent>,
                                    context: UIViewControllerRepresentableContext<Wrapper<CustomPopoverContent>>) {
            if showPopover {
                uiViewController.showPopover()
            } else {
                uiViewController.hidePopover()
            }
        }
    }

    class WrapperViewController<CPopoverContent: View>: UIViewController, UIPopoverPresentationControllerDelegate {

        var popoverSize: CGSize?
        let permittedArrowDirections: UIPopoverArrowDirection
        let showArrow: Bool
        let popoverContent: () -> CPopoverContent
        let onDismiss: () -> Void

        var popoverVC: UIViewController?

        required init?(coder: NSCoder) { fatalError("") }
        init(popoverSize: CGSize?,
             permittedArrowDirections: UIPopoverArrowDirection,
             showArrow: Bool,
             popoverContent: @escaping () -> CPopoverContent,
             onDismiss: @escaping () -> Void) {
            self.popoverSize = popoverSize
            self.permittedArrowDirections = permittedArrowDirections
            self.showArrow = showArrow
            self.popoverContent = popoverContent
            self.onDismiss = onDismiss
            super.init(nibName: nil, bundle: nil)
        }

        override func viewDidLoad() {
            super.viewDidLoad()
        }

        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            .none // this is what forces popovers on iPhone
        }

        func showPopover() {
            guard popoverVC == nil else { return }
            let vc = UIHostingController(rootView: popoverContent())
            if let size = popoverSize { vc.preferredContentSize = size }
            vc.modalPresentationStyle = UIModalPresentationStyle.popover
            if let popover = vc.popoverPresentationController {
                popover.sourceView = view
                popover.permittedArrowDirections = self.permittedArrowDirections
                popover.delegate = self
                if !showArrow {
                    popover.popoverBackgroundViewClass = CustomPopoverBackgroundView.self
                }
            }

            popoverVC = vc
            self.present(vc, animated: true, completion: nil)
        }

        func hidePopover() {
            guard let vc = popoverVC, !vc.isBeingDismissed else { return }
            vc.dismiss(animated: true, completion: nil)
            popoverVC = nil
        }

        func presentationControllerWillDismiss(_ presentationController: UIPresentationController) {
            popoverVC = nil
            self.onDismiss()
        }
    }
}
