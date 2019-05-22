## Reducing duplicated code with behavior injection

---

## This is inspired by:

- [Lifecycle Behaviors - Brian Irace](https://irace.me/lifecycle-behaviors)
- [Smarter Animated Row  Deselection - Zev Eisenberg](https://www.raizlabs.com/dev/2016/05/smarter-animated-row-deselection-ios/)

---

## Why?

- Shared code without common ancestors
- No need to remember which lifecycle events to overrride

^ There are behaviors that are common within an app, particularly ones that are related to `UIViewController` lifecycle events that we don’t want to shove into a shared superclass, still require remembering to override methods if they’re implemented in protocols, and can end up being implemented slightly differently for different cases.

---

## How?

```swift
protocol Behavior {}

extension UIViewController {
    func inject(_ behavior: UIViewController & Behavior) {
        view.addSubview(behavior.view)
        behavior.view.isHidden = true
        addChild(behavior)
    }
}
```

^ It's just a wrapper around child view controllers

^ We could do this without the protocol or the `inject` function, but these add a bit of safety in that it required the injected behavior to explicitly conform to a protocol, and it handles adding the view, hiding the behavior’s view and adding it as a child view controller.

---

## In use:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // other setup code
    inject(DeselectOnViewWillAppearBehavior(tableView: tableView))
    inject(AvoidKeyboardBehavior(scrollView: tableView, delegate: self))
    inject(RevealOnScrollBehavior(scrollView: tableView, scrollPercent: 1, delegate: self))
}
```

^ Since `inject` is going to load the view, behaviors should be injected on `viewDidLoad` instead of `init`.

---

## Use cases

- Deselecting cells on view will appear
- End editing on disappear
- Avoiding the keyboard in tables / scrollviews
- Performing an action when the table has scrolled to a certain percentage
- Analytics

---

## From experience...

- Keep it simple
- There are places this won't work like `UINavigationController`

^ This simplified compared to the original implementation, this keeps it closer to stock UIKit, and keeps most of the advantages.
^ Another thing to avoid is going down the rabbit hole of trying to automate injection of behaviors into every view controller via swizzling.

---

# Demo time!
