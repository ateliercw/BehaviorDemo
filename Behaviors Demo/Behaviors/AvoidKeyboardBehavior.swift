//
//  AvoidKeyboardBehavior.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 23/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

protocol AvoidKeyboardBehaviorDelegate: AnyObject {
    var view: UIView! { get }
    var keyboardSafeAreaInsets: UIEdgeInsets { get set }
}

extension AvoidKeyboardBehaviorDelegate where Self: UIViewController {
    var keyboardSafeAreaInsets: UIEdgeInsets {
        get { return additionalSafeAreaInsets }
        set { additionalSafeAreaInsets = newValue }
    }
}

class AvoidKeyboardBehavior: UIViewController & Behavior {
    private weak var scrollView: UIScrollView?
    private weak var avoidKeyboardDelegate: AvoidKeyboardBehaviorDelegate?

    init(scrollView: UIScrollView, delegate: AvoidKeyboardBehaviorDelegate) {
        self.scrollView = scrollView
        avoidKeyboardDelegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startMonitoringKeyboard()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopMonitoringKeyboard()
    }

    private func startMonitoringKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(handleKeyboardUpdate),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }

    @objc private func handleKeyboardUpdate(notification: Notification) {
        guard let frame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
            let viewFrame = avoidKeyboardDelegate?.view.window?.convert(frame, to: avoidKeyboardDelegate?.view),
            let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let firstResponder = scrollView?.firstResponder
            else { return }
        let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve
        let options = curve.map(UIView.AnimationOptions.init(curve:)) ?? []
        let animation: () -> Void = { [weak scrollView, weak avoidKeyboardDelegate] in
            guard let scrollView = scrollView,
                let avoidKeyboardDelegate = avoidKeyboardDelegate else { return }
            avoidKeyboardDelegate.keyboardSafeAreaInsets.bottom =
                viewFrame.height - avoidKeyboardDelegate.view.safeAreaInsets.bottom

            let responderFrame = firstResponder.convert(firstResponder.frame, to: scrollView)
            let expansion = UIEdgeInsets(top: 0, left: 0, bottom: -16, right: 0)
            scrollView.scrollRectToVisible(responderFrame.inset(by: expansion), animated: false)
        }
        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: options,
                       animations: animation,
                       completion: nil)
    }

    private func stopMonitoringKeyboard() {
        NotificationCenter.default.removeObserver(self,
                                                  name: UIResponder.keyboardWillChangeFrameNotification,
                                                  object: nil)
    }
}

private extension UIView.AnimationOptions {
    init(curve: UIView.AnimationCurve) {
        switch curve {
        case .easeIn: self = .curveEaseIn
        case .easeInOut: self = .curveEaseInOut
        case .easeOut: self = .curveEaseOut
        case .linear: self = .curveLinear
        @unknown default: self = []
        }
    }
}

private extension UIView {
    var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        return subviews.lazy.compactMap { $0.firstResponder }.first
    }
}
