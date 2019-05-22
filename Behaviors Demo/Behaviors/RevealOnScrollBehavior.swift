//
//  RevealOnScrollBehavior.swift
//  Behaviors Demo
//
//  Created by Michael Skiba on 23/05/2019.
//  Copyright © 2019 Shape. All rights reserved.
//

import UIKit

protocol RevealOnScrollBehaviorDelegate: AnyObject {
    func reachedTargetScrollPercent()
}

class RevealOnScrollBehavior: UIViewController & Behavior {
    private weak var revealDelegate: RevealOnScrollBehaviorDelegate?
    private weak var scrollView: UIScrollView?
    private let targetScrollPercent: CGFloat
    private var hasReachedScrollPercent: Bool = false
    private var observer: NSKeyValueObservation?

    init(scrollView: UIScrollView, scrollPercent: CGFloat, delegate: RevealOnScrollBehaviorDelegate) {
        self.scrollView = scrollView
        revealDelegate = delegate
        targetScrollPercent = scrollPercent
        super.init(nibName: nil, bundle: nil)
        let respond: (UIScrollView, NSKeyValueObservedChange<CGPoint>) -> Void = { [weak self] scrollview, update in
            guard let scrollOffset = update.newValue?.y else { return }
            self?.updateScrollState(scrollView: scrollView, scrollOffset: scrollOffset)
        }
        observer = scrollView.observe(\UIScrollView.contentOffset,
                                      options: [.new, .initial],
                                      changeHandler: respond)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reset() {
        hasReachedScrollPercent = false
        if let scrollView = scrollView {
            updateScrollState(scrollView: scrollView, scrollOffset: scrollView.contentOffset.y)
        }
    }

    func updateScrollState(scrollView: UIScrollView, scrollOffset: CGFloat) {
        guard !hasReachedScrollPercent else { return }
        let contentHeight = scrollView.contentSize.height
        let totalOffset = scrollOffset + scrollView.frame.height
        guard contentHeight != 0 else { return }
        let offset = totalOffset / contentHeight
        if offset >= targetScrollPercent {
            hasReachedScrollPercent = true
            revealDelegate?.reachedTargetScrollPercent()
        }
    }
}
