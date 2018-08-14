import Foundation

public class KeyboardStateCallback {
    
    public typealias KeyboardStateChangeClosure = ((_ fromFrame: CGRect, _ toFrame: CGRect, _ duration: TimeInterval, _ curve: UIViewAnimationCurve) -> Void)
    
    var keyboardWillShowClosure: KeyboardStateChangeClosure?
    var keyboardDidShowClosure: KeyboardStateChangeClosure?
    var keyboardWillHideClosure: KeyboardStateChangeClosure?
    var keyboardDidHideClosure: KeyboardStateChangeClosure?
    
    public convenience init(willShow: KeyboardStateChangeClosure?,
                     didShow: KeyboardStateChangeClosure?,
                     willHide: KeyboardStateChangeClosure?,
                     didHide: KeyboardStateChangeClosure?) {
        self.init()
        
        self.keyboardWillShowClosure = willShow
        self.keyboardDidShowClosure = didShow
        self.keyboardWillHideClosure = willHide
        self.keyboardDidHideClosure = didHide
    }
}

public class KeyboardState {
    
    public static var shared: KeyboardState = {
        let instance = KeyboardState()
        return instance
    }()
    
    public var keyboardFrame: CGRect = .zero
    private(set) var keyboardIsShowing: Bool = false
    
    private var listeners = [NSObjectProtocol]()
    
    private var subscribers = NSMapTable<AnyObject, KeyboardStateCallback>(keyOptions: NSPointerFunctions.Options.weakMemory,
                                                                           valueOptions: NSPointerFunctions.Options.weakMemory)
    
    deinit {
        subscribers.removeAllObjects()
        listeners.forEach { NotificationCenter.default.removeObserver($0) }
    }
    
    public func startListening() {
        guard listeners.count == 0 else {
            print("Already listening to keyboard")
            return
        }
        
        listeners.append(contentsOf: [
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: nil, using: { [weak self] notification in
                if let toFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                    self?.keyboardFrame = toFrame.cgRectValue
                }
                self?.callSubscribers(notification: notification)
            }),
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidShow, object: nil, queue: nil, using: { [weak self] notification in
                self?.keyboardIsShowing = true
                self?.callSubscribers(notification: notification)
            }),
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillHide, object: nil, queue: nil, using: { [weak self] notification in
                if let toFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                    self?.keyboardFrame = toFrame.cgRectValue
                }
                self?.callSubscribers(notification: notification)
            }),
            NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardDidHide, object: nil, queue: nil, using: { [weak self] notification in
                self?.keyboardIsShowing = false
                self?.callSubscribers(notification: notification)
            })
            ])
    }
    
    @objc func keyboardDidChange(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            self.keyboardFrame = keyboardFrame
        }
    }
    
    public func addSubscriber(_ subscriber: AnyObject, stateCallback: KeyboardStateCallback) {
        subscribers.setObject(stateCallback, forKey: subscriber)
    }
    
    public func removeSubscriber(_ subscriber: AnyObject) {
        subscribers.removeObject(forKey: subscriber)
    }
    
    private func callSubscribers(notification: Notification) {
        
        guard let fromFrame = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
            let toFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = UIViewAnimationCurve(rawValue: ((notification.userInfo?[UIKeyboardAnimationCurveUserInfoKey] as? Int) ?? UIViewAnimationCurve.linear.rawValue)) else {
                assertionFailure("Unable to get some info from the notification")
                return
        }
        
        for sub in subscribers.keyEnumerator() {
            let subscriber = sub as AnyObject
            if let keyboardStateCallback = subscribers.object(forKey: subscriber) {
                switch notification.name {
                case Notification.Name.UIKeyboardWillShow:
                    keyboardStateCallback.keyboardWillShowClosure?(fromFrame, toFrame, duration, curve)
                case Notification.Name.UIKeyboardDidShow:
                    keyboardStateCallback.keyboardDidShowClosure?(fromFrame, toFrame, duration, curve)
                case Notification.Name.UIKeyboardWillHide:
                    keyboardStateCallback.keyboardWillHideClosure?(fromFrame, toFrame, duration, curve)
                case Notification.Name.UIKeyboardDidHide:
                    keyboardStateCallback.keyboardDidHideClosure?(fromFrame, toFrame, duration, curve)
                default:
                    assertionFailure("Unhandled Notification.Name: \(notification.name)")
                }
            }
        }
    }
}

public extension UIViewAnimationOptions {
    init(curve: UIViewAnimationCurve) {
        switch curve {
        case .easeIn:
            self = .curveEaseIn
        case .easeOut:
            self = .curveEaseOut
        case .easeInOut:
            self = .curveEaseInOut
        case .linear:
            self = .curveLinear
        }
    }
}
